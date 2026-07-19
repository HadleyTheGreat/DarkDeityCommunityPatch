nodeimon = global.map[GridX][GridY];
if (state == "idle" && instance_exists(obj_game) && !instance_exists(obj_animator) && !instance_exists(obj_stat_view) && room != room_l16)
{
    if (obj_game.state == "player turn")
    {
        if (instance_exists(nodeimon))
        {
            if (nodeimon.occupant != id)
            {
                nodeimon.occupant = id;
                with (obj_node)
                {
                    if (occupant == other.id && other.nodeimon != id)
                    {
                        occupant = -4;
                    }
                }
            }
        }
    }
}
if (tempGridX != 0 && tempGridY != 0)
{
    if ((tempGridX - GridX) < 0)
    {
        directionfacing = -1;
        directionmod = 32;
    }
    else
    {
        directionfacing = 1;
        directionmod = 0;
    }
}
if (instance_exists(obj_animator))
{
    if (id == global.attacker || id == global.attacker.attacktarget)
    {
        if (frame < sprite_get_number(combsprite))
        {
            frame += 0.2;
        }
        else
        {
            frame = 0;
        }
    }
}
switch (state)
{
    case "begin path":
        path_start(movementpath, global.movespeed, path_action_stop, true);
        state = "moving";
        break;
    case "begin attack":
        global.attacker = id;
        attacktarget.attacktarget = id;
        state = "attacking";
        break;
    case "attack waiting one":
        if ((i || skipper) && !instance_exists(obj_text_holder))
        {
            state = "continue attacking";
        }
        break;
    case "healing":
        obj_cursor.cursor_active = false;
        skipper = false;
        global.attacker = id;
        with (instance_create(0, 0, obj_animator))
        {
            healing = true;
        }
        i = false;
        alarm[0] = 25;
        state = "healing 2";
        break;
    case "healing 2":
        if (i && !instance_exists(obj_text_scroll_midlevel))
        {
            scr_do_heal();
            i = false;
            alarm[0] = 60;
            scr_wipe_nodes();
            state = "ending attack";
        }
        break;
    case "attacking":
        obj_cursor.cursor_active = false;
        skipper = false;
        if (global.animations != true)
        {
            skipper = true;
        }
        global.attacker = id;
        scr_melee_attack();
        i = false;
        alarm[0] = 30;
        scr_wipe_nodes();
        state = "attack waiting one";
        break;
    case "continue attacking":
        scr_skills_precombat();
        status = scr_hit_calculation(accuracy, attacktarget.dodge, crit, id, attacktarget);
        truedamage = scr_attack_damage(accuracy, damagetype, damagesubtype, pwr, attacktarget.constitution, attacktarget.fortitude, attacktarget.dodge, attacktarget.dtype, masmod, id, attacktarget);
        tempdamage = 0;
        scr_skills_modifydamage();
        if (skipper)
        {
            tempdamage = scr_do_damage_skip();
        }
        else
        {
            tempdamage = scr_do_damage();
        }
        attackactions -= 1;
        scr_skills_midcombat();
        if ((attacktarget.tempHP - tempdamage) > 0 && tempHP > 0)
        {
            if ((abs(abs(GridY - attacktarget.GridY) + abs(attacktarget.GridX - GridX)) == 1 && attacktarget.cancountermelee) || (abs(abs(GridY - attacktarget.GridY) + abs(attacktarget.GridX - GridX)) == 2 && attacktarget.cancounterranged))
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
            i = false;
            state = "ending attack";
        }
        break;
    case "waiting for counter":
        if (i || skipper)
        {
            state = "countering";
        }
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
            {
                tempdamage = scr_do_counter_damage_skip();
            }
            else
            {
                tempdamage = scr_do_counter_damage();
            }
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
        {
            state = "check for double";
        }
        break;
    case "check for double":
        if (eff_spd > (attacktarget.eff_spd + 4) && class != "Champion" && (attacktarget.name != "Empyrean" || !instance_exists(obj_enemy_delian_magician)))
        {
            oppdoubleattackvar = false;
            doubleattackvar = true;
            state = "waiting for double";
        }
        else if (attacktarget.eff_spd > (eff_spd + 4) && attacktarget.class != "Champion")
        {
            doubleattackvar = false;
            oppdoubleattackvar = true;
            state = "waiting for double";
        }
        else
        {
            state = "ending attack";
        }
        break;
    case "waiting for double":
        scr_update_equipment_all();
        if (doubleattackvar == true)
        {
            ds_list_clear(obj_game.combatskills);
            ds_list_clear(obj_game.combatskillscounter);
            status = scr_hit_calculation(accuracy, attacktarget.dodge, crit, id, attacktarget);
            if (ds_grid_value_exists(skillslots, 0, 0, 1, 10, "Quick Hands"))
            {
                if (status == "miss")
                {
                    status = "hit";
                }
            }
            truedamage = scr_attack_damage(accuracy, damagetype, damagesubtype, pwr, attacktarget.constitution, attacktarget.fortitude, attacktarget.dodge, attacktarget.dtype, masmod, id, attacktarget);
            scr_skills_modifydamage();
            if (skipper)
            {
                scr_do_damage_skip();
            }
            else
            {
                scr_do_damage();
            }
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
                        {
                            status = "hit";
                        }
                    }
                    truedamage = scr_attack_damage(accuracy, damagetype, damagesubtype, pwr, other.constitution, other.fortitude, other.dodge, other.dtype, masmod, id, attacktarget);
                    scr_skills_modifydamage();
                    if (other.skipper)
                    {
                        scr_do_counter_damage_skip();
                    }
                    else
                    {
                        scr_do_counter_damage();
                    }
                }
                comefromdouble = true;
                i = false;
                state = "ending attack";
                break;
            }
            else
            {
                i = false;
                alarm[0] = 20;
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
            state = "giving xp";
        }
        break;
    case "giving xp":
        scr_update_equipment_all();
        scr_skills_postcombat();
        with (attacktarget)
        {
            scr_skills_postcombat();
        }
        if (attacktarget.army == 10)
        {
            needtolevel = false;
            if (tempHP > 0)
            {
                if (attacktarget.tempHP <= 0)
                {
                    if (!instance_exists(obj_money_display) && instance_exists(obj_room_info))
                    {
                        with (instance_create(0, 0, obj_money_display))
                        {
                            preamount = ds_grid_get(obj_game_data.data, 0, 1);
                            ds_grid_set(obj_game_data.data, 0, 1, ds_grid_get(obj_game_data.data, 0, 1) + round(obj_room_info.goldper * (global.randomgoldmodifier / 100)));
                            postamount = ds_grid_get(obj_game_data.data, 0, 1);
                            addition = obj_room_info.goldper;
                        }
                    }
                    if (name == "Irving")
                    {
                        with (obj_actor)
                        {
                            if (army == 20)
                            {
                                if ((abs(GridX - other.GridX) + abs(GridY - other.GridY)) < 3)
                                {
                                    xp = min(xp + 5, 99);
                                }
                            }
                        }
                    }
                    if (ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, name) != -1)
                    {
                        ds_grid_set(obj_room_info.gamestats, 4, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, name), ds_grid_get(obj_room_info.gamestats, 4, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, name)) + 1);
                        if (class == "Assassin")
                        {
                            if ((ds_grid_get(obj_room_info.gamestats, 4, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, name)) % 2) == 0)
                            {
                                with (instance_create(0, 0, obj_cruelefficiency))
                                {
                                    owner = other;
                                }
                            }
                        }
                        if (ds_grid_get(obj_room_info.gamestats, 4, ds_grid_value_y(obj_room_info.gamestats, 0, 0, 7, 29, name)) >= 15)
                        {
                            steam_set_achievement("Achieve_25");
                        }
                    }
                    if (attacktarget.level > level)
                    {
                        xptogive = round(max(min(attacktarget.xpvalue * (1 + ((attacktarget.level - level) / 10)), 100), 1));
                    }
                    else
                    {
                        xptogive = round(max(min(attacktarget.xpvalue * (1 + ((attacktarget.level - level) / 4)), 100), 1));
                    }
                    scr_skills_xp();
                    if (xptogive > 100)
                    {
                        xptogive = 100;
                    }
                    with (instance_create(0, 0, obj_animator_4))
                    {
                        gettingxp = other.id;
                        startingxp = other.xp;
                        givenxp = other.xp;
                        xptogive = min(round(other.xptogive * (global.randomXPmodifier / 100)), 100);
                        aigivingxp = -4;
                    }
                }
                else if (attacktarget.tempHP > 0)
                {
                    xptogive = round(max(min(attacktarget.xpvalue * (0.33 + ((attacktarget.level - level) / 15)), 100), 1));
                    scr_skills_xp();
                    if (xptogive > 100)
                    {
                        xptogive = 100;
                    }
                    with (instance_create(0, 0, obj_animator_4))
                    {
                        gettingxp = other.id;
                        startingxp = other.xp;
                        givenxp = other.xp;
                        xptogive = min(round(other.xptogive * (global.randomXPmodifier / 100)), 100);
                        aigivingxp = -4;
                    }
                }
            }
            else
            {
                alarm[0] = 20;
            }
            i = false;
            state = "waiting to level";
        }
        else
        {
            needtolevel = false;
            with (instance_create(0, 0, obj_animator_4))
            {
                gettingxp = other.id;
                startingxp = other.xp;
                givenxp = other.xp;
                healer = -0.3 * display_get_gui_height();
                if (other.level < obj_room_info.healparam)
                {
                    xptogive = 15;
                }
                else if (other.level == obj_room_info.healparam)
                {
                    xptogive = 10;
                }
                else if (other.level == (obj_room_info.healparam + 1))
                {
                    xptogive = 5;
                }
                else
                {
                    xptogive = 1;
                }
                xptogive = round(xptogive * (global.randomXPmodifier / 100));
                aigivingxp = -4;
            }
            i = false;
            state = "waiting to level";
        }
        break;
    case "waiting to level":
        if (!instance_exists(obj_animator_4) && !instance_exists(obj_animator_levelupyee))
        {
            i = false;
            state = "leveling";
        }
        break;
    case "leveling":
        ds_grid_set(personalarray, 2, 3, xp);
        if (needtolevel)
        {
            instance_destroy(obj_animator);
            scr_level_up_1(personalarray, HPG, STRG, SPDG, CONG, DEXG, MAGG, FORG, id, MASG, LCKG);
            with (instance_create(0, 0, obj_animator_levelup))
            {
                gettingxp = other.id;
                aigivingxp = -4;
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
        if (i)
        {
            state = "item drop";
        }
        break;
    case "item drop":
        if (attacktarget.tempHP <= 0)
        {
            obj_cursor.cursor_active = true;
            if (attacktarget.droppable || (ds_grid_value_exists(skillslots, 0, 0, 1, 10, "Pillage") && random_range(0, 100) < 4))
            {
                if (global.randomitems)
                {
                    attacktarget.droppable_item = random_range(0, 100);
                    if (attacktarget.droppable_item < 60)
                    {
                        attacktarget.droppable_item = choose(321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 340, 341, 342, 343, 495);
                    }
                    else if (attacktarget.droppable_item < 80)
                    {
                        attacktarget.droppable_item = choose(370, 371, 372, 373, 374, 375, 376, 377, 378, 496, 497);
                    }
                    else
                    {
                        attacktarget.droppable_item = choose(400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 498);
                    }
                }
                var droppingitem;
                if (attacktarget.droppable)
                {
                    droppingitem = attacktarget.droppable_item;
                }
                else
                {
                    droppingitem = choose(370, 371, 372, 373, 374, 375, 376, 377, 378);
                }
                if (droppingitem < 494)
                {
                    if (Itemycoord5 == 0)
                    {
                        ds_grid_set(personalarray, 3, 5, droppingitem);
                        with (instance_create(0, 0, obj_dropped_item))
                        {
                            droppeditem = droppingitem;
                        }
                    }
                    else if (Itemycoord6 == 0)
                    {
                        ds_grid_set(personalarray, 3, 6, droppingitem);
                        with (instance_create(0, 0, obj_dropped_item))
                        {
                            droppeditem = droppingitem;
                        }
                    }
                    else if (Itemycoord7 == 0)
                    {
                        ds_grid_set(personalarray, 3, 7, droppingitem);
                        with (instance_create(0, 0, obj_dropped_item))
                        {
                            droppeditem = droppingitem;
                        }
                    }
                    else if (Itemycoord8 == 0)
                    {
                        ds_grid_set(personalarray, 3, 8, droppingitem);
                        with (instance_create(0, 0, obj_dropped_item))
                        {
                            droppeditem = droppingitem;
                        }
                    }
                    else
                    {
                        for (ii = 0; ii <= 499; ii += 1)
                        {
                            if (ds_grid_get(obj_storage_holder.item_storage, 0, ii) == 0)
                            {
                                ds_grid_set(obj_storage_holder.item_storage, 0, ii, droppingitem);
                                break;
                            }
                        }
                        with (instance_create(0, 0, obj_dropped_item))
                        {
                            droppeditem = droppingitem;
                            pickuptype = "Storage Received ";
                        }
                    }
                    scr_update_equipment();
                    i = false;
                    alarm[0] = 90;
                    state = "waiting to end 2";
                }
                else
                {
                    if (droppingitem == 495)
                    {
                        ds_grid_set(obj_game_data.data, 0, 6, ds_grid_get(obj_game_data.data, 0, 6) + 1);
                        with (instance_create(0, 0, obj_dropped_item))
                        {
                            droppeditem = 495;
                            pickuptype = "Gained one ";
                        }
                    }
                    else if (droppingitem == 496)
                    {
                        ds_grid_set(obj_game_data.data, 0, 7, ds_grid_get(obj_game_data.data, 0, 7) + 1);
                        with (instance_create(0, 0, obj_dropped_item))
                        {
                            droppeditem = 496;
                            pickuptype = "Gained one ";
                        }
                    }
                    else if (droppingitem == 497)
                    {
                        ds_grid_set(obj_game_data.data, 0, 8, ds_grid_get(obj_game_data.data, 0, 8) + 1);
                        with (instance_create(0, 0, obj_dropped_item))
                        {
                            droppeditem = 497;
                            pickuptype = "Gained one ";
                        }
                    }
                    else if (droppingitem == 498)
                    {
                        ds_grid_set(obj_game_data.data, 0, 9, ds_grid_get(obj_game_data.data, 0, 9) + 1);
                        with (instance_create(0, 0, obj_dropped_item))
                        {
                            droppeditem = 498;
                            pickuptype = "Gained one ";
                        }
                    }
                    scr_update_equipment();
                    i = false;
                    alarm[0] = 90;
                    state = "waiting to end 2";
                }
            }
            else
            {
                state = "end attack";
            }
        }
        else
        {
            state = "end attack";
        }
        break;
    case "waiting to end 2":
        if (i && !instance_exists(obj_dropped_item))
        {
            state = "end attack";
        }
        break;
    case "end attack":
        ds_list_clear(obj_game.combatskills);
        if (tempHP <= 0)
        {
            if (instance_exists(obj_animator))
            {
                var anim = 210;
                if (anim.attackexplode || anim.defendexplode)
                {
                    anim.alarm[6] = 1;
                    anim.tempActor = id;
                    state = "idle";
                    break;
                }
            }
        }
        else if (instance_exists(obj_animator))
        {
            instance_destroy(obj_animator);
        }
        if (attacktarget != -4)
        {
            if (attacktarget.tempHP <= 0)
            {
                if (attacktarget.army == 10)
                {
                    attacktarget.alive = false;
                    global.map[attacktarget.GridX][attacktarget.GridY].occupant = -4;
                    global.map[attacktarget.GridX][attacktarget.GridY].movenode = true;
                    obj_game.enemiesonmap -= 1;
                    instance_destroy(attacktarget);
                }
            }
        }
        if (tempHP <= 0)
        {
            if (army == 20)
            {
                with (instance_create(0, 0, obj_characterkiller))
                {
                    character = other;
                    scr_grave_wound();
                }
                tempHP = 0;
                obj_cursor.selectedactor = -4;
                global.map[GridX][GridY].occupant = -4;
            }
            else if (army == 10)
            {
                alive = false;
                global.map[attacktarget.GridX][attacktarget.GridY].occupant = -4;
                instance_destroy(attacktarget);
            }
        }
        if (attacktarget != -4)
        {
            if (instance_exists(attacktarget))
            {
                attacktarget.attacktarget = -4;
            }
        }
        if (army == 20)
        {
            obj_game.blueturnkeeper -= 1;
        }
        if (army == 10)
        {
            obj_game.redturnkeeper -= 1;
        }
        actiontimer -= 1;
        if (actiontimer <= 0)
        {
            obj_cursor.selectedactor = -4;
        }
        comefromdouble = false;
        obj_cursor.cursor_active = true;
        state = "idle";
        break;
    case "begin action":
        break;
    case "begin spell":
        if (spelltarget == -4)
        {
            state = "idle";
        }
        else
        {
            if (global.readiedspell == "Trade")
            {
            }
            else
            {
                canAct = false;
                attackactions = 0;
            }
            scr_spell_cast(spelltarget, global.readiedspell);
            spelltarget = -4;
            global.readiedspell = -4;
        }
        break;
    case "end heal xp give":
        break;
    case "end action":
        actiontimer -= 1;
        if (actiontimer <= 0)
        {
            state = "idle";
        }
        else
        {
            state = "idle";
            obj_cursor.currentactor = -4;
        }
        break;
    case "end turn":
        break;
}
