using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Underanalyzer.Decompiler;
using UndertaleModLib.Util;
using UndertaleModLib.Compiler;
using System.Security.Cryptography;
using System.Text;

string ComputeSHA256(string text)
{
    using var sha = SHA256.Create();
    byte[] bytes = Encoding.UTF8.GetBytes(text);
    byte[] hash = sha.ComputeHash(bytes);

    return BitConverter.ToString(hash).Replace("-", "").ToLowerInvariant();
}

var abortWrite = false;
var changesMade = false;
string hashCsvPath = Path.Combine(Environment.CurrentDirectory, "scripts\\known_hashes.csv");

Dictionary<string, string> expectedHashes = new();

if (File.Exists(hashCsvPath))
{
    foreach (var line in File.ReadAllLines(hashCsvPath))
    {
        var parts = line.Split(',');
        if (parts.Length != 2) continue;

        string name = parts[0].Trim();
        string hash = parts[1].Trim().ToLowerInvariant();

        expectedHashes[name] = hash;
    }
}
else
{
    ScriptMessage($"Hash file not found: {hashCsvPath}");
    ScriptMessage("All script replacements will be applied without validation.");
}

EnsureDataLoaded();

string patchDir = Path.Combine(Environment.CurrentDirectory, "scripts");
string origDir  = Path.Combine(Environment.CurrentDirectory, "originals");

Directory.CreateDirectory(origDir);

if (Data.IsYYC())
{
    ScriptError("YYC games cannot be modified.");
    return;
}

// Decompiler context (for exporting originals)
GlobalDecompileContext globalDecompileContext = new(Data);
var decompilerSettings = Data.ToolInfo.DecompilerSettings;

// Collect patch files
string[] dirFiles = Directory.GetFiles(patchDir, "*.gml");
if (dirFiles.Length == 0)
{
    ScriptError("No .gml files found in scripts folder.");
    return;
}

ScriptMessage($"DATA.WIN loaded successfully");

// -------------------------
// CREATE IMPORT GROUP
// -------------------------
var importGroup = new CodeImportGroup(Data)
{
    AutoCreateAssets = true,
    MainThreadAction = MainThreadAction
};

foreach (string file in dirFiles)
{
    string name = Path.GetFileNameWithoutExtension(file);
    string fileName = Path.GetFileName(file);

    // Read the text file of the new version of the script into gml
    var gml = File.ReadAllText(file);

    // Try to locate a pre-existing version of the script in the existing data
    var code = Data.Code.FirstOrDefault(c => c.Name?.Content == name);
    if (code == null)
    {
        // It didn't find any existing code so this is a new script
        // Add it to the import group and move on to the next file
        ScriptMessage("Adding new script: " + name + ".gml");
        importGroup.QueueReplace(name, gml);
        changesMade = true;
        continue;
    }

    // -------------------------
    // EXPORT ORIGINAL
    // -------------------------
    string originalGml = null;
    string originalHash = null;

    try
    {
        // Decompile the version of the script that is already in the data file
        originalGml =
            new DecompileContext(globalDecompileContext, code, decompilerSettings)
            .DecompileToString();

        // Compute the SHA256 hash of the existing version of the script
        originalHash = ComputeSHA256(originalGml);

    
        // See if we have a hash for this file
        if (expectedHashes.TryGetValue(fileName, out string expected))
        {
            // There is a hash stored for this file, so check against it
            if (originalHash != expected)
            {
                // original script is not the one we expected to replace               
                ScriptMessage($"HASH MISMATCH: {fileName}");
                ScriptMessage($"Expected: {expected}");
                ScriptMessage($"Actual:   {originalHash}");

                // don't update data.win at the end of processing
                abortWrite = true;

                // Skip extracting the existing script into the originals folder
                continue;
            }
        
            ScriptMessage($"Replacing existing script: {fileName}");
        }
        else
        { 
            ScriptMessage($"Replacing existing script without validation hash: {fileName}");
            continue;
        }
       
        // Extract the original version into the originals folder
        File.WriteAllText(Path.Combine(origDir, name + ".gml"), originalGml);
    }
    catch (Exception e)
    {
        ScriptMessage("FAILED export " + name + "\n" + e);
        
        // Don't update data.win at the end of processing
        abortWrite = true;
    }

    // -------------------------
    // QUEUE PATCH
    // -------------------------
    importGroup.QueueReplace(name, gml);
    changesMade = true;
}


// Exiting with any exit code except zero will prevent DATA.WIN from being written afterwards
if (!changesMade)
{
    ScriptMessage("");
    ScriptMessage("No changes to apply.  DATA.WIN was not modified.");
    Environment.Exit(1);
}

// -------------------------
// APPLY ALL PATCHES AT ONCE
// -------------------------
try
{
    if (abortWrite)
    {
        ScriptMessage("");
        ScriptMessage("OPERATION ABORTED!  DATA.WIN was not modified.");
        ScriptMessage("One or more scripts do not match the expected versions in DATA.WIN.");    
        Environment.Exit(2);
    }
    importGroup.Import();
}
catch (Exception e)
{
    ScriptMessage("");
    ScriptMessage("IMPORT FAILED:\n" + e);
    Environment.Exit(1);
}
    
ScriptMessage("All patches were successfully applied");
