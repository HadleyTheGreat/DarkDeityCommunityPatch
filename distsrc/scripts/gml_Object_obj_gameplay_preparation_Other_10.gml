switch (selected)
{
    case 1:
        instance_create(0, 0, obj_prep_units);
        instance_destroy();
        break;
    
    case 2:
        instance_create(0, 0, obj_swapping_units);
        
        with (obj_cursor_preparing)
            swapactor = -4;
        
        instance_destroy();
        break;
    
    case 3:
        instance_create(0, 0, obj_base_invy);
        notreplacing = false;
        break;
    
    case 4:
        instance_create(0, 0, obj_base_save);
        instance_destroy();
        break;
    
    case 5:
        with (obj_marker_parent)
        {
            if (selected != true)
                instance_destroy();
        }
        
        with (obj_swapspot)
            instance_destroy();
        
        cavalrycheck = 0;
        aspectcheck = 0;
        totalcheck = 0;
        
        with (obj_marker_parent)
        {
            if (class == "Raider" || class == "Slayer" || class == "Witch Hunter" || class == "Green Knight" || class == "Dragoon" || class == "Dragon Knight" || class == "Guardian" || class == "Paladin" || class == "Illusionist" || class == "Thunderlord")
                other.cavalrycheck += 1;
            
            if (Itemycoord5 > 399)
                other.aspectcheck += 1;
            
            other.totalcheck += 1;
        }
        
        if (totalcheck == aspectcheck)
            steam_set_achievement("Achieve_9");
        
        if (cavalrycheck >= 6)
            steam_set_achievement("Achieve_27");
        
        obj_game.state = "player turn draw";
        instance_destroy();
        break;
}
