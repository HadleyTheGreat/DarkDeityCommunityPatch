### Dark Deity Community Patch v3.0.0

===============================================================================

**BUG CATALOG**



This is a list of all every bug fix or mod implemented by the patch.
After each description is a list of the related files changed to fix the bug.

**=========================================================================**



BUG: Mousing over dragon damage type causes game crash in chapter 16

* gml\_RoomCC\_room\_l16\_0\_Create.gml



BUG: State of chapter 4 prisoners not restored when loading from battlesave

* gml\_RoomCC\_room\_ch\_4\_0\_Create.gml
* gml\_RoomCC\_room\_ch\_4\_1\_Create.gml
* nongmlmods.csx



BUG: Battle stats not restored when loading from battlesaves

* gml\_GlobalScript\_scr\_battlesave.gml



BUG: Game crash in chapter 28 when Empyrean attacks while too close to the edge of the map

* gml\_Object\_obj\_turn\_scripter\_28\_Other\_10.gml



BUG: In chapter 10 one user reported being on turn 41 without the map ending

* gml\_Object\_obj\_turn\_scripter\_10\_Other\_10.gml



BUG: Units spawning on top of other units in chapter 22

* gml\_Object\_obj\_turn\_scripter\_22\_Other\_10.gml



BUG: Potential memory corruption due to handling a ds\_grid as a ds\_list during the destroy event of obj\_stat\_view

* gml\_Object\_obj\_stat\_view\_Destroy\_0.gml



BUG: Movement drift continues to occur sometimes after a unit's movement path ends (on movement speed 8 when any unit moves exactly 7 squares).

* gml\_Object\_obj\_purpleai\_controller\_Other\_8.gml
* gml\_Object\_obj\_ai\_controller\_Other\_8.gml
* gml\_Object\_obj\_actor\_Other\_8.gml



BUG: Potential memory corruption due to handling neighbors, viewneighborsranged, and viewneighborsmelee variables as ds\_grid instead of ds\_list type when destroying them during the destroy event of obj\_node

* gml\_Object\_obj\_node\_Destroy\_0.gml



MOD: Removed defunct Sophie and Butters plushie ad from English version, added text to identify the presence of the community patch, changed version display to v1.58c to indicate visually that it is not the standard 1.58 version.

* gml\_Object\_obj\_main\_menu\_Draw\_64.gml



BUG: Memory leak in obj\_item\_holder due to not releasing memory in the ds\_grid variable usable\_translations during its destroy event.

* gml\_Object\_obj\_item\_holder\_Destroy\_0.gml



BUG: Battlesaves do not store historical battle data for the chapter or restore it upon reload.  Causes stats tallies at the end of the map to be wrong and items that get boosts from damage or crits done during the map to reset their effectiveness.

* gml\_Object\_obj\_gameplay\_preparation\_Create\_0.gml
* gml\_GlobalScript\_scr\_battlesave.gml



BUG: English text bug when item is sent to convoy storage "Storage Receieved"

* gml\_Object\_obj\_dropdown\_openchest\_Other\_10.gml
* gml\_Object\_obj\_ai\_controller\_Step\_0.gml
* gml\_Object\_obj\_actor\_Step\_0.gml



BUG: Irving wearing beach hat in one frame during the first bond conversation with Lincoln

* gml\_Object\_obj\_bond\_irving\_Create\_0.gml



BUG: Potential memory corruption due to handling bondersview variable as a ds\_grid instead of a ds\_priority during the destroy event of obj\_base\_bonds3

* gml\_Object\_obj\_base\_bonds3\_Destroy\_0.gml



BUG: Confirmed memory corruption due to handling skillslots variable as a ds\_list instead of a ds\_grid during the destroy event of obj\_actor.  This is the cause of confirmed crashes due to "invalid index" or "passable" especially in chapter 19 and 22.

* gml\_Object\_obj\_actor\_Destroy\_0.gml



BUG: Memory leak in obj\_ability\_holder due to not releasing memory in the ds\_grid variable skills\_translations during its destroy event.

* gml\_Object\_obj\_ability\_holder\_Destroy\_0.gml



BUG: Helena's historical stats are not recorded and always show as 0

* gml\_GlobalScript\_scr\_statadd.gml



BUG: Irving's hair reverts to from black to red if loading from a normal save or a battlesave in chapters 12 to 16 (scenes 83 to 129).

* gml\_GlobalScript\_scr\_load\_game\_battlesave.gml
* gml\_GlobalScript\_scr\_load\_game1.gml
* gml\_GlobalScript\_scr\_load\_game\_2.gml
* gml\_GlobalScript\_scr\_load\_game\_3.gml
* gml\_GlobalScript\_scr\_load\_game\_4.gml
* gml\_GlobalScript\_scr\_load\_game\_5.gml
* gml\_GlobalScript\_scr\_load\_game\_6.gml
* gml\_GlobalScript\_scr\_load\_game\_7.gml
* gml\_GlobalScript\_scr\_load\_game\_8.gml



BUG: Failure to round damage if attack animation is skipped leads to enemies that apparently have 0 health sometimes staying alive.

* gml\_GlobalScript\_scr\_do\_damage\_skip.gml
* gml\_GlobalScript\_scr\_do\_counter\_damage\_skip.gml



BUG: Memory leak in obj\_base\_shop\_stock due to not releasing memory in the ds\_grid variable items during its destroy event.

* gml\_Object\_obj\_base\_shop\_stock\_Destroy\_0.gml



BUG: Previously unlocked doors (obj\_door1) whose tiles were passable are not restored to that state upon reload from battlesave.

* gml\_Object\_obj\_objective\_door1\_Destroy\_0.gml



BUG: Previously unlocked doors (obj\_switchdoor) whose tiles were passable are not restored to that state upon reload from battlesave.

* gml\_Object\_obj\_objective\_switch\_Destroy\_0.gml



BUG: Previously resuced prisoners' sprite representations are not removed upon reload from battlesave.

* gml\_Object\_obj\_objective\_rescue\_Destroy\_0.gml



BUG: Prisoner spawn squares previously made passable after activating switches to release prisoners are not restored to that state upon reload from battlesave.

* gml\_Object\_obj\_objective\_switch\_Destroy\_0.gml



BUG: Sprites representing prisoners that were already rescued were not removed from the map upon reload from battlesave.

* gml\_Object\_obj\_objective\_rescue\_Destroy\_0.gml



BUG: Previously release prisoner groups' sprites are not removed from the map upon reload from battlesave.

* gml\_Object\_obj\_objective\_visit\_Destroy\_0.gml



BUG: Memory leak in obj\_storage\_holder due to not releasing memory in the ds\_grid variable item\_storage during its destroy event.

* gml\_Object\_obj\_storage\_holder\_Destroy\_0.gml



BUG: 7 items are used as combat skill counters in battle, but their translations are not listed in Skills.csv so they just produce blank boxes in every language except English.

* Skills.csv



Typo (English): Corvan-Maeve bond conversation level 3 - "how in the world has it help up for so long?" - "help" should be "held"

* Bonds/Bonds\_English/Bonds\_Corvan.txt



Poor translation (English): "King Varic has sent countless Delians to their lives".  "lives" should be "deaths".

* Chapnames.csv



Typo (English): "Yl'mars Faith" should be "Yl'mar's Faith", (French) "Foi de Yl'mars" should be "Foi de Yl'mar"

* Items.csv



Typo (English): Chapter 25 "Months of hardship and warfare have led to this confronation".  "confronation" should be "confrontation"

* gml\_Object\_obj\_overview\_25\_Step\_0.gml

