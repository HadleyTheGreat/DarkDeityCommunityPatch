function scr_movement_range_zone(arg0, arg1, arg2, arg3)
{
    scr_wipe_nodes();
    var start = arg0;
    var range = arg1;
    actions = arg2;
    actor1 = arg3;
    var open = ds_priority_create();
    var closed = ds_list_create();
    ds_priority_add(open, start, start.G);
    
    while (ds_priority_size(open) > 0)
    {
        var current = ds_priority_delete_min(open);
        ds_list_add(closed, current);
        
        if (current != -4 && current != 0)
        {
            if (instance_exists(current) && scr_debug_assert_instance_type(current, 170, "scr_movement_range_zone:current"))
            {
                if (ds_exists(current.neighbors, ds_type_list))
                {
                    for (ii = 0; ii < ds_list_size(current.neighbors); ii += 1)
                    {
                        var neighbor = ds_list_find_value(current.neighbors, ii);
                        
                        if (neighbor != -4 && neighbor != 0)
                        {
                            if (instance_exists(neighbor) && scr_debug_assert_instance_type(neighbor, 170, "scr_movement_range_zone:neighbor"))
                            {
                                if (ds_list_find_index(closed, neighbor) < 0 && neighbor.passable && (neighbor.occupant == -4 || !instance_exists(neighbor.occupant) || neighbor.occupant.army == actor1.army) && (neighbor.cost + current.G) <= range)
                                {
                                    if (ds_priority_find_priority(open, neighbor) == 0 || ds_priority_find_priority(open, neighbor) == undefined)
                                    {
                                        var costmod = 1;
                                        neighbor.parent = current;
                                        
                                        if (neighbor.GridX != current.GridX && neighbor.GridY != current.GridY)
                                            costmod = 1.5;
                                        
                                        neighbor.G = current.G + (neighbor.cost * costmod);
                                        ds_priority_add(open, neighbor, neighbor.G);
                                    }
                                    else
                                    {
                                        var costmod = 1;
                                        
                                        if (neighbor.GridX != current.GridX && neighbor.GridY != current.GridY)
                                            costmod = 1.5;
                                        
                                        var tempG = current.G + (neighbor.cost * costmod);
                                        
                                        if (tempG < neighbor.G)
                                        {
                                            neighbor.parent = current;
                                            neighbor.G = tempG;
                                            ds_priority_change_priority(open, neighbor, neighbor.G);
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            break;
                        }
                    }
                }
            }
        }
        else
        {
            break;
        }
    }
    
    with (obj_node)
        G = floor(G);
    
    ds_priority_destroy(open);
    
    for (ii = 0; ii < ds_list_size(closed); ii += 1)
    {
        var current = ds_list_find_value(closed, ii);
        
        if (current.occupant == -4 && current.G <= range)
            current.zonedisplay = true;
        
        if (current.occupant != -4 && current.G <= range)
        {
            if (current.occupant.army == army)
                current.zonedisplay = true;
        }
        
        if (current.G > range)
            current.zonedisplay = true;
        
        if (actor1.onlyranged != true)
            scr_set_attackdisplay_range1(current);
        
        if (actor1.attacktype == "ranged")
            scr_set_attackdisplay_range2(current);
    }
    
    start.movenode = false;
    ds_list_destroy(closed);
}
