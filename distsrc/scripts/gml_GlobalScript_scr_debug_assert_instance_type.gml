function scr_debug_assert_instance_type(arg0, arg1, arg2)
{
    var debug = false;
    
    if (!instance_exists(arg0))
    {
        if (debug)
            show_message(arg2 + ": instance did not exist");
        
        return false;
    }
    
    if (arg0.object_index != arg1)
    {
        if (debug)
            show_message(arg2 + ": type mismatch\nType expected: " + object_get_name(arg1) + ", Type received: " + object_get_name(arg0.object_index));
        
        return false;
    }
    
    return true;
}
