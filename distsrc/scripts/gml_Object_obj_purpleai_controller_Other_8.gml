if (instance_exists(obj_game))
{
    speed = 0;
    hspeed = 0;
    vspeed = 0;
    
    if (x != floor(x))
        x = floor(x + 0.5);
    
    if (y != floor(y))
        y = floor(y + 0.5);
    
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
else
{
    event_inherited();
}
