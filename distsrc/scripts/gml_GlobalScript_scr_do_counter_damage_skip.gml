function scr_do_counter_damage_skip()
{
    animdamage1 = 0;
    
    if (global.attacker.attacktarget.itemname5 == "Chamden's Flux")
        global.attacker.attacktarget.truedamage = round(global.attacker.attacktarget.truedamage * (1 + random_range(-0.3, 0.3)));
    
    if (global.attacker.attacktarget.truedamage == 0 && global.attacker.army == 20 && status != "miss")
        steam_set_achievement("Achieve_2");
    
    if (status == "hit")
    {
        if (global.attacker.attacktarget.army == 20)
        {
            if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name) != -1)
                ds_grid_set(obj_room_info.gamestats, 1, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name), ds_grid_get(obj_room_info.gamestats, 1, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name)) + global.attacker.attacktarget.truedamage);
        }
        else if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name) != -1)
        {
            ds_grid_set(obj_room_info.gamestats, 2, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name), ds_grid_get(obj_room_info.gamestats, 2, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name)) + global.attacker.attacktarget.truedamage);
        }
        
        global.attacker.tempHP = round(max(global.attacker.tempHP - global.attacker.attacktarget.truedamage, 0));
        
        if (ds_grid_value_exists(global.attacker.attacktarget.skillslots, 0, 0, 1, 10, "Dream Eater") || ds_grid_value_exists(global.attacker.attacktarget.skillslots, 0, 0, 1, 10, "Sorcerer's Siphon") || ds_grid_value_exists(global.attacker.attacktarget.skillslots, 0, 0, 1, 10, "Consumption"))
        {
            global.attacker.attacktarget.tempHP += round(global.attacker.attacktarget.truedamage / 3);
            
            if (global.attacker.attacktarget.tempHP > HP)
                global.attacker.attacktarget.tempHP = HP;
        }
    }
    else if (status == "crit")
    {
        if (ds_list_find_index(obj_game.combatskills, "Critical") == -1)
            ds_list_add(obj_game.combatskills, "Critical");
        
        if (global.attacker.attacktarget.army == 20)
        {
            if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name) != -1)
            {
                ds_grid_set(obj_room_info.gamestats, 1, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name), ds_grid_get(obj_room_info.gamestats, 1, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name)) + (global.attacker.attacktarget.truedamage * global.attacker.attacktarget.critmod));
                ds_grid_set(obj_room_info.gamestats, 6, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name), ds_grid_get(obj_room_info.gamestats, 6, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name)) + 1);
            }
        }
        else if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name) != -1)
        {
            ds_grid_set(obj_room_info.gamestats, 2, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name), ds_grid_get(obj_room_info.gamestats, 2, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name)) + (global.attacker.attacktarget.truedamage * global.attacker.attacktarget.critmod));
        }
        
        global.attacker.tempHP = round(max(global.attacker.tempHP - (global.attacker.attacktarget.truedamage * global.attacker.attacktarget.critmod), 0));
        
        if (ds_grid_value_exists(global.attacker.attacktarget.skillslots, 0, 0, 1, 10, "Dream Eater") || ds_grid_value_exists(global.attacker.attacktarget.skillslots, 0, 0, 1, 10, "Sorcerer's Siphon") || ds_grid_value_exists(global.attacker.attacktarget.skillslots, 0, 0, 1, 10, "Consumption"))
        {
            global.attacker.attacktarget.tempHP += round((global.attacker.attacktarget.truedamage * global.attacker.attacktarget.critmod) / 3);
            
            if (global.attacker.attacktarget.tempHP > HP)
                global.attacker.attacktarget.tempHP = HP;
        }
        
        if (global.attacker.attacktarget.name == "Iris")
        {
            global.attacker.attacktarget.tempHP += round((global.attacker.attacktarget.truedamage * global.attacker.attacktarget.critmod) / 5);
            
            if (global.attacker.attacktarget.tempHP > HP)
                global.attacker.attacktarget.tempHP = HP;
        }
    }
    
    if (class_index == "Exile")
    {
        if (army == 20)
        {
            if (ds_grid_value_exists(skillslots, 0, 0, 1, 10, "Swiftwind"))
            {
                if (random_range(0, 100) < 10)
                {
                    if (global.attacker.tempHP > 0)
                    {
                        if (ds_list_find_index(obj_game.combatskills, "Swiftwind") == -1)
                            ds_list_add(obj_game.combatskills, "Swiftwind");
                        
                        if (global.attacker.state != "ending attack")
                        {
                            global.attacker.state = "countering";
                            other.ender = true;
                        }
                        else
                        {
                            other.ender = true;
                            global.attacker.state = "waiting for double";
                        }
                    }
                }
            }
        }
    }
    
    if (status == "miss")
    {
        if (global.attacker.army == 20)
        {
            if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name) != -1)
                ds_grid_set(obj_room_info.gamestats, 7, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name), ds_grid_get(obj_room_info.gamestats, 7, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.name)) + 1);
        }
    }
    else if (global.attacker.attacktarget.army == 20)
    {
        if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name) != -1)
            ds_grid_set(obj_room_info.gamestats, 5, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name), ds_grid_get(obj_room_info.gamestats, 5, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, global.attacker.attacktarget.name)) + 1);
    }
    
    return animdamage1;
}
