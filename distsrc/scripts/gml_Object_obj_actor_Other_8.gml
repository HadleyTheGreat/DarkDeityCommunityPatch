if (instance_exists(obj_game))
{
    if (instance_exists(obj_range_toggle))
    {
        with (obj_range_toggle)
            scr_enemy_range();
    }
    
    if (GridX != floor(GridX))
        GridX = floor(GridX + 0.5);
    
    if (GridY != floor(GridY))
        GridY = floor(GridY + 0.5);
    
    speed = 0;
    hspeed = 0;
    vspeed = 0;
    x = GridX * 32;
    y = GridY * 32;
    
    with (obj_node)
    {
        if (occupant == other.id)
        {
            if (other.x != x || other.y != y)
                occupant = -4;
        }
        
        if (x == other.x && y == other.y)
            occupant = other;
    }
    
    trade_eligible = false;
    
    with (obj_actor)
    {
        if (distance_to_object(other) < 100)
            scr_update_equipment_all();
    }
    
    scr_update_equipment_all();
    path_clear_points(movementpath);
    
    if (state == "moving")
        state = "idle";
}
else if (instance_exists(obj_cutscene))
{
    with (obj_cutscene)
        JJ = true;
    
    state = "idle";
}
