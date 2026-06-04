alarm[6] = 10;
P += 1;

if ((turn % 2) == 0)
{
    if (global.map[49][14].occupant == -4)
    {
        with (instance_create(1568, 448, obj_enemy_delian_knight))
        {
            rusher = true;
            scr_enemy_growth();
            scr_update_equipment_all();
            xpvalue = 14;
            GridX = x / 32;
            GridY = y / 32;
            nodeimon = global.map[GridX][GridY];
            global.map[GridX][GridY].occupant = id;
        }
    }
    
    if (global.map[49][15].occupant == -4)
    {
        with (instance_create(1568, 480, obj_enemy_delian_knight))
        {
            rusher = true;
            scr_enemy_growth();
            scr_update_equipment_all();
            xpvalue = 14;
            GridX = x / 32;
            GridY = y / 32;
            nodeimon = global.map[GridX][GridY];
            global.map[GridX][GridY].occupant = id;
        }
    }
    
    if (global.map[49][5].occupant == -4)
    {
        with (instance_create(1568, 160, obj_enemy_delian_knight))
        {
            rusher = true;
            scr_enemy_growth();
            scr_update_equipment_all();
            xpvalue = 14;
            GridX = x / 32;
            GridY = y / 32;
            nodeimon = global.map[GridX][GridY];
            global.map[GridX][GridY].occupant = id;
        }
    }
    
    if (global.map[49][6].occupant == -4)
    {
        with (instance_create(1568, 192, obj_enemy_delian_knight))
        {
            rusher = true;
            scr_enemy_growth();
            scr_update_equipment_all();
            xpvalue = 14;
            GridX = x / 32;
            GridY = y / 32;
            nodeimon = global.map[GridX][GridY];
            global.map[GridX][GridY].occupant = id;
        }
    }
}
