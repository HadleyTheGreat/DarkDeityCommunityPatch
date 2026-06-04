#pragma once

#include <windows.h>

#include <filesystem>
#include <fstream>
#include <optional>
#include <regex>
#include <string>
#include <vector>


class SteamLocator
{
public:
    static std::optional<std::wstring> GetSteamInstallPath()
    {
        HKEY hKey = nullptr;

        if (RegOpenKeyExW(
            HKEY_CURRENT_USER,
            L"Software\\Valve\\Steam",
            0,
            KEY_READ,
            &hKey) != ERROR_SUCCESS)
        {
            return std::nullopt;
        }

        auto closeKey = [&]()
            {
                if (hKey)
                    RegCloseKey(hKey);
            };

        auto steamPath = ReadRegistryString(hKey, L"SteamPath");

        if (!steamPath)
        {
            auto steamExe = ReadRegistryString(hKey, L"SteamExe");

            if (steamExe)
            {
                steamPath = std::filesystem::path(*steamExe)
                    .parent_path()
                    .wstring();
            }
            else
                return std::nullopt;
        }

        closeKey();
        for (wchar_t& ch : *steamPath)
        {
            if (ch == L'/')
                ch = L'\\';
        }
        return steamPath;
    }

    static std::optional<std::filesystem::path>
        GetGameInstallPath(uint32_t appId)
    {
        auto steamPath = GetSteamInstallPath();

        if (!steamPath)
            return std::nullopt;

        for (const auto& library : GetSteamLibraries(*steamPath))
        {
            auto manifestPath =
                library /
                L"steamapps" /
                (L"appmanifest_" +
                    std::to_wstring(appId) +
                    L".acf");

            if (!std::filesystem::exists(manifestPath))
                continue;

            auto installDir =
                ReadAcfValue(manifestPath, "installdir");

            if (!installDir)
                return std::nullopt;

            return library /
                L"steamapps" /
                L"common" /
                *installDir;
        }

        return std::nullopt;
    }

private:
    static std::optional<std::wstring>
        ReadRegistryString(HKEY hKey, const wchar_t* valueName)
    {
        DWORD type = 0;
        DWORD size = 0;

        if (RegQueryValueExW(
            hKey,
            valueName,
            nullptr,
            &type,
            nullptr,
            &size) != ERROR_SUCCESS)
        {
            return std::nullopt;
        }

        if (type != REG_SZ && type != REG_EXPAND_SZ)
            return std::nullopt;

        std::wstring value(size / sizeof(wchar_t), L'\0');

        if (RegQueryValueExW(
            hKey,
            valueName,
            nullptr,
            nullptr,
            reinterpret_cast<LPBYTE>(value.data()),
            &size) != ERROR_SUCCESS)
        {
            return std::nullopt;
        }

        if (!value.empty() && value.back() == L'\0')
            value.pop_back();

        return value;
    }

    static std::vector<std::filesystem::path>
        GetSteamLibraries(const std::wstring& steamPath)
    {
        std::vector<std::filesystem::path> libraries;

        libraries.emplace_back(steamPath);

        auto libraryFolders =
            std::filesystem::path(steamPath) /
            L"steamapps" /
            L"libraryfolders.vdf";

        if (!std::filesystem::exists(libraryFolders))
            return libraries;

        auto text = ReadFile(libraryFolders);

        std::regex pathRegex(
            "\"path\"\\s+\"([^\"]+)\"",
            std::regex_constants::icase);

            for (std::sregex_iterator it(text.begin(),
                text.end(),
                pathRegex);
                it != std::sregex_iterator();
                ++it)
            {
                std::string pathStr =
                    (*it)[1].str();

                size_t pos = 0;
                while ((pos = pathStr.find("\\\\", pos))
                    != std::string::npos)
                {
                    pathStr.replace(pos, 2, "\\");
                    ++pos;
                }

                std::filesystem::path p(pathStr);

                if (std::filesystem::exists(p))
                    libraries.push_back(p);
            }

            return libraries;
    }

    static std::optional<std::string>
        ReadAcfValue(const std::filesystem::path& filePath,
            const std::string& key)
    {
        auto text = ReadFile(filePath);

        std::regex regex(
            "\"" + key + "\"\\s+\"([^\"]+)\"",
            std::regex_constants::icase);

        std::smatch match;

        if (std::regex_search(text, match, regex))
            return match[1].str();

        return std::nullopt;
    }

    static std::string
        ReadFile(const std::filesystem::path& path)
    {
        std::ifstream file(path, std::ios::binary);

        return std::string(
            std::istreambuf_iterator<char>(file),
            std::istreambuf_iterator<char>());
    }
};

int main(int argc, char* argv[])
{
    if (argc < 2)
    {
        wprintf(L"Usage: %hs <AppID>\n", argv[0]);
        return 1;
    }

    uint32_t appId = std::stoi(argv[1]);
    auto path = SteamLocator::GetGameInstallPath(appId);
    if (path)
        wprintf(path->wstring().c_str());
}
