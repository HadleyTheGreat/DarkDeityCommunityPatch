characters = ds_priority_create();

for (ii = 0; ii <= 7; ii += 1)
{
    if (ii == 0)
    {
        xx = 96;
        yy = 448;
    }
    else if (ii == 1)
    {
        xx = 96;
        yy = 480;
    }
    else if (ii == 2)
    {
        xx = 608;
        yy = 96;
    }
    else if (ii == 3)
    {
        xx = 640;
        yy = 96;
    }
    else if (ii == 4)
    {
        xx = 1152;
        yy = 480;
    }
    else if (ii == 5)
    {
        xx = 1152;
        yy = 448;
    }
    else if (ii == 6)
    {
        xx = 608;
        yy = 832;
    }
    else if (ii == 7)
    {
        xx = 640;
        yy = 832;
    }
    
    if (global.map[xx / 32][yy / 32].occupant == -4)
    {
        with (instance_create(xx, yy, choose(obj_enemy_delian_conjurer, obj_enemy_delian_stalker, obj_enemy_delian_drifter)))
        {
            GridX = x / 32;
            GridY = y / 32;
            global.map[GridX][GridY].occupant = id;
            rusher = true;
            
            if (class == "Conjurer")
                equippedcoord = 202;
            
            if (class == "Stalker")
                equippedcoord = 154;
            
            if (class == "Drifter")
                equippedcoord = 42;
            
            ds_priority_add(other.characters, id, other.ii);
            name = "Undead";
            scr_undead();
            level = 18;
            scr_enemy_growth();
            scr_update_equipment_all();
        }
    }
}

if (turn == 1)
    alpha = 0.9;
else if (turn == 2)
    alpha = 0.8;
else if (turn == 3)
    alpha = 0.7;
else if (turn == 4)
    alpha = 0.6;
else if (turn == 5)
    alpha = 0.5;
else if (turn == 6)
    alpha = 0.4;
else if (turn == 7)
    alpha = 0.3;
else if (turn == 8)
    alpha = 0.2;
else if (turn == 9)
    alpha = 0.1;

if (turn == 9 && !instance_exists(obj_stat_view))
{
    obj_game.state = "idle";
    obj_cursor.cursor_active = false;
    instance_create(0, 0, obj_stat_view);
}
else
{
    alarm[1] = 20;
    P += 1;
}
