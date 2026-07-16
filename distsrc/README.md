## Dark Deity Community Patch - version 3.0.0



This patch contains community developed bug fixes for Dark Deity written by JohnHadley of Steam.  JohnHadley is not affiliated with the developers of Dark Deity and this is not an official game update.  The patch is designed to be applied to version 1.5.8 of Dark Deity, which released on Steam on Nov 22, 2022 and was the latest version of the game as of 7/10/2026.  It has been tested on the Steam (Windows) release, but I believe it also should work with the Epic Games Store (Windows) or GOG (Windows) releases of the game.



**New**: In addition to support for Windows PCs, there is also now an installation package that supports most x86-based Linux PCs and devices that run games through the Linux version of Steam, including the Steam Deck and Steam Machine.



The installer will automatically locate the game folder for you in Steam, but you can also specify the install path manually on the command-line if for some reason auto-detection doesn't work or if you want to install the patch on the GOG or Epic Games Store versions of the game, provided you can figure out yourself where the game is installed.

&#x20;

##### Bugs fixed by this patch



* Memory corruption: Destroying an actor object (usually because the player killed the enemy) results in corruption of other game data.
* Game crash bug: Variable <unknown\_object>.passable(100144, -2147483648) not set before reading it. (chapter 22 especially)
* Game crash bug: Data structure with index does not exist. (chapter 22 especially)
* Movement bug: Unit continues to slowly drift after completing a movement path.
* Movement bug: More than one unit ends up on the same tile as a result of movement drift.
* Movement bug: Enemy unit cannot move anymore after being chained, even after the chain expires.
* Movement bug: Attempting to push a unit causes it to visibly glitch out with a blurry image.
* Movement bug: Unit's sprite being shown on a different tile than the one you can select the unit to interact with it with the cursor.
* Spawning bug: Units spawn on top of other units in chapter 22.
* Sprite mismatch: Irving's hair reverts back to red if you load any save file from chapter 12-16
* Unending mission: A user reported to me that chapter 10 never ended for him, I made the game check on every turn after 8 instead of just on exactly turn 9 to try to end the map as a workaround.
* Stat recording bug: Helena's historical statistics were not being tracked properly.
* Battlesave state bug: Doors that were unlocked would be closed again when reloading after a battlesave
* Battlesave state bug: Units that were already rescued would appear to be trapped again after loading from a battlesave
* Battlesave state bug: Cumulative damage totals for the map would not be restored when loading from a battlesave, weakening items and skills that scale based on them and making end of battle and end of playthrough stats incorrect.
* Visual bug: In chapter 17, Alexa and Rose prisoner sprites would not be removed when they were rescued.
* Rounding bug: Critical hit damage was not rounded properly if you skipped battle animations, which could result in enemies not dying when it appeared they already reached 0 health.





## HOW TO INSTALL



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

