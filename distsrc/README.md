## Dark Deity Community Patch - version 3.0.0

The Dark Deity Community Patch is a package of bug fixes for the game Dark Deity, written by John Hadley of Steam.  This version of the patch supports all three PC/Windows distributions of the game (GOG, Steam, and Epic Games) running on Windows machines or running on Linux machines through the Proton compatibility layer.  It does not support Switch versions of the game.  The patch is meant to be applied to version 1.58 of the game, which is the current version on all three platforms as of 7/21/2026.

[Command-Line Installation (Windows)](https://HadleyTheGreat.github.io/install-windows.html)

[Command-Line Installation (Linux)](https://hadleythegreat.github.io/install-linux.html)



1. Download the version of the zip file for your operating system.
2. Extract the contents of the zip file into a folder that the user has read/write/execute permissions, such as a subfolder of your documents directory, download diretory, or your desktop on Windows, or a subfolder of your $HOME folder on Linux.
3. Open your command-line shell or terminal inside the folder where you extracted the files.
4. If you are using Windows, press Win+R "powershell -ExecutionPolicy bypass"
5. Download the latest version of DarkDeityCommunityPatch.zip from the releases section of the GitHub site at https://github.com/HadleyTheGreat/DarkDeityCommunityPatch
6. Use the Windows file explorer to extract the contents into a place that the user has write access such as a folder on your desktop, or a sub-folder in your Documents or Downloads folder by right-clicking it and selecting Extract All.
7. After extracting, run APPLYPATCH.BAT by double-clicking it in the file explorer or right-clicking it and selecting Open.  If you have default security settings Windows will warn you that you are about to run a batch file and ask you for permission.  You must allow it to run the batch file to do the install.
8. 

Once the install is complete, you don't need the folder you extracted and installed from anymore and you can safely delete it.

\---

## HOW TO UNINSTALL

Method 1:

1. Follow the same steps used to install the patch and the APPLYPATCH.BAT script will detect that it is already installed and prompt you to ask if you want to uninstall it.

Method 2:

1. In Steam, click Library and locate Dark Deity within it
2. Right-click on Dark Deity then select Properties->Installed Files->Verify ntegrity of game files

Steam will analyze the files, detect that DATA.WIN has been changed, then re-download it automatically returning your DATA.WIN to its pre-patched state effectively removing the patch.

\---

## NOTES

This patch rewrites the DATA.WIN file of the game to modify the game scripts in it.  If you attempt to manually verify the Steam installation of the game then Steam will recognize that the DATA.WIN file has changed and re-download it.  You would then need to re-apply the patch if you still want to use it.  If a new official update is released for the game it may also re-download DATA.WIN and require re-application of the patch.

The patch calculates the SHA256 hash for the DATA.WIN file before applying changes to make sure you only apply them to the exact version of the game it was written for.  This is intentional to prevent applying the patch in situations where may no longer be compatible.  If you *REALLY* want to install the patches to another version, then you can delete scripts\\hashes.csv file before running APPLYPATCH.BAT to suppress the validation.  I would hope that if there is a new official game update at some point then this patch will no longer be needed because the developers will have some officially implemented bugfixes for these bugs, so you won't need to apply it anymore to any newer version of the game.

\---

## LICENSES AND ATTRIBUTIONS

This patch package incorporates pre-compiled binaries and other files from the official UndertaleModCLI release version 0.9.0.0 in its entirety and with no modifications in the UTMT\_CLI folder.  JohnHadley does not lay claim to and is not affiliated with UndertaleModTool or UndertaleModCLI.

UndertaleModTool and its command-line tool UndertaleModCLI are third-party, open source tools for modifying GameMaker data files redistributed under the GNU General Public License version 3.0, see UTMT\_CLI\\LICENSE.TXT for full details.  The source code and binaries for UndertaleModTool and UndertaleModCLI are freely available on GitHub at https://github.com/UnderminersTeam/UndertaleModToolUndertaleModTool.

The game scripts in the scripts folder are modified versions of copyrighted material owned by the developers and creators of Dark Deity.  To the extent that any of these third-party modifications made to the original scripts and included in this package would be copyrightable, JohnHadley and any other contributors to this package release those modifications to the public domain without copyright or claim to be freely used by anyone for any purpose.

