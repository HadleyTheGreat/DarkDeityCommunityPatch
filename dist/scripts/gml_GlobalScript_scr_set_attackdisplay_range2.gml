function scr_set_attackdisplay_range2(arg0)
{
    if (!scr_debug_assert_instance_type(arg0, 170, "set_attackdisplay_range2:arg0"))
        exit;
    
    if (ds_exists(arg0.viewneighborsranged, ds_type_list))
    {
        for (var index = 0; index < ds_list_size(arg0.viewneighborsranged); index++)
        {
            var node = ds_list_find_value(arg0.viewneighborsranged, index);
            
            if (typeof(node) != "undefined" && instance_exists(node))
                node.attackdisplay = true;
        }
    }
}
