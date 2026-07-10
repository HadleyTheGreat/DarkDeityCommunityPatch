function scr_do_damage_skip()
{
    animdamage1 = 0;
    
    if (global.attacker.itemname5 == "Chamden's Flux")
        global.attacker.truedamage = round(global.attacker.truedamage * (1 + random_range(-0.3, 0.3)));
    
    if (global.attacker.truedamage == 0 && global.attacker.army == 10 && status != "miss")
        steam_set_achievement("Achieve_2");
    
    if (status == "hit")
    {
        if (global.attacker.army == 20)
        {
            if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name) != -1)
                ds_grid_set(obj_room_info.gamestats, 1, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name), ds_grid_get(obj_room_info.gamestats, 1, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name)) + global.attacker.truedamage);
        }
        else if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name) != -1)
        {
            ds_grid_set(obj_room_info.gamestats, 2, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name), ds_grid_get(obj_room_info.gamestats, 2, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name)) + global.attacker.truedamage);
        }
        
        global.attacker.attacktarget.tempHP = round(max(global.attacker.attacktarget.tempHP - global.attacker.truedamage, 0));
        
        if (ds_grid_value_exists(global.attacker.skillslots, 0, 0, 1, 10, "Dream Eater") || ds_grid_value_exists(global.attacker.skillslots, 0, 0, 1, 10, "Sorcerer's Siphon") || ds_grid_value_exists(global.attacker.skillslots, 0, 0, 1, 10, "Consumption"))
        {
            global.attacker.tempHP += round(global.attacker.truedamage / 3);
            
            if (global.attacker.tempHP > HP)
                global.attacker.tempHP = HP;
        }
    }
    else if (status == "crit")
    {
        if (ds_list_find_index(obj_game.combatskills, "Critical") == -1)
            ds_list_add(obj_game.combatskills, "Critical");
        
        if (global.attacker.army == 20)
        {
            if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name) != -1)
            {
                ds_grid_set(obj_room_info.gamestats, 1, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name), ds_grid_get(obj_room_info.gamestats, 1, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name)) + (global.attacker.truedamage * global.attacker.critmod));
                ds_grid_set(obj_room_info.gamestats, 6, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name), ds_grid_get(obj_room_info.gamestats, 6, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name)) + 1);
            }
        }
        else if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name) != -1)
        {
            ds_grid_set(obj_room_info.gamestats, 2, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name), ds_grid_get(obj_room_info.gamestats, 2, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name)) + (global.attacker.truedamage * global.attacker.critmod));
        }
        
        global.attacker.attacktarget.tempHP = round(max(global.attacker.attacktarget.tempHP - (global.attacker.truedamage * global.attacker.critmod), 0));
        
        if (ds_grid_value_exists(global.attacker.skillslots, 0, 0, 1, 10, "Dream Eater") || ds_grid_value_exists(global.attacker.skillslots, 0, 0, 1, 10, "Consumption") || ds_grid_value_exists(global.attacker.skillslots, 0, 0, 1, 10, "Sorcerer's Siphon"))
        {
            global.attacker.tempHP += round((global.attacker.truedamage * global.attacker.critmod) / 3);
            
            if (global.attacker.tempHP > HP)
                global.attacker.tempHP = HP;
        }
        
        if (global.attacker.name == "Iris")
        {
            global.attacker.tempHP += round((global.attacker.truedamage * global.attacker.critmod) / 5);
            
            if (global.attacker.tempHP > HP)
                global.attacker.tempHP = HP;
        }
    }
    
    if (class_index == "Exile")
    {
        if (ds_grid_value_exists(skillslots, 0, 0, 1, 10, "Swiftwind"))
        {
            if (random_range(0, 100) < 20)
            {
                if (global.attacker.attacktarget.tempHP > 0)
                {
                    if (ds_list_find_index(obj_game.combatskills, "Swiftwind") == -1)
                        ds_list_add(obj_game.combatskills, "Swiftwind");
                    
                    if (state != "ending attack")
                    {
                        state = "continue attacking";
                        other.ender = true;
                    }
                    else
                    {
                        other.ender = true;
                        state = "waiting for double";
                    }
                }
            }
        }
    }
    
    if (status == "miss")
    {
        if (global.attacker.attacktarget.army == 20)
        {
            if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name) != -1)
                ds_grid_set(obj_room_info.gamestats, 7, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name), ds_grid_get(obj_room_info.gamestats, 7, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name)) + 1);
        }
    }
    else if (global.attacker.army == 20)
    {
        if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name) != -1)
            ds_grid_set(obj_room_info.gamestats, 5, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name), ds_grid_get(obj_room_info.gamestats, 5, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name)) + 1);
    }
    
    return animdamage1;
}
