
// This script is for whatever can't be done by just updating the GML files, such as defining new objects or deleting existing ones.

using System;
using System.ComponentModel;
using System.IO;
using System.Security.Cryptography;
using System.Threading;
using System.Linq;
using UndertaleModLib;
using UndertaleModLib.Decompiler;
using UndertaleModLib.Models;
using UndertaleModLib.Scripting;
//using static System.Runtime.InteropServices.JavaScript.JSType;
using static UndertaleModLib.Models.UndertaleRoom;

EnsureDataLoaded();

var room4 = Data.Rooms.ByName("room_ch_4");

// Remove two obj_chapter4_prisoner instances from room 4 since they are no longer used
ScriptMessage("room_ch_4: Removing instance 100705 of obj_chapter4_prisoners");
room4.GameObjects.Remove(room4.GameObjects.ByInstanceID(100705));
ScriptMessage("room_ch_4: Removing instance 100706 of obj_chapter4_prisoners");
room4.GameObjects.Remove(room4.GameObjects.ByInstanceID(100706));

ScriptMessage("room_ch_4: Adding new sprite prisoner_sophia to layer Assets_2 at (512, 448)");

// Add a static sprite for Sophia to layer Assets_2 of room 4.  This layer will be destroyed by an instance of obj_objective_rescue when Sophia is rescued.
var Assets_2 = room4.Layers.First(l => l.LayerName.Content == "Assets_2");
Assets_2.AssetsData.Sprites.Add(new SpriteInstance()
{
    Name = Data.Strings.MakeString("prisoner_sophia"),
    Sprite = Data.Sprites.ByName("spr_sophia_ranger_idle"),
    X = 512,
    Y = 448
});

ScriptMessage("room_ch_4: Adding new sprite prisoner_sloane to layer Assets_3 at (768, 448)");
// Add a static sprite for Sloane to layer Assets_3 of room 4.  This layer will be destroyed by an instance of obj_objective_rescue when Sloane is rescued.
var Assets_3 = room4.Layers.First(l => l.LayerName.Content == "Assets_3");
Assets_3.AssetsData.Sprites.Add(new SpriteInstance()
{
    Name = Data.Strings.MakeString("prisoner_sloane"),
    Sprite = Data.Sprites.ByName("spr_sloane_magi_idle"),
    X = 768,
    Y = 448,
});
