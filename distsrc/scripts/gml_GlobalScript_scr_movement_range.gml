function scr_movement_range(arg0, arg1, arg2)
{
    scr_wipe_nodes();
    var start = arg0;
    var range = arg1;
    actions = arg2;
    var open = ds_priority_create();
    var closed = ds_list_create();
    ds_priority_add(open, start, start.G);
    var current;
    
    while (ds_priority_size(open) > 0)
    {
        current = ds_priority_delete_min(open);
        ds_list_add(closed, current);
        
        if (current != -4 && current != 0)
        {
            if (instance_exists(current) && scr_debug_assert_instance_type(current, 170, "movement_range:current"))
            {
                if (ds_exists(current.neighbors, ds_type_list))
                {
                    for (ii = 0; ii < ds_list_size(current.neighbors); ii += 1)
                    {
                        var neighbor = ds_list_find_value(current.neighbors, ii);
                        
                        if (neighbor != -4 && neighbor != 0)
                        {
                            if (instance_exists(neighbor) && scr_debug_assert_instance_type(neighbor, 170, "movement_range:neighbor"))
                            {
                                if (ds_list_find_index(closed, neighbor) < 0 && neighbor.passable && (neighbor.occupant == -4 || !instance_exists(neighbor.occupant) || neighbor.occupant.army == selectedactor.army) && (neighbor.cost + current.G) <= range)
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
        current = ds_list_find_value(closed, ii);
        
        if (current.occupant == -4 && current.G <= range)
        {
            current.movenode = true;
            current.attackdisplay = false;
        }
        
        if (current.occupant != -4 && current.G <= range)
        {
            if (instance_exists(current.occupant) && obj_cursor.selectedactor != -4 && instance_exists(obj_cursor.selectedactor))
            {
                if (current.occupant.army == obj_cursor.selectedactor.army)
                {
                    current.movenode = true;
                    current.attackdisplay = false;
                }
            }
        }
        
        if (current.G > range)
            current.attackdisplay = true;
        
        if (obj_cursor.selectedactor.onlyranged == false)
            scr_set_attackdisplay_range1(current);
        
        if (obj_cursor.selectedactor.attacktype == "ranged")
            scr_set_attackdisplay_range2(current);
        
        if (obj_cursor.selectedactor.class == "Sniper" && obj_cursor.selectedactor.army == 20)
            scr_set_attackdisplay_range3(current);
    }
    
    if (obj_cursor.selectedactor.army == 20)
        scr_color_move_node(current, arg1, arg2, 20);
    else
        scr_color_move_node(current, arg1, arg2, 10);
    
    with (obj_node)
        scr_color_move_node(self, arg1, arg2, obj_cursor.selectedactor.army);
    
    start.movenode = false;
    ds_list_destroy(closed);
    start.movenode = false;
}
