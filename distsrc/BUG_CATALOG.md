=============================================================================
BUG CATALOG - Dark Deity Community Patch v3.0.0

This is a list of all every bug fix or mod implemented by this patch.
After each description is a list of the related files changed to fix the bug.
=============================================================================

BUG: Mousing over dragon damage type causes game crash in chapter 16
	gml_RoomCC_room_l16_0_Create.gml

BUG: State of chapter 4 prisoners not restored when loading from battlesave
	gml_RoomCC_room_ch_4_0_Create.gml
	gml_RoomCC_room_ch_4_1_Create.gml
	nongmlmods.csx

BUG: Battle stats not restored when loading from battlesaves
	gml_GlobalScript_scr_battlesave.gml

BUG: Game crash in chapter 28 when Empyrean attacks while too close to the edge of the map
	gml_Object_obj_turn_scripter_28_Other_10.gml

BUG: In chapter 10 one user reported being on turn 41 without the map ending
	gml_Object_obj_turn_scripter_10_Other_10.gml

BUG: Units spawning on top of other units in chapter 22
	gml_Object_obj_turn_scripter_22_Other_10.gml

BUG: Potential memory corruption due to handling a ds_grid as a ds_list during the destroy event of obj_stat_view 
	gml_Object_obj_stat_view_Destroy_0.gml

BUG: Movement drift continues to occur sometimes after a unit's movement path ends (on movement speed 8 when any unit moves exactly 7 squares).
	gml_Object_obj_purpleai_controller_Other_8.gml
	gml_Object_obj_ai_controller_Other_8.gml
	gml_Object_obj_actor_Other_8.gml

BUG: Potential memory corruption due to handling neighbors, viewneighborsranged, and viewneighborsmelee variables as ds_grid instead of ds_list type when destroying them during the destroy event of obj_node
	gml_Object_obj_node_Destroy_0.gml

MOD: Removed defunct Sophie and Butters plushie ad from English version, added text to identify the presence of the community patch, changed version display to v1.58c to indicate visually that it is not the standard 1.58 version.
	gml_Object_obj_main_menu_Draw_64.gml

BUG: Memory leak in obj_item_holder due to not releasing memory in the ds_grid variable usable_translations during its destroy event.
	gml_Object_obj_item_holder_Destroy_0.gml

BUG: Battlesaves do not store historical battle data for the chapter or restore it upon reload.  Causes stats tallies at the end of the map to be wrong and items that get boosts from damage or crits done during the map to reset their effectiveness.
	gml_Object_obj_gameplay_preparation_Create_0.gml
	gml_GlobalScript_scr_battlesave.gml

BUG: English text bug when item is sent to convoy storage "Storage Receieved"
	gml_Object_obj_dropdown_openchest_Other_10.gml
	gml_Object_obj_ai_controller_Step_0.gml
	gml_Object_obj_actor_Step_0.gml

BUG: Irving wearing beach hat in one frame during the first bond conversation with Lincoln
	gml_Object_obj_bond_irving_Create_0.gml

BUG: Potential memory corruption due to handling bondersview variable as a ds_grid instead of a ds_priority during the destroy event of obj_base_bonds3
	gml_Object_obj_base_bonds3_Destroy_0.gml

BUG: Confirmed memory corruption due to handling skillslots variable as a ds_list instead of a ds_grid during the destroy event of obj_actor.  This is the cause of confirmed crashes due to "invalid index" or "passable" especially in chapter 19 and 22.
	gml_Object_obj_actor_Destroy_0.gml

BUG: Memory leak in obj_ability_holder due to not releasing memory in the ds_grid variable skills_translations during its destroy event.
	gml_Object_obj_ability_holder_Destroy_0.gml

BUG: Helena's historical stats are not recorded and always show as 0
	gml_GlobalScript_scr_statadd.gml

BUG: Irving's hair reverts to from black to red if loading from a normal save or a battlesave in chapters 12 to 16 (scenes 83 to 129).
	gml_GlobalScript_scr_load_game_battlesave.gml
	gml_GlobalScript_scr_load_game1.gml
	gml_GlobalScript_scr_load_game_2.gml
	gml_GlobalScript_scr_load_game_3.gml
	gml_GlobalScript_scr_load_game_4.gml
	gml_GlobalScript_scr_load_game_5.gml
	gml_GlobalScript_scr_load_game_6.gml
	gml_GlobalScript_scr_load_game_7.gml

BUG: Failure to round damage if attack animation is skipped leads to enemies that apparently have 0 health sometimes staying alive.
	gml_GlobalScript_scr_do_damage_skip.gml
	gml_GlobalScript_scr_do_counter_damage_skip.gml

BUG: Memory leak in obj_base_shop_stock due to not releasing memory in the ds_grid variable items during its destroy event.
	gml_Object_obj_base_shop_stock_Destroy_0.gml

BUG: Previously unlocked doors (obj_door1) whose tiles were passable are not restored to that state upon reload from battlesave.
	gml_Object_obj_objective_door1_Destroy_0.gml

BUG: Previously unlocked doors (obj_switchdoor) whose tiles were passable are not restored to that state upon reload from battlesave.
	gml_Object_obj_objective_switch_Destroy_0.gml

BUG: Previously resuced prisoners' sprite representations are not removed upon reload from battlesave.
	gml_Object_obj_objective_rescue_Destroy_0.gml

BUG: Prisoner spawn squares previously made passable after activating switches to release prisoners are not restored to that state upon reload from battlesave.
	gml_Object_obj_objective_switch_Destroy_0.gml

BUG: Sprites representing prisoners that were already rescued were not removed from the map upon reload from battlesave.
	gml_Object_obj_objective_rescue_Destroy_0.gml

BUG: Previously release prisoner groups' sprites are not removed from the map upon reload from battlesave.
	gml_Object_obj_objective_visit_Destroy_0.gml

BUG: Memory leak in obj_storage_holder due to not releasing memory in the ds_grid variable item_storage during its destroy event.
	gml_Object_obj_storage_holder_Destroy_0.gml

BUG: 7 items are used as combat skill counters in battle, but their translations are not listed in Skills.csv so they just produce blank boxes in every language except English.
	Skills.csv

Typo (English): Corvan-Maeve bond conversation level 3 - "how in the world has it help up for so long?" - "help" should be "held"
	Bonds/Bonds_English/Bonds_Corvan.txt

Poor translation (English): "King Varic has sent countless Delians to their lives".  "lives" should be "deaths".
	Chapnames.csv

Typo (English): "Yl'mars Faith" should be "Yl'mar's Faith", (French) "Foi de Yl'mars" should be "Foi de Yl'mar"
	Items.csv

Typo (English): Chapter 25 "Months of hardship and warfare have led to this confronation".  "confronation" should be "confrontation"
	gml_Object_obj_overview_25_Step_0.gml
