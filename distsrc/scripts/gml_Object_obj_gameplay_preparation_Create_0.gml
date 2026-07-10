option1 = "Select Units";
option2 = "Move Units";
option3 = "Inventory";
option4 = "Fight";
option5 = "Empty";
index = 0;
cavalrycheck = 0;
aspectcheck = 0;
totalcheck = 0;
index1 = 0;
index2 = 0;
index3 = 0;
index4 = 0;
index5 = 0;
pacey = 0;
pacex = 0;
distx = 0;
disty = 0;
distx2 = 0;
disty2 = 0;
selectcolor = 16777215;
myx = 0;
myy = 0;
selected = 1;
notreplacing = true;
flash = 0;

if (instance_exists(obj_room_info))
{
    chaptername = scr_chaptername(obj_room_info.chap);
    chap = obj_room_info.chap;
}

if (!instance_exists(obj_marker_parent) && global.battlesaver == false && (room != room_lp && room != room_l1 && room != room_l2 && room != room_ch_4 && room != room_story_1_level && room != room_story_2_level && room != room_story_3_level && room != room_story_4_level && room != room_story_5_level && room != room_story_6_level && room != room_story_7_level))
{
    levelsplit = ds_grid_create(2, 30);
    ds_grid_set(levelsplit, 0, 0, ds_grid_get(obj_stat_holder.irving_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 0, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Irving"));
    ds_grid_set(levelsplit, 0, 1, ds_grid_get(obj_stat_holder.garrick_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 1, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Garrick"));
    ds_grid_set(levelsplit, 0, 2, ds_grid_get(obj_stat_holder.maren_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 2, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Maren"));
    ds_grid_set(levelsplit, 0, 3, ds_grid_get(obj_stat_holder.alden_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 3, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Alden"));
    ds_grid_set(levelsplit, 0, 4, ds_grid_get(obj_stat_holder.cia_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 4, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Cia"));
    ds_grid_set(levelsplit, 0, 5, ds_grid_get(obj_stat_holder.elias_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 5, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Elias"));
    ds_grid_set(levelsplit, 0, 6, ds_grid_get(obj_stat_holder.lincoln_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 6, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Lincoln"));
    ds_grid_set(levelsplit, 0, 7, ds_grid_get(obj_stat_holder.bianca_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 7, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Bianca"));
    ds_grid_set(levelsplit, 0, 8, ds_grid_get(obj_stat_holder.sloane_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 8, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Sloane"));
    ds_grid_set(levelsplit, 0, 9, ds_grid_get(obj_stat_holder.sophia_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 9, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Sophia"));
    ds_grid_set(levelsplit, 0, 10, ds_grid_get(obj_stat_holder.brooke_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 10, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Brooke"));
    ds_grid_set(levelsplit, 0, 11, ds_grid_get(obj_stat_holder.benji_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 11, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Benji"));
    ds_grid_set(levelsplit, 0, 12, ds_grid_get(obj_stat_holder.caius_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 12, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Caius"));
    ds_grid_set(levelsplit, 0, 13, ds_grid_get(obj_stat_holder.sara_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 13, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Sara"));
    ds_grid_set(levelsplit, 0, 14, ds_grid_get(obj_stat_holder.samara_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 14, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Samara"));
    ds_grid_set(levelsplit, 0, 15, ds_grid_get(obj_stat_holder.corvan_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 15, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Corvan"));
    ds_grid_set(levelsplit, 0, 16, ds_grid_get(obj_stat_holder.helena_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 16, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Helena"));
    ds_grid_set(levelsplit, 0, 17, ds_grid_get(obj_stat_holder.aurima_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 17, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Aurima"));
    ds_grid_set(levelsplit, 0, 18, ds_grid_get(obj_stat_holder.vesta_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 18, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Vesta"));
    ds_grid_set(levelsplit, 0, 19, ds_grid_get(obj_stat_holder.monroe_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 19, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Monroe"));
    ds_grid_set(levelsplit, 0, 20, ds_grid_get(obj_stat_holder.ford_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 20, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Ford"));
    ds_grid_set(levelsplit, 0, 21, ds_grid_get(obj_stat_holder.iris_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 21, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Iris"));
    ds_grid_set(levelsplit, 0, 22, ds_grid_get(obj_stat_holder.kitara_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 22, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Maeve"));
    ds_grid_set(levelsplit, 0, 23, ds_grid_get(obj_stat_holder.thaelanel_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 23, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Thae'Lanel"));
    ds_grid_set(levelsplit, 0, 24, ds_grid_get(obj_stat_holder.wren_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 24, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Wren"));
    ds_grid_set(levelsplit, 0, 25, ds_grid_get(obj_stat_holder.faust_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 25, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Faust"));
    ds_grid_set(levelsplit, 0, 26, ds_grid_get(obj_stat_holder.fenton_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 26, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Fenton"));
    ds_grid_set(levelsplit, 0, 28, ds_grid_get(obj_stat_holder.alexa_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 28, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Alexa"));
    ds_grid_set(levelsplit, 0, 27, ds_grid_get(obj_stat_holder.rose_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 27, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Rose"));
    ds_grid_set(levelsplit, 0, 29, ds_grid_get(obj_stat_holder.liberty_stats, 2, 1));
    ds_grid_set(levelsplit, 1, 29, ds_grid_value_x(obj_game_data.characters, 0, 0, 29, 5, "Liberty"));
    ds_grid_sort(levelsplit, 0, true);
    
    for (ii = 0; ii <= 29; ii += 1)
        instance_create(0, 0, ds_grid_get(obj_game_data.characters, ds_grid_get(levelsplit, 1, ii), 1));
    
    ds_grid_destroy(levelsplit);
    
    with (obj_marker_parent)
    {
        scr_update_equipment_all();
        scr_player_creation_updates();
    }
    
    with (obj_marker_parent)
    {
        if (unitid < 6)
        {
            iddisplay = unitid;
        }
        else if (unitid > 5 && unitid < 11)
        {
            iddisplay = unitid - 5;
            height = 1;
        }
        else if (unitid > 10 && unitid < 16)
        {
            iddisplay = unitid - 10;
            height = 2;
        }
        else if (unitid > 15 && unitid < 21)
        {
            iddisplay = unitid - 15;
            height = 3;
        }
        else if (unitid > 20 && unitid < 26)
        {
            iddisplay = unitid - 20;
            height = 4;
        }
        else
        {
            iddisplay = unitid - 25;
            height = 5;
        }
        
        if (unitid > obj_room_info.maxunitid || alive == false)
            instance_destroy();
        else
            selected = false;
    }
    
    battlesavenum = 0;
    
    if (ds_grid_get(obj_game_data.data, 0, 12) != false)
    {
        battlesave = ds_grid_create(30, 3);
        ds_grid_read(battlesave, ds_grid_get(obj_game_data.data, 0, 12));
        
        with (obj_marker_parent)
        {
            if (ds_grid_get(other.battlesave, other.battlesavenum, 0) == 1)
            {
                selected = true;
                x = ds_grid_get(other.battlesave, other.battlesavenum, 1);
                y = ds_grid_get(other.battlesave, other.battlesavenum, 2);
                obj_room_info.selectedtotal += 1;
                
                with (obj_swapspot)
                {
                    if (x == other.x && y == other.y)
                        occupant = other;
                }
            }
            else
            {
                selected = false;
            }
            
            other.battlesavenum += 1;
        }
        
        ds_grid_destroy(battlesave);
    }
    else
    {
        ganba = ds_grid_create(2, 30);
        ganba2 = 0;
        
        with (obj_marker_parent)
        {
            ds_grid_add(other.ganba, 0, other.ganba2, id);
            ds_grid_add(other.ganba, 1, other.ganba2, level);
            other.ganba2 += 1;
        }
        
        ds_grid_sort(ganba, 1, false);
        
        for (ii = 0; ii <= 29; ii += 1)
        {
            if (ds_grid_get(ganba, 0, ii) != 0)
            {
                if (obj_room_info.selectedtotal < obj_room_info.selectabletotal)
                {
                    with (ds_grid_get(ganba, 0, ii))
                        selected = true;
                    
                    obj_room_info.selectedtotal += 1;
                }
            }
        }
        
        ds_grid_destroy(ganba);
        
        with (obj_marker_parent)
        {
            if (selected)
            {
                with (obj_swapspot)
                {
                    if ((other.x == 0 || other.y == 0) && (occupant == -4 || occupant == other))
                    {
                        if (occupant == -4)
                            occupant = other;
                        
                        other.x = x;
                        other.y = y;
                    }
                }
            }
        }
    }
}
else if (global.battlesaver)
{
    ini_open("Battlesave.ini");
    midsave_players = ds_list_create();
    midsave_enemies = ds_list_create();
    midsave_turnscript = ds_list_create();
    midsave_objectives = ds_list_create();
    midsave_hazards = ds_list_create();
    midsave_specific = ds_list_create();
    ds_list_read(midsave_players, ini_read_string("Saves", "1", ""));
    ds_list_read(midsave_enemies, ini_read_string("Saves", "2", ""));
    ds_list_read(midsave_turnscript, ini_read_string("Saves", "3", ""));
    ds_list_read(midsave_objectives, ini_read_string("Saves", "4", ""));
    ds_list_read(midsave_hazards, ini_read_string("Saves", "5", ""));
    ds_list_read(midsave_specific, ini_read_string("Saves", "7", ""));
    
    if (instance_exists(obj_room_info))
    {
        var gridstring = ini_read_string("Saves", "8", "");
        
        if (gridstring != "")
            ds_grid_read(obj_room_info.gamestats, gridstring);
    }
    
    with (obj_swapspot)
        instance_destroy();
    
    with (obj_actor)
    {
        if (army == 20)
        {
            global.map[x / 32][y / 32].occupant = -4;
            instance_destroy();
        }
    }
    
    for (ii = 0; ii <= (ds_list_size(midsave_players) - 4); ii += 4)
    {
        var unit1 = -4;
        
        switch (ds_list_find_value(midsave_players, ii))
        {
            case "Irving":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_irving);
                break;
            
            case "Garrick":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_garrick);
                break;
            
            case "Maren":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_maren);
                break;
            
            case "Alden":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_alden);
                break;
            
            case "Cia":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_cia);
                break;
            
            case "Elias":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_elias);
                break;
            
            case "Lincoln":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_lincoln);
                break;
            
            case "Bianca":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_bianca);
                break;
            
            case "Sophia":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_sophia);
                break;
            
            case "Sloane":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_sloane);
                break;
            
            case "Brooke":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_brooke);
                break;
            
            case "Benji":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_benji);
                break;
            
            case "Caius":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_caius);
                break;
            
            case "Sara":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_sara);
                break;
            
            case "Samara":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_samara);
                break;
            
            case "Corvan":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_corvan);
                break;
            
            case "Helena":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_helena);
                break;
            
            case "Aurima":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_aurima);
                break;
            
            case "Vesta":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_vesta);
                break;
            
            case "Ford":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_ford);
                break;
            
            case "Monroe":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_monroe);
                break;
            
            case "Iris":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_iris);
                break;
            
            case "Maeve":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_kitara);
                break;
            
            case "Thae'Lanel":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_thaelanel);
                break;
            
            case "Wren":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_wren);
                break;
            
            case "Faust":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_faust);
                break;
            
            case "Fenton":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_fenton);
                break;
            
            case "Alexa":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_alexa);
                break;
            
            case "Rose":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_rose);
                break;
            
            case "Liberty":
                unit1 = instance_create(ds_list_find_value(midsave_players, ii + 1), ds_list_find_value(midsave_players, ii + 2), obj_liberty);
                break;
        }
        
        if (unit1 != -4)
        {
            with (unit1)
            {
                x = ds_list_find_value(other.midsave_players, ds_list_find_index(other.midsave_players, name) + 1);
                y = ds_list_find_value(other.midsave_players, ds_list_find_index(other.midsave_players, name) + 2);
                tempHP = ds_list_find_value(other.midsave_players, ds_list_find_index(other.midsave_players, name) + 3);
                GridX = x / 32;
                GridY = y / 32;
                global.map[GridX][GridY].occupant = id;
            }
        }
    }
    
    with (obj_ai_controller)
    {
        if (ds_list_find_index(other.midsave_enemies, id) != -1)
        {
            x = ds_list_find_value(other.midsave_enemies, ds_list_find_index(other.midsave_enemies, id) + 1);
            y = ds_list_find_value(other.midsave_enemies, ds_list_find_index(other.midsave_enemies, id) + 2);
            tempHP = ds_list_find_value(other.midsave_enemies, ds_list_find_index(other.midsave_enemies, id) + 3);
            GridX = x / 32;
            GridY = y / 32;
            
            with (obj_node)
            {
                if (occupant == other.id)
                    occupant = -4;
            }
            
            global.map[GridX][GridY].occupant = id;
        }
        else
        {
            if (global.map[x / 32][y / 32].occupant == id)
                global.map[x / 32][y / 32].occupant = -4;
            
            instance_destroy();
        }
    }
    
    with (obj_turn_scripter)
    {
        turn = ds_list_find_value(other.midsave_turnscript, 0);
        
        with (obj_game)
            turn_counter = other.turn;
        
        P = ds_list_find_value(other.midsave_turnscript, 1);
        dongus = ds_list_find_value(other.midsave_turnscript, 2);
        dingus = ds_list_find_value(other.midsave_turnscript, 3);
        gabagoo = ds_list_find_value(other.midsave_turnscript, 4);
        gg = ds_list_find_value(other.midsave_turnscript, 5);
        aqueduct = ds_list_find_value(other.midsave_turnscript, 6);
        counter = ds_list_find_value(other.midsave_turnscript, 7);
        porter = ds_list_find_value(other.midsave_turnscript, 8);
        param1 = ds_list_find_value(other.midsave_turnscript, 9);
    }
    
    with (obj_hazard)
        instance_destroy();
    
    with (obj_cursor_preparing)
        instance_destroy();
    
    with (obj_objective_parent)
    {
        allowed = false;
        
        for (ii = 0; ii <= (ds_list_size(other.midsave_objectives) - 3); ii += 3)
        {
            if (x == ds_list_find_value(other.midsave_objectives, ii + 1) && y == ds_list_find_value(other.midsave_objectives, ii + 2) && ds_list_find_value(other.midsave_objectives, ii) == asset_get_index(object_get_name(object_index)))
                allowed = true;
        }
        
        if (allowed == false)
            instance_destroy();
    }
    
    if (!ds_list_empty(midsave_objectives))
    {
        for (ii = 0; ii <= (ds_list_size(midsave_objectives) - 3); ii += 3)
        {
            if (collision_point(ds_list_find_value(midsave_objectives, ii + 1) + 16, ds_list_find_value(midsave_objectives, ii + 2) + 16, ds_list_find_value(midsave_objectives, ii), false, true) == -4)
                instance_create_depth(ds_list_find_value(midsave_objectives, ii + 1), ds_list_find_value(midsave_objectives, ii + 2), 0, ds_list_find_value(midsave_objectives, ii));
        }
    }
    
    if (!ds_list_empty(midsave_hazards))
    {
        for (ii = 0; ii <= (ds_list_size(midsave_hazards) - 3); ii += 3)
            instance_create_depth(ds_list_find_value(midsave_hazards, ii + 1), ds_list_find_value(midsave_hazards, ii + 2), 0, ds_list_find_value(midsave_hazards, ii));
    }
    
    with (obj_actor)
        scr_update_equipment_all();
    
    if (room == room_l22)
    {
        if (!ds_list_empty(midsave_specific))
        {
            for (ii = 0; ii <= (ds_list_size(midsave_specific) - 4); ii += 4)
            {
                if (array_get(array_get(global.map, ds_list_find_value(midsave_specific, ii + 1) / 32), ds_list_find_value(midsave_specific, ii + 2) / 32).occupant == -4)
                {
                    with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_knight))
                    {
                        rusher = true;
                        xpvalue = 14;
                        GridX = x / 32;
                        GridY = y / 32;
                        nodeimon = global.map[GridX][GridY];
                        global.map[GridX][GridY].occupant = id;
                        scr_enemy_growth();
                        scr_update_equipment_all();
                        tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                    }
                }
            }
        }
    }
    
    if (room == room_l14)
    {
        if (!ds_list_empty(midsave_specific))
        {
            for (ii = 0; ii <= (ds_list_size(midsave_specific) - 4); ii += 4)
            {
                if (array_get(array_get(global.map, ds_list_find_value(midsave_specific, ii + 1) / 32), ds_list_find_value(midsave_specific, ii + 2) / 32).occupant == -4)
                {
                    with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_raider))
                    {
                        GridX = x / 32;
                        GridY = y / 32;
                        xpvalue = 15;
                        name = "Sylvan";
                        global.map[GridX][GridY].occupant = id;
                        level = 25;
                        rusher = true;
                        scr_enemy_growth();
                        scr_update_equipment_all();
                        tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                    }
                }
            }
        }
    }
    
    if (room == room_l17)
    {
        if (!ds_list_empty(midsave_specific))
        {
            for (ii = 0; ii <= (ds_list_size(midsave_specific) - 4); ii += 4)
            {
                if (array_get(array_get(global.map, ds_list_find_value(midsave_specific, ii + 1) / 32), ds_list_find_value(midsave_specific, ii + 2) / 32).occupant == -4)
                {
                    if (ds_list_find_value(midsave_specific, ii) == "Tiana")
                    {
                        with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_dragonknight))
                        {
                            name = "Tiana";
                            boss = true;
                            xpvalue = 30;
                            level = 35;
                            rusher = true;
                            droppable = true;
                            droppable_item = 371;
                            move = 8;
                            head = 1258;
                            fullportrait = 1214;
                            idlesprite = 1076;
                            sprite_index = spr_tiana_idle;
                            movesprite = 1077;
                            scr_enemy_growth();
                            scr_update_equipment_all();
                            GridX = x / 32;
                            GridY = y / 32;
                            global.map[GridX][GridY].occupant = id;
                            global.map[GridX][GridY].passable = true;
                            tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                        }
                    }
                    else
                    {
                        with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_knight))
                        {
                            name = "Elite Guard";
                            level = 30;
                            xpvalue = 1;
                            rusher = true;
                            equippedcoord = 4;
                            scr_enemy_growth();
                            scr_update_equipment_all();
                            GridX = x / 32;
                            GridY = y / 32;
                            global.map[GridX][GridY].occupant = id;
                            global.map[GridX][GridY].passable = true;
                            tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                        }
                    }
                }
            }
        }
    }
    
    if (room == Room_l27)
    {
        if (!ds_list_empty(midsave_specific))
        {
            for (ii = 0; ii <= (ds_list_size(midsave_specific) - 4); ii += 4)
            {
                if (array_get(array_get(global.map, ds_list_find_value(midsave_specific, ii + 1) / 32), ds_list_find_value(midsave_specific, ii + 2) / 32).occupant == -4)
                {
                    if (ds_list_find_value(midsave_specific, ii) == "Dragoon")
                    {
                        with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_dragoon))
                        {
                            GridX = x / 32;
                            GridY = y / 32;
                            rusher = true;
                            nodeimon = global.map[GridX][GridY];
                            global.map[GridX][GridY].occupant = id;
                            scr_enemy_growth();
                            scr_update_equipment_all();
                            tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                        }
                    }
                    else if (ds_list_find_value(midsave_specific, ii) == "Acolyte")
                    {
                        with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_acolyte))
                        {
                            GridX = x / 32;
                            GridY = y / 32;
                            rusher = true;
                            nodeimon = global.map[GridX][GridY];
                            global.map[GridX][GridY].occupant = id;
                            scr_enemy_growth();
                            scr_update_equipment_all();
                            tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                        }
                    }
                    else if (ds_list_find_value(midsave_specific, ii) == "Reverie")
                    {
                        with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_reverie))
                        {
                            GridX = x / 32;
                            GridY = y / 32;
                            rusher = true;
                            nodeimon = global.map[GridX][GridY];
                            global.map[GridX][GridY].occupant = id;
                            scr_enemy_growth();
                            scr_update_equipment_all();
                            tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                        }
                    }
                    else if (ds_list_find_value(midsave_specific, ii) == "Surge")
                    {
                        with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_surge))
                        {
                            GridX = x / 32;
                            GridY = y / 32;
                            rusher = true;
                            nodeimon = global.map[GridX][GridY];
                            global.map[GridX][GridY].occupant = id;
                            scr_enemy_growth();
                            scr_update_equipment_all();
                            tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                        }
                    }
                    else if (ds_list_find_value(midsave_specific, ii) == "Blaze")
                    {
                        with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_blaze))
                        {
                            GridX = x / 32;
                            GridY = y / 32;
                            rusher = true;
                            nodeimon = global.map[GridX][GridY];
                            global.map[GridX][GridY].occupant = id;
                            scr_enemy_growth();
                            scr_update_equipment_all();
                            tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                        }
                    }
                }
            }
        }
        
        if (room == room_ch_newageoldworld)
        {
            if (!ds_list_empty(midsave_specific))
            {
                for (ii = 0; ii <= (ds_list_size(midsave_specific) - 4); ii += 4)
                {
                    if (array_get(array_get(global.map, ds_list_find_value(midsave_specific, ii + 1) / 32), ds_list_find_value(midsave_specific, ii + 2) / 32).occupant == -4)
                    {
                        if (ds_list_find_value(midsave_specific, ii) == "Conjurer")
                        {
                            with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_conjurer))
                            {
                                GridX = x / 32;
                                GridY = y / 32;
                                global.map[GridX][GridY].occupant = id;
                                rusher = true;
                                equippedcoord = 202;
                                ds_priority_add(other.characters, id, other.ii);
                                name = "Undead";
                                scr_undead();
                                level = 18;
                                scr_enemy_growth();
                                scr_update_equipment_all();
                                tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                            }
                        }
                        else if (ds_list_find_value(midsave_specific, ii) == "Stalker")
                        {
                            with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_stalker))
                            {
                                GridX = x / 32;
                                GridY = y / 32;
                                global.map[GridX][GridY].occupant = id;
                                rusher = true;
                                equippedcoord = 154;
                                ds_priority_add(other.characters, id, other.ii);
                                name = "Undead";
                                scr_undead();
                                level = 18;
                                scr_enemy_growth();
                                scr_update_equipment_all();
                                tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                            }
                        }
                        else if (ds_list_find_value(midsave_specific, ii) == "Drifter")
                        {
                            with (instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_enemy_delian_drifter))
                            {
                                GridX = x / 32;
                                GridY = y / 32;
                                global.map[GridX][GridY].occupant = id;
                                rusher = true;
                                equippedcoord = 42;
                                ds_priority_add(other.characters, id, other.ii);
                                name = "Undead";
                                scr_undead();
                                level = 18;
                                scr_enemy_growth();
                                scr_update_equipment_all();
                                tempHP = ds_list_find_value(other.midsave_specific, other.ii + 3);
                            }
                        }
                    }
                }
            }
        }
    }
    
    if (room == room_l15_1)
    {
        for (ii = 0; ii <= (ds_list_size(midsave_specific) - 5); ii += 5)
        {
            var unit1 = -4;
            
            switch (ds_list_find_value(midsave_specific, ii))
            {
                case "Irving":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_irving_enemy);
                    break;
                
                case "Garrick":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_garrick_enemy);
                    break;
                
                case "Maren":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_maren_enemy);
                    break;
                
                case "Alden":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_alden_enemy);
                    break;
                
                case "Cia":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_cia_enemy);
                    break;
                
                case "Elias":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_elias_enemy);
                    break;
                
                case "Lincoln":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_lincoln_enemy);
                    break;
                
                case "Bianca":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_bianca_enemy);
                    break;
                
                case "Sophia":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_sophia_enemy);
                    break;
                
                case "Sloane":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_sloane_enemy);
                    break;
                
                case "Brooke":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_brooke_enemy);
                    break;
                
                case "Benji":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_benji_enemy);
                    break;
                
                case "Caius":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_caius_enemy);
                    break;
                
                case "Sara":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_sara_enemy);
                    break;
                
                case "Samara":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_samara_enemy);
                    break;
                
                case "Corvan":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_corvan_enemy);
                    break;
                
                case "Helena":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_helena_enemy);
                    break;
                
                case "Aurima":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_aurima_enemy);
                    break;
                
                case "Vesta":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_vesta_enemy);
                    break;
                
                case "Ford":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_ford_enemy);
                    break;
                
                case "Monroe":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_monroe_enemy);
                    break;
                
                case "Iris":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_iris_enemy);
                    break;
                
                case "Maeve":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_kitara_enemy);
                    break;
                
                case "Thae'Lanel":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_thaelanel_enemy);
                    break;
                
                case "Wren":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_wren_enemy);
                    break;
                
                case "Faust":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_faust_enemy);
                    break;
                
                case "Fenton":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_fenton_enemy);
                    break;
                
                case "Alexa":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_alexa_enemy);
                    break;
                
                case "Rose":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_rose_enemy);
                    break;
                
                case "Liberty":
                    unit1 = instance_create(ds_list_find_value(midsave_specific, ii + 1), ds_list_find_value(midsave_specific, ii + 2), obj_liberty_enemy);
                    break;
            }
            
            if (unit1 != -4)
            {
                with (unit1)
                {
                    army = 10;
                    head = ds_list_find_value(other.midsave_specific, other.ii + 4);
                    x = ds_list_find_value(other.midsave_specific, ds_list_find_index(other.midsave_specific, name) + 1);
                    y = ds_list_find_value(other.midsave_specific, ds_list_find_index(other.midsave_specific, name) + 2);
                    tempHP = ds_list_find_value(other.midsave_specific, ds_list_find_index(other.midsave_specific, name) + 3);
                    GridX = x / 32;
                    GridY = y / 32;
                    global.map[GridX][GridY].occupant = id;
                }
            }
        }
    }
    
    ds_list_destroy(midsave_players);
    ds_list_destroy(midsave_enemies);
    ds_list_destroy(midsave_turnscript);
    ds_list_destroy(midsave_objectives);
    ds_list_destroy(midsave_hazards);
    ds_list_destroy(midsave_specific);
    ini_close();
    global.battlesaver = false;
    instance_destroy();
}
else if (room == room_lp || room == room_l1 || room == room_l2 || room == room_ch_4 || room == room_story_1_level || room == room_story_2_level || room == room_story_3_level || room == room_story_4_level || room == room_story_5_level || room == room_story_6_level || room == room_story_7_level)
{
    with (obj_cursor_preparing)
        instance_destroy();
    
    with (obj_turn_scripter)
        turn += 1;
    
    with (obj_game)
        turn_counter += 1;
    
    obj_game.state = "player turn draw";
    
    with (obj_actor)
    {
        if (army == 20)
        {
            GridX = x / 32;
            GridY = y / 32;
            global.map[GridX][GridY].occupant = id;
        }
    }
    
    global.map[0][0].occupant = -4;
    instance_destroy();
}
