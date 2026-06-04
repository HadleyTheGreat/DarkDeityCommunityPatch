function scr_set_attackdisplay_range3(arg0)
{
    if (!scr_debug_assert_instance_type(arg0, 170, "set_attackdisplay_range3:arg0"))
        exit;
    
    if (ds_exists(arg0.viewneighborsmelee, ds_type_list))
    {
        for (var index = 0; index < ds_list_size(arg0.viewneighborsmelee); index++)
        {
            var node = ds_list_find_value(arg0.viewneighborsmelee, index);
            
            if (typeof(node) != "undefined" && instance_exists(node))
            {
                if (ds_exists(node.viewneighborsranged, ds_type_list))
                {
                    for (var innerindex = 0; innerindex < ds_list_size(node.viewneighborsranged); innerindex++)
                    {
                        var innernode = ds_list_find_value(node.viewneighborsranged, innerindex);
                        
                        if (typeof(innernode) != "undefined" && instance_exists(innernode))
                            innernode.attackdisplay = true;
                    }
                }
            }
        }
    }
}
