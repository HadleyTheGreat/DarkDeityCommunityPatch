if (room > room0)
{
    midsave_players = ds_list_create();
    midsave_enemies = ds_list_create();
    midsave_turnscript = ds_list_create();
    midsave_objectives = ds_list_create();
    midsave_hazards = ds_list_create();
    midsave_specific = ds_list_create();
    ini_open("Battlesave.ini");
    
    with (obj_actor)
    {
        if (army == 20)
        {
            ds_list_add(other.midsave_players, name);
            ds_list_add(other.midsave_players, GridX * 32);
            ds_list_add(other.midsave_players, GridY * 32);
            ds_list_add(other.midsave_players, tempHP);
        }
        else
        {
            ds_list_add(other.midsave_enemies, id);
            ds_list_add(other.midsave_enemies, GridX * 32);
            ds_list_add(other.midsave_enemies, GridY * 32);
            ds_list_add(other.midsave_enemies, tempHP);
        }
    }
    
    with (obj_turn_scripter)
    {
        ds_list_add(other.midsave_turnscript, turn + 1);
        ds_list_add(other.midsave_turnscript, P + 1);
        ds_list_add(other.midsave_turnscript, dongus);
        ds_list_add(other.midsave_turnscript, dingus);
        ds_list_add(other.midsave_turnscript, gabagoo);
        ds_list_add(other.midsave_turnscript, gg);
        ds_list_add(other.midsave_turnscript, aqueduct);
        ds_list_add(other.midsave_turnscript, counter);
        ds_list_add(other.midsave_turnscript, porter);
        ds_list_add(other.midsave_turnscript, param1);
    }
    
    with (obj_objective_parent)
    {
        ds_list_add(other.midsave_objectives, asset_get_index(object_get_name(object_index)));
        ds_list_add(other.midsave_objectives, x);
        ds_list_add(other.midsave_objectives, y);
    }
    
    with (obj_hazard)
    {
        ds_list_add(other.midsave_hazards, asset_get_index(object_get_name(object_index)));
        ds_list_add(other.midsave_hazards, x);
        ds_list_add(other.midsave_hazards, y);
    }
    
    ini_write_string("Saves", "7", ds_list_write(midsave_specific));
    
    if (room == room_ch_newageoldworld)
    {
        with (obj_actor)
        {
            ds_list_add(other.midsave_specific, class);
            ds_list_add(other.midsave_specific, GridX * 32);
            ds_list_add(other.midsave_specific, GridY * 32);
            ds_list_add(other.midsave_specific, tempHP);
        }
        
        ini_write_string("Saves", "7", ds_list_write(midsave_specific));
    }
    
    if (room == room_l22)
    {
        with (obj_actor)
        {
            ds_list_add(other.midsave_specific, class);
            ds_list_add(other.midsave_specific, GridX * 32);
            ds_list_add(other.midsave_specific, GridY * 32);
            ds_list_add(other.midsave_specific, tempHP);
        }
        
        ini_write_string("Saves", "7", ds_list_write(midsave_specific));
    }
    
    if (room == room_l14)
    {
        with (obj_actor)
        {
            ds_list_add(other.midsave_specific, class);
            ds_list_add(other.midsave_specific, GridX * 32);
            ds_list_add(other.midsave_specific, GridY * 32);
            ds_list_add(other.midsave_specific, tempHP);
        }
        
        ini_write_string("Saves", "7", ds_list_write(midsave_specific));
    }
    
    if (room == room_l17)
    {
        with (obj_actor)
        {
            ds_list_add(other.midsave_specific, name);
            ds_list_add(other.midsave_specific, GridX * 32);
            ds_list_add(other.midsave_specific, GridY * 32);
            ds_list_add(other.midsave_specific, tempHP);
        }
        
        ini_write_string("Saves", "7", ds_list_write(midsave_specific));
    }
    
    if (room == Room_l27)
    {
        with (obj_actor)
        {
            ds_list_add(other.midsave_specific, class);
            ds_list_add(other.midsave_specific, GridX * 32);
            ds_list_add(other.midsave_specific, GridY * 32);
            ds_list_add(other.midsave_specific, tempHP);
        }
        
        ini_write_string("Saves", "7", ds_list_write(midsave_specific));
    }
    
    if (room == room_endgame)
    {
    }
    
    if (room == room_l15_1)
    {
        with (obj_ai_controller)
        {
            ds_list_add(other.midsave_specific, name);
            ds_list_add(other.midsave_specific, GridX * 32);
            ds_list_add(other.midsave_specific, GridY * 32);
            ds_list_add(other.midsave_specific, tempHP);
            ds_list_add(other.midsave_specific, head);
        }
        
        ini_write_string("Saves", "7", ds_list_write(midsave_specific));
    }
    
    ini_write_string("Saves", "1", ds_list_write(midsave_players));
    ini_write_string("Saves", "2", ds_list_write(midsave_enemies));
    ini_write_string("Saves", "3", ds_list_write(midsave_turnscript));
    ini_write_string("Saves", "4", ds_list_write(midsave_objectives));
    ini_write_string("Saves", "5", ds_list_write(midsave_hazards));
    ini_write_real("Saves", "6", room);
    ini_write_string("Saves", "8", ds_grid_write(obj_room_info.gamestats));
    ini_close();
    ds_list_destroy(midsave_players);
    ds_list_destroy(midsave_enemies);
    ds_list_destroy(midsave_turnscript);
    ds_list_destroy(midsave_objectives);
    ds_list_destroy(midsave_hazards);
    ds_list_destroy(midsave_specific);
}
