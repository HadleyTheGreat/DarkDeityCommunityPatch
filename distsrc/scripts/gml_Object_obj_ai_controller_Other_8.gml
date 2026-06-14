if (instance_exists(obj_game))
{
    speed = 0;
    hspeed = 0;
    vspeed = 0;
    
    if (GridX != floor(GridX))
        GridX = floor(GridX + 0.5);
    
    if (GridY != floor(GridY))
        GridY = floor(GridY + 0.5);
    
    x = GridX * 32;
    y = GridY * 32;
}

with (obj_node)
{
    if (occupant == other.id)
    {
        if (x != other.x || y != other.y)
            occupant = -4;
    }
    
    if (x == other.x && y == other.y)
        occupant = other;
}

if (instance_exists(obj_game))
{
    if (instance_exists(obj_range_toggle))
    {
        with (obj_range_toggle)
        {
            if (owner == other.id)
                scr_enemy_range();
        }
    }
}

if (instance_exists(obj_game))
{
    if (obj_game.state != "player turn")
    {
        path_clear_points(movementpath);
        state = "find target";
        
        if (attackactions > 0)
        {
            switch (attacktype)
            {
                case "ranged":
                    scr_attack_range(id);
                    break;
                
                case "melee":
                    scr_attack_range(id);
                    break;
            }
        }
    }
}
else
{
    event_inherited();
}
