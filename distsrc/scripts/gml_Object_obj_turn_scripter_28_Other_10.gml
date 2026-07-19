if (instance_exists(obj_empyrean))
{
    with (obj_hazard_firestorm)
    {
        if (global.map[x / 32][y / 32].occupant != -4)
        {
            var modi = abs((x / 32) - (obj_empyrean.x / 32)) + abs((y / 32) - (obj_empyrean.y / 32));
            var damage = 30;
            damage -= (modi * 6);
            global.map[x / 32][y / 32].occupant.tempHP = max(global.map[x / 32][y / 32].occupant.tempHP - damage, 1);
        }
        instance_destroy();
    }
    with (obj_hazard_manastorm)
    {
        if (global.map[x / 32][y / 32].occupant != -4)
        {
            var damage = 50;
            global.map[x / 32][y / 32].occupant.tempHP = min(global.map[x / 32][y / 32].occupant.tempHP, max((global.map[x / 32][y / 32].occupant.tempHP - damage) + global.map[x / 32][y / 32].occupant.fortitude, 1));
        }
        instance_destroy();
    }
    with (obj_hazard_lightningstorm)
    {
        if (global.map[x / 32][y / 32].occupant != -4)
        {
            var damage = 40;
            global.map[x / 32][y / 32].occupant.tempHP = min(global.map[x / 32][y / 32].occupant.tempHP, max((global.map[x / 32][y / 32].occupant.tempHP - damage) + global.map[x / 32][y / 32].occupant.constitution, 1));
        }
        instance_destroy();
    }
    counter = 0;
    if (instance_exists(obj_enemy_delian_wizard))
    {
        with (obj_actor)
        {
            if (army == 20)
            {
                if (random_range(0, 10) < 3.3)
                {
                    instance_create(x, y, obj_hazard_lightningstorm);
                    other.counter += 1;
                }
            }
        }
    }
    var empyrean = 163;
    if (instance_exists(obj_enemy_delian_conjurer))
    {
        empyrean.tempHP = min(empyrean.HP, empyrean.tempHP + round(empyrean.HP / 10));
    }
    if (instance_exists(obj_enemy_delian_arcanist))
    {
        if ((empyrean.x + 32) < room_width)
            instance_create(empyrean.x + 32, empyrean.y, obj_hazard_manastorm);
        if ((empyrean.x - 32) >= 0)
            instance_create(empyrean.x - 32, empyrean.y, obj_hazard_manastorm);
        if ((empyrean.x + 32) < room_width && (empyrean.y + 32) < room_height)
            instance_create(empyrean.x + 32, empyrean.y + 32, obj_hazard_manastorm);
        if ((empyrean.x - 32) >= 0 && (empyrean.y - 32) >= 0)
            instance_create(empyrean.x - 32, empyrean.y - 32, obj_hazard_manastorm);
        if ((empyrean.y + 32) < room_height)
            instance_create(empyrean.x, empyrean.y + 32, obj_hazard_manastorm);
        if ((empyrean.y - 32) >= 0)
            instance_create(empyrean.x, empyrean.y - 32, obj_hazard_manastorm);
        if ((empyrean.x - 32) >= 0 && (empyrean.y + 32) < room_height)
            instance_create(empyrean.x - 32, empyrean.y + 32, obj_hazard_manastorm);
        if ((empyrean.x + 32) < room_width && (empyrean.y - 32) >= 0)
            instance_create(empyrean.x + 32, empyrean.y - 32, obj_hazard_manastorm);
    }
    if (instance_exists(obj_enemy_delian_pyromancer))
    {
        if ((empyrean.x + 64) < room_width)
            instance_create(empyrean.x + 64, empyrean.y, obj_hazard_firestorm);
        if ((empyrean.x + 96) < room_width)
            instance_create(empyrean.x + 96, empyrean.y, obj_hazard_firestorm);
        if ((empyrean.x + 128) < room_width)
            instance_create(empyrean.x + 128, empyrean.y, obj_hazard_firestorm);
        if ((empyrean.x + 169) < room_width)
            instance_create(empyrean.x + 160, empyrean.y, obj_hazard_firestorm);
        if ((empyrean.x - 64) >= 0)
            instance_create(empyrean.x - 64, empyrean.y, obj_hazard_firestorm);
        if ((empyrean.x - 96) >= 0)
            instance_create(empyrean.x - 96, empyrean.y, obj_hazard_firestorm);
        if ((empyrean.x - 128) >= 0)
            instance_create(empyrean.x - 128, empyrean.y, obj_hazard_firestorm);
        if ((empyrean.x - 160) >= 0)
            instance_create(empyrean.x - 160, empyrean.y, obj_hazard_firestorm);
        if ((empyrean.y - 64) >= 0)
            instance_create(empyrean.x, empyrean.y - 64, obj_hazard_firestorm);
        if ((empyrean.y - 96) >= 0)
            instance_create(empyrean.x, empyrean.y - 96, obj_hazard_firestorm);
        if ((empyrean.y - 128) >= 0)
            instance_create(empyrean.x, empyrean.y - 128, obj_hazard_firestorm);
        if ((empyrean.y - 160) >= 0)
            instance_create(empyrean.x, empyrean.y - 160, obj_hazard_firestorm);
        if ((empyrean.y + 64) < room_height)
            instance_create(empyrean.x, empyrean.y + 64, obj_hazard_firestorm);
        if ((empyrean.y + 96) < room_height)
            instance_create(empyrean.x, empyrean.y + 96, obj_hazard_firestorm);
        if ((empyrean.y + 128) < room_height)
            instance_create(empyrean.x, empyrean.y + 128, obj_hazard_firestorm);
        if ((empyrean.y + 160) < room_height)
            instance_create(empyrean.x, empyrean.y + 160, obj_hazard_firestorm);
    }
}
alarm[6] = 10;
P += 1;
