using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Underanalyzer.Decompiler;
using UndertaleModLib.Util;
using UndertaleModLib.Compiler;
using System.Security.Cryptography;
using System.Text;

var abortWrite = false;
var changesMade = false;

EnsureDataLoaded();

string patchDir = Path.Combine(Environment.CurrentDirectory, @"scripts");
string origDir  = Path.Combine(Environment.CurrentDirectory, @"originals");

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
        ScriptMessage($"Adding new script: {name}.gml");
        importGroup.QueueReplace(name, gml);
        changesMade = true;
        continue;
    }

    // -------------------------
    // EXPORT ORIGINAL
    // -------------------------
    string originalGml = null;
    string originalHash = null;

    // Decompile the version of the script that is already in the data file
    originalGml =
        new DecompileContext(globalDecompileContext, code, decompilerSettings).DecompileToString();

    ScriptMessage($"Replacing existing script: {fileName}");

    // Extract the original version into the originals folder
    File.WriteAllText(Path.Combine(origDir, name + ".gml"), originalGml);

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

importGroup.Import();
    
ScriptMessage("Saving modified DATA.WIN");
