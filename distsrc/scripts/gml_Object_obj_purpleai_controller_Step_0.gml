nodeimon = global.map[GridX][GridY];

if (instance_exists(obj_animator))
{
    if (id == global.attacker || id == global.attacker.attacktarget)
    {
        if (frame < sprite_get_number(combsprite))
            frame += 0.2;
        else
            frame = 0;
    }
}

switch (state)
{
    case "idle":
        break;
    
    case "deciding action":
        if (hostile == true || temprush == true)
        {
            wanttoattack = false;
            
            if (placeholder == false)
            {
                i = 1;
                
                with (obj_actor)
                {
                    if (army == 10)
                        other.i += 1;
                }
                
                targets = ds_grid_create(3, i);
                targetmove = -4;
                i = 0;
                
                with (obj_actor)
                {
                    if (army == 10)
                    {
                        scr_priority();
                        ds_grid_set(other.targets, 0, other.i, priority);
                        ds_grid_set(other.targets, 1, other.i, id);
                        ds_grid_set(other.targets, 2, other.i, distance_to_object(other));
                        other.i += 1;
                    }
                }
                
                scr_wipe_nodes();
                scr_movement_range_ai(global.map[GridX][GridY], move, actions);
                ds_grid_sort(targets, 0, false);
                
                for (ii = 0; ii <= i; ii += 1)
                {
                    if (ds_exists(targets, ds_type_grid))
                        targetselect = ds_grid_get(targets, 1, ii);
                    
                    if (targetselect != 0)
                    {
                        targetspot = targetselect.nodeimon;
                        current = -4;
                        targetmove = -4;
                        
                        if (onlyranged || attacktype == "ranged")
                        {
                            if (ds_exists(nodeimon.viewneighborsranged, ds_type_list))
                            {
                                if (ds_list_find_index(nodeimon.viewneighborsranged, targetspot) != -1)
                                {
                                    attacktarget = targetselect;
                                    state = "begin attack";
                                }
                            }
                        }
                        else if (ds_exists(nodeimon.viewneighborsmelee, ds_type_list))
                        {
                            if (ds_list_find_index(nodeimon.viewneighborsmelee, targetspot) != -1)
                            {
                                attacktarget = targetselect;
                                state = "begin attack";
                            }
                        }
                        
                        with (obj_node)
                        {
                            if (movenode && (occupant == -4 || occupant == other) && passable)
                            {
                                if (other.onlyranged)
                                {
                                    if (ds_exists(viewneighborsranged, ds_type_list))
                                    {
                                        if (ds_list_find_index(viewneighborsranged, other.targetspot) != -1)
                                        {
                                            other.current = id;
                                            other.destination = id;
                                        }
                                    }
                                }
                                else if (other.attacktype == "ranged")
                                {
                                    if (ds_exists(viewneighborsranged, ds_type_list) && ds_exists(viewneighborsmelee, ds_type_list))
                                    {
                                        if (ds_list_find_index(viewneighborsranged, other.targetspot) || ds_list_find_index(viewneighborsmelee, other.targetspot) != -1)
                                        {
                                            if (other.current == -4 || (abs(other.current.GridX - other.targetselect.GridX) + abs(other.current.GridY - other.targetselect.GridY)) < (abs(GridX - other.targetselect.GridX) + abs(GridY - other.targetselect.GridY)))
                                            {
                                                other.current = id;
                                                other.destination = id;
                                            }
                                        }
                                    }
                                }
                                else if (ds_exists(viewneighborsmelee, ds_type_list))
                                {
                                    if (ds_list_find_index(viewneighborsmelee, other.targetspot) != -1)
                                    {
                                        other.current = id;
                                        other.destination = id;
                                    }
                                }
                            }
                        }
                        
                        targetmove = current;
                        
                        if (targetmove != -4)
                        {
                            attacktarget = targetselect;
                            wanttoattack = true;
                            state = "move to target";
                            break;
                        }
                    }
                    
                    if (ii == i && state == "deciding action")
                    {
                        if (rusher)
                        {
                            attackactions = 0;
                            ds_grid_sort(targets, 0, false);
                            targetselect = ds_grid_get(targets, 1, 0);
                            targetmove = -4;
                            scr_movement_range_ai(nodeimon, 1000, 1);
                            nodes = ds_priority_create();
                            nodefinder = -4;
                            tempnodedist = 0;
                            
                            with (obj_node)
                            {
                                if (movenode)
                                {
                                    if (other.nodefinder == -4)
                                    {
                                        other.nodefinder = id;
                                        other.tempnodedist = distance_to_object(other.targetselect);
                                    }
                                    else if (distance_to_object(other.targetselect) < other.tempnodedist)
                                    {
                                        other.nodefinder = id;
                                        other.tempnodedist = distance_to_object(other.targetselect);
                                    }
                                }
                            }
                            
                            current = nodefinder;
                            var ji = 0;
                            
                            if (current != -4)
                            {
                                while (current.parent != -4 && current.occupant != id)
                                {
                                    if (current.movenode)
                                    {
                                        ds_priority_add(nodes, current, ji);
                                        current = current.parent;
                                        ji += 1;
                                    }
                                }
                            }
                            
                            scr_movement_range_ai(nodeimon, move, actions);
                            
                            while (targetmove == -4)
                            {
                                var cur = ds_priority_delete_min(nodes);
                                
                                if (cur != 0)
                                {
                                    if (cur.movenode && cur.occupant == -4)
                                        targetmove = cur;
                                }
                                else
                                {
                                    alarm[6] = 1;
                                    state = "idle";
                                    targetmove = 0;
                                }
                            }
                            
                            ds_priority_destroy(nodes);
                            
                            if (targetmove != 0)
                            {
                                if (targetmove == global.map[GridX][GridY] || targetmove.movenode == false || targetmove.occupant != -4)
                                {
                                    ds_grid_destroy(targets);
                                    alarm[6] = 1;
                                    
                                    if (targetmove == global.map[GridX][GridY])
                                    {
                                        state = "move to target";
                                    }
                                    else
                                    {
                                        attacktarget = -4;
                                        state = "idle";
                                    }
                                }
                                else
                                {
                                    ds_grid_destroy(targets);
                                    state = "move to target";
                                }
                            }
                            else
                            {
                                alarm[6] = 1;
                                attacktarget = -4;
                                state = "idle";
                            }
                        }
                        else
                        {
                            alarm[6] = 1;
                            attacktarget = -4;
                            state = "idle";
                        }
                    }
                }
            }
        }
        else if (healer)
        {
            scr_wipe_nodes();
            scr_movement_range_ai(global.map[GridX][GridY], move, actions);
            wanttoheal = false;
            wanttoattack = false;
            healtarget = -4;
            healtargets = ds_grid_create(3, 10);
            l = 0;
            
            with (obj_actor)
            {
                if (army == 30)
                {
                    if (tempHP < HP)
                    {
                        ds_grid_add(other.healtargets, 0, other.l, id);
                        ds_grid_add(other.healtargets, 1, other.l, distance_to_object(other));
                        ds_grid_add(other.healtargets, 2, other.l, tempHP / HP);
                        other.l += 1;
                    }
                }
            }
            
            ds_grid_sort(healtargets, 2, true);
            
            if (deciding1 == true)
            {
                for (ii = 0; ii <= 15; ii += 1)
                {
                    if (ds_grid_get(healtargets, 2, ii) > 0)
                    {
                        healtarget = ds_grid_get(healtargets, 0, ii);
                        
                        if (healtarget == id)
                        {
                            targetmove = global.map[GridX][GridY];
                            wanttoheal = true;
                            state = "move to healtarget";
                        }
                        
                        if (distance_to_object(healtarget) <= ((move * 32) + 64) && healtarget.GridX > 1 && healtarget.GridY > 1)
                        {
                            for (var neighborindex = 0; neighborindex < ds_list_size(healtarget.nodeimon.neighbors); neighborindex++)
                            {
                                var selectedneighbor = ds_list_find_value(healtarget.nodeimon.neighbors, neighborindex);
                                
                                if (selectedneighbor.movenode && (selectedneighbor.occupant == -4 || selectedneighbor.occupant == id))
                                {
                                    targetmove = selectedneighbor;
                                    wanttoheal = true;
                                    state = "move to healtarget";
                                    break;
                                }
                            }
                            
                            if (global.map[healtarget.GridX + 2][healtarget.GridY].movenode && global.map[healtarget.GridX + 2][healtarget.GridY].occupant == -4)
                            {
                                targetmove = global.map[healtarget.GridX + 2][healtarget.GridY];
                                wanttoheal = true;
                                state = "move to healtarget";
                                break;
                            }
                            
                            if (global.map[healtarget.GridX - 2][healtarget.GridY].movenode && global.map[healtarget.GridX - 2][healtarget.GridY].occupant == -4)
                            {
                                targetmove = global.map[healtarget.GridX - 2][healtarget.GridY];
                                wanttoheal = true;
                                state = "move to healtarget";
                                break;
                            }
                            
                            if (global.map[healtarget.GridX + 1][healtarget.GridY + 1].movenode && global.map[healtarget.GridX + 1][healtarget.GridY + 1].occupant == -4)
                            {
                                targetmove = global.map[healtarget.GridX + 1][healtarget.GridY + 1];
                                wanttoheal = true;
                                state = "move to healtarget";
                                break;
                            }
                            
                            if (global.map[healtarget.GridX - 1][healtarget.GridY + 1].movenode && global.map[healtarget.GridX - 1][healtarget.GridY + 1].occupant == -4)
                            {
                                targetmove = global.map[healtarget.GridX - 1][healtarget.GridY + 1];
                                wanttoheal = true;
                                state = "move to healtarget";
                                break;
                            }
                            
                            if (global.map[healtarget.GridX + 1][healtarget.GridY - 1].movenode && global.map[healtarget.GridX + 1][healtarget.GridY - 1].occupant == -4)
                            {
                                targetmove = global.map[healtarget.GridX == 1][healtarget.GridY - 1];
                                wanttoheal = true;
                                state = "move to healtarget";
                                break;
                            }
                            
                            if (global.map[healtarget.GridX - 1][healtarget.GridY - 1].movenode && global.map[healtarget.GridX - 1][healtarget.GridY - 1].occupant == -4)
                            {
                                targetmove = global.map[healtarget.GridX - 1][healtarget.GridY - 1];
                                wanttoheal = true;
                                state = "move to healtarget";
                                break;
                            }
                            
                            if (global.map[healtarget.GridX][healtarget.GridY + 2].movenode && global.map[healtarget.GridX][healtarget.GridY + 2].occupant == -4)
                            {
                                targetmove = global.map[healtarget.GridX][healtarget.GridY + 2];
                                wanttoheal = true;
                                state = "move to healtarget";
                                break;
                            }
                            
                            if (global.map[healtarget.GridX][healtarget.GridY - 2].movenode && global.map[healtarget.GridX][healtarget.GridY - 2].occupant == -4)
                            {
                                targetmove = global.map[healtarget.GridX][healtarget.GridY - 2];
                                wanttoheal = true;
                                state = "move to healtarget";
                                break;
                            }
                        }
                    }
                    
                    if (ii >= 15)
                        deciding1 = false;
                }
            }
            else
            {
                temprush = true;
                state = "deciding action";
            }
        }
        
        break;
    
    case "move to target":
        camera_set_view_target(view_camera[0], id);
        camera_set_view_border(view_camera[0], 100, 100);
        camera_set_view_speed(view_camera[0], 8, 8);
        temprush = false;
        
        if (targetmove == global.map[GridX][GridY])
            state = "attacking";
        else
            state = "moving to target";
        
        break;
    
    case "move to healtarget":
        camera_set_view_target(view_camera[0], id);
        camera_set_view_border(view_camera[0], 100, 100);
        camera_set_view_speed(view_camera[0], 8, 8);
        temprush = false;
        ds_grid_destroy(healtargets);
        
        if (targetmove == global.map[GridX][GridY])
            state = "find target";
        else
            state = "moving to target";
        
        break;
    
    case "moving to target":
        if (targetmove != -4 || current != -4)
        {
            current = targetmove;
            path = ds_priority_create();
            ds_priority_add(path, current, current.G);
            
            while (current.parent != -4)
            {
                ds_priority_add(path, current.parent, current.parent.G);
                current = current.parent;
                
                if (ds_priority_size(path) > 200)
                    break;
            }
            
            do
            {
                current = ds_priority_delete_min(path);
                path_add_point(movementpath, current.x, current.y, 100);
            }
            until (ds_priority_empty(path));
            
            ds_priority_destroy(path);
            global.map[GridX][GridY].occupant = -4;
            GridX = targetmove.GridX;
            GridY = targetmove.GridY;
            global.map[GridX][GridY].occupant = id;
            i = false;
            alarm[10] = 1;
            state = "begin path";
        }
        else
        {
            alarm[6] = 1;
            state = "idle";
        }
        
        break;
    
    case "begin path":
        if (i)
        {
            if (obj_game.enemyturnskip)
                path_start(movementpath, 1000, path_action_stop, true);
            else
                path_start(movementpath, global.movespeed, path_action_stop, true);
            
            actions -= 1;
            alarm[2] = 60;
            state = "moving";
        }
        
        break;
    
    case "find target":
        scr_wipe_nodes();
        
        if (attacktarget != -4 && wanttoattack)
        {
            state = "begin attack";
        }
        else if (wanttoheal && healtarget != -4)
        {
            state = "begin heal";
        }
        else
        {
            obj_game.alarm[1] = 1;
            state = "idle";
        }
        
        break;
    
    case "begin attack":
        global.attacker = id;
        attackactions -= 1;
        attacktarget.attacktarget = id;
        state = "attacking";
        break;
    
    case "attack waiting one":
        if (i || skipper)
            state = "continue attacking";
        
        break;
    
    case "attacking":
        obj_cursor.cursor_active = false;
        
        if (obj_game.enemyturnskip || global.animations != true)
            skipper = true;
        else
            skipper = false;
        
        skipper = true;
        global.attacker = id;
        scr_melee_attack();
        i = false;
        alarm[10] = 30;
        state = "attack waiting one";
        break;
    
    case "continue attacking":
        global.attacker = id;
        scr_skills_precombat();
        status = scr_hit_calculation(accuracy, attacktarget.dodge, crit, id, attacktarget);
        truedamage = scr_attack_damage(accuracy, damagetype, damagesubtype, pwr, attacktarget.constitution, attacktarget.fortitude, attacktarget.dodge, attacktarget.dtype, masmod, id, attacktarget);
        tempdamage = 0;
        scr_skills_modifydamage();
        
        if (skipper)
            tempdamage = scr_do_damage_skip();
        else
            tempdamage = scr_do_damage();
        
        attackactions -= 1;
        scr_skills_midcombat();
        
        if ((attacktarget.tempHP - tempdamage) > 0 && tempHP > 0)
        {
            if ((abs(abs(GridY - attacktarget.GridY) + abs(GridX - attacktarget.GridX)) == 1 && attacktarget.cancountermelee) || (abs(abs(GridY - attacktarget.GridY) + abs(GridX - attacktarget.GridX)) > 1 && attacktarget.cancounterranged))
            {
                i = false;
                state = "waiting for counter";
            }
            else if (tempHP > 0 && attacktarget.tempHP > 0)
            {
                i = false;
                state = "precheck for double";
            }
        }
        else
        {
            global.attacker = id;
            i = false;
            state = "ending attack";
        }
        
        break;
    
    case "waiting for counter":
        if (i || skipper)
            state = "countering";
        
        break;
    
    case "countering":
        with (attacktarget)
        {
            ds_list_clear(obj_game.combatskills);
            ds_list_clear(obj_game.combatskillscounter);
            scr_skills_precombat();
            status = scr_hit_calculation(accuracy, other.dodge, crit, id, other.id);
            truedamage = scr_attack_damage(accuracy, damagetype, damagesubtype, pwr, other.constitution, other.fortitude, other.dodge, other.dtype, masmod, id, attacktarget);
            scr_skills_counter();
            scr_skills_modifydamage();
            
            if (other.skipper)
                tempdamage = scr_do_counter_damage_skip();
            else
                tempdamage = scr_do_counter_damage();
        }
        
        if ((tempHP - attacktarget.tempdamage) > 0 && attacktarget.tempHP > 0)
        {
            scr_update_equipment_all();
            scr_skills_precombat();
            scr_skills_aftercounter();
            i = false;
            state = "precheck for double";
        }
        else
        {
            i = false;
            state = "ending attack";
        }
        
        break;
    
    case "precheck for double":
        if (i || skipper)
            state = "check for double";
        
        break;
    
    case "check for double":
        if (eff_spd > (attacktarget.eff_spd + 4))
        {
            oppdoubleattackvar = false;
            doubleattackvar = true;
            state = "waiting for double";
        }
        else if (attacktarget.eff_spd > (eff_spd + 4))
        {
            doubleattackvar = false;
            oppdoubleattackvar = true;
            state = "waiting for double";
        }
        else
        {
            i = false;
            alarm[10] = 20;
            state = "ending attack";
        }
        
        break;
    
    case "waiting for double":
        if (doubleattackvar == true)
        {
            ds_list_clear(obj_game.combatskills);
            ds_list_clear(obj_game.combatskillscounter);
            status = scr_hit_calculation(accuracy, attacktarget.dodge, crit, id, attacktarget);
            
            if (ds_grid_value_exists(skillslots, 0, 0, 1, 10, "Quick Hands"))
            {
                if (status == "miss")
                    status = "hit";
            }
            
            truedamage = scr_attack_damage(accuracy, damagetype, damagesubtype, pwr, attacktarget.constitution, attacktarget.fortitude, attacktarget.dodge, attacktarget.dtype, masmod, id, attacktarget);
            scr_skills_modifydamage();
            
            if (skipper)
                tempdamage = scr_do_damage_skip();
            else
                tempdamage = scr_do_damage();
            
            comefromdouble = true;
            i = false;
            state = "ending attack";
            break;
        }
        else if (oppdoubleattackvar == true)
        {
            ds_list_clear(obj_game.combatskills);
            ds_list_clear(obj_game.combatskillscounter);
            
            if ((abs(abs(GridY - attacktarget.GridY) + abs(GridX - attacktarget.GridX)) == 1 && attacktarget.cancountermelee) || (abs(abs(GridY - attacktarget.GridY) + abs(GridX - attacktarget.GridX)) > 1 && attacktarget.cancounterranged))
            {
                with (attacktarget)
                {
                    status = scr_hit_calculation(accuracy, other.dodge, crit, id, other.id);
                    
                    if (ds_grid_value_exists(skillslots, 0, 0, 1, 10, "Quick Hands"))
                    {
                        if (status == "miss")
                            status = "hit";
                    }
                    
                    truedamage = scr_attack_damage(accuracy, damagetype, damagesubtype, pwr, other.constitution, other.fortitude, other.dodge, other.dtype, masmod, id, attacktarget);
                    scr_skills_modifydamage();
                    
                    if (other.skipper)
                        tempdamage = scr_do_counter_damage_skip();
                    else
                        tempdamage = scr_do_counter_damage();
                }
                
                comefromdouble = true;
                i = false;
                state = "ending attack";
                break;
            }
            else
            {
                i = false;
                alarm[10] = 20;
                state = "ending attack";
            }
        }
        else
        {
            state = "double buffer";
        }
        
        break;
    
    case "double buffer":
        state = "waiting for double";
        break;
    
    case "ending attack":
        if (i || skipper)
        {
            i = false;
            
            if (attacktarget.army == 30)
                state = "end attack";
            else
                state = "giving xp";
        }
        
        break;
    
    case "giving xp":
        scr_update_equipment_all();
        scr_skills_postcombat();
        
        with (attacktarget)
            scr_skills_postcombat();
        
        with (attacktarget)
            scr_update_equipment_all();
        
        attacktarget.needtolevel = false;
        
        if (attacktarget.tempHP > 0)
        {
            if (tempHP <= 0)
            {
                if (attacktarget.name == "Irving")
                {
                    with (obj_irving)
                    {
                        with (obj_actor)
                        {
                            if (army == 20)
                            {
                                if ((abs(GridX - other.GridX) + abs(GridY - other.GridY)) < 2)
                                    xp = min(xp + 5, 99);
                            }
                        }
                    }
                }
                
                if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, attacktarget.name) != -1)
                    ds_grid_set(obj_room_info.gamestats, 4, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, attacktarget.name), ds_grid_get(obj_room_info.gamestats, 4, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, attacktarget.name)) + 1);
                
                ds_grid_set(attacktarget.personalarray, 5, 0, ds_grid_get(attacktarget.personalarray, 5, 0) + 1);
                
                if (level > attacktarget.level)
                    attacktarget.xptogive = round(max(min(xpvalue * (1 + ((level - attacktarget.level) / 10)), 100), 1));
                else
                    attacktarget.xptogive = round(max(min(xpvalue * (1 + ((level - attacktarget.level) / 4)), 100), 1));
                
                with (attacktarget)
                    scr_skills_xp();
                
                if (attacktarget.xptogive > 100)
                    attacktarget.xptogive = 100;
                
                with (instance_create(0, 0, obj_animator_4))
                {
                    gettingxp = other.attacktarget.id;
                    startingxp = other.attacktarget.xp;
                    givenxp = other.attacktarget.xp;
                    xptogive = other.attacktarget.xptogive;
                    aigivingxp = other.id;
                }
            }
            else if (tempHP > 0)
            {
                if (level > attacktarget.level)
                    attacktarget.xptogive = round(max(min(xpvalue * 0.33, 100), 1));
                else
                    attacktarget.xptogive = round(max(min(xpvalue * (0.33 - ((level - attacktarget.level) / 20)), 100), 1));
                
                with (attacktarget)
                    scr_skills_xp();
                
                with (instance_create(0, 0, obj_animator_4))
                {
                    gettingxp = other.attacktarget.id;
                    startingxp = other.attacktarget.xp;
                    givenxp = other.attacktarget.xp;
                    xptogive = other.attacktarget.xptogive;
                    aigivingxp = other.id;
                }
            }
        }
        else
        {
            with (obj_animator)
                alarm[7] = 1;
            
            alarm[10] = 20;
        }
        
        i = false;
        state = "waiting to level";
        break;
    
    case "waiting to level":
        if (i && !instance_exists(obj_animator_4) && !instance_exists(obj_animator_levelupyee))
        {
            i = false;
            state = "leveling";
        }
        
        break;
    
    case "leveling":
        if (instance_exists(obj_animator_4))
        {
            with (obj_animator_4)
            {
                if ((startingxp + xptogive) > 99)
                    other.attacktarget.needtolevel = true;
            }
        }
        
        if (attacktarget.needtolevel)
        {
            instance_destroy(obj_animator);
            scr_level_up_1(attacktarget.personalarray, attacktarget.HPG, attacktarget.STRG, attacktarget.SPDG, attacktarget.CONG, attacktarget.DEXG, attacktarget.MAGG, attacktarget.FORG, attacktarget.id, attacktarget.MASG, attacktarget.LCKG);
            
            if (obj_game.enemyturnskip)
            {
                with (instance_create(0, 0, obj_animator_levelup))
                {
                    gettingxp = other.attacktarget.id;
                    aigivingxp = other.id;
                    skippy = true;
                }
                
                obj_game.enemyturnskip = false;
                i = false;
            }
            else
            {
                with (instance_create(0, 0, obj_animator_levelup))
                {
                    gettingxp = other.attacktarget.id;
                    aigivingxp = other.id;
                }
            }
            
            i = false;
            state = "waiting to end";
        }
        else
        {
            i = true;
            state = "waiting to end";
        }
        
        break;
    
    case "waiting to end":
        if (i && !instance_exists(obj_animator_levelup) && (!instance_exists(obj_animator_4) || obj_game.enemyturnskip))
            state = "end attack";
        
        break;
    
    case "end attack":
        scr_update_equipment_all();
        scr_skills_postcombat();
        
        with (attacktarget)
            scr_skills_postcombat();
        
        attacktarget.attacktarget = -4;
        
        if (instance_exists(obj_animator))
            instance_destroy(obj_animator);
        
        if (attacktarget.tempHP <= 0)
        {
            if (attacktarget.army == 10)
            {
                attackedHP2 = 0;
                attacktarget.alive = false;
                global.map[attacktarget.GridX][attacktarget.GridY].occupant = -4;
                instance_destroy(attacktarget);
            }
            else if (attacktarget.army == 20)
            {
                with (instance_create(0, 0, obj_characterkiller))
                    character = other.attacktarget;
                
                obj_cursor.selectedactor = -4;
                global.map[attacktarget.GridX][attacktarget.GridY].occupant = -4;
                comefromdouble = false;
            }
        }
        else
        {
            attackedHP2 = attacktarget.tempHP;
        }
        
        if (tempHP <= 0)
        {
            attackerHP2 = 0;
            alive = false;
            global.map[GridX][GridY].occupant = -4;
            instance_destroy(id);
        }
        
        attacktarget = -4;
        
        if (army == 20)
            obj_game.blueturnkeeper -= 1;
        
        if (army == 10)
            obj_game.redturnkeeper -= 1;
        
        actiontimer -= 1;
        
        if (actiontimer <= 0)
            obj_cursor.selectedactor = -4;
        
        comefromdouble = false;
        obj_game.alarm[1] = 5;
        attacktarget = -4;
        state = "idle";
        break;
    
    case "begin heal":
        global.readiedspell = "Heal";
        scr_spell_cast(healtarget, global.readiedspell);
        attackactions = 0;
        spelltarget = -4;
        global.readiedspell = -4;
        obj_game.alarm[1] = 5;
        state = "idle";
        break;
}
