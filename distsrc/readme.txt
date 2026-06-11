--------------------------------------------
Dark Deity community patch 1 - version 1.0.1
--------------------------------------------
This package contains community developed bugfix patches for Dark Deity written by JohnHadley of Steam.  It was designed to work with the most current Steam Windows PC version of the game as of 6/2/2026.  It is not intended for, has not been tested with, and is not likely to work with any other versions of the game.  JohnHadley is not affiliated with the developers of Dark Deity and this is not an official bug patch.

In particular this patch is designed to fix a few crash bugs that exist in chapter 22.

CHANGELOG
1.0.0 - Initial release
1.0.1 - Found more places that invalid types were getting into the sniper attack range function.  I think this should fix the remaining crashes in chapter 22.

--------------
HOW TO INSTALL
--------------
1) Download DarkDeityPatch01.zip from the releases section of the GitHub site at https://github.com/HadleyTheGreat/DarkDeityPatch01
2) Use the Windows file explorer to extract the contents into a place that the user has write access such as a folder on your desktop, or a sub-folder in your Documents or Downloads folder by right-clicking it and selecting Extract All.
3) After extracting, run APPLYPATCH.BAT by double-clicking it in the file explorer or right-clicking it and selecting Open.  If you have default security settings Windows will warn you that you are about to run a batch file and ask you for permission.  You must allow it to run the batch file to do the install.

Once the install is complete, you don't need the folder you extracted and installed from anymore and you can safely delete it.

----------------
HOW TO UNINSTALL
----------------
1) In Steam, click Library and locate Dark Deity within it
2) Right-click on Dark Deity then select Properties->Installed Files->Verify ntegrity of game files

Steam will analyze the files, detect that DATA.WIN has been changed, then re-download it automatically returning your DATA.WIN to its pre-patched state effectively removing the patch.

-----
NOTES
-----
This patch rewrites the DATA.WIN file of the game to modify the game scripts in it.  If you attempt to manually verify the Steam installation of the game then Steam will recognize that the DATA.WIN file has changed and re-download it.  You would then need to re-apply the patch if you still want to use it.  If a new official update is released for the game it may also re-download DATA.WIN and require re-application of the patch.

This patch calculates SHA256 hashes for the scripts that it is changing in DATA.WIN before changing them to make sure that they are the expected versions.  If the changes already exist because you have already applied the patch then it will tell you that the hashes don't match the expected values and not change DATA.WIN.  If a new official or unofficial patch has changed one or more of the scripts that this patch is attempting to change then the patch will not be able to be applied.  This is intentional to prevent applying the patch in situations where may no longer be compatible.  One would hope that if there is a new official patch then this patch will no longer be needed because the developers will have some officially implemented bugfixes for these bugs.

-------------------------
LICENSES AND ATTRIBUTIONS
-------------------------
This patch package incorporates pre-compiled binaries and other files from the official UndertaleModCLI release version 0.9.0.0 in its entirety and with no modifications in the UTMT_CLI folder.  JohnHadley does not lay claim to and is not affiliated with UndertaleModTool or UndertaleModCLI.

UndertaleModTool and its command-line tool UndertaleModCLI are third-party, open source tools for modifying GameMaker data files redistributed under the GNU General Public License version 3.0, see UTMT_CLI\LICENSE.TXT for full details.  The source code and binaries for UndertaleModTool and UndertaleModCLI are freely available on GitHub at https://github.com/UnderminersTeam/UndertaleModToolUndertaleModTool.

The game scripts in the scripts folder are modified versions of copyrighted material owned by the developers and creators of Dark Deity.  To the extent that any of these third-party modifications made to the original scripts and included in this package would be copyrightable, JohnHadley and any other contributors to this package release those modifications to the public domain without copyright or claim to be freely used by anyone for any purpose.
