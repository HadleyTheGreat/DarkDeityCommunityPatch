function scr_statadd()
{
    var statholder = 0;
    
    switch (ds_grid_get(obj_room_info.gamestats, 0, ii))
    {
        case "Irving":
            statholder = obj_stat_holder.irving_stats;
            break;
        
        case "Garrick":
            statholder = obj_stat_holder.garrick_stats;
            break;
        
        case "Maren":
            statholder = obj_stat_holder.maren_stats;
            break;
        
        case "Alden":
            statholder = obj_stat_holder.alden_stats;
            break;
        
        case "Cia":
            statholder = obj_stat_holder.cia_stats;
            break;
        
        case "Elias":
            statholder = obj_stat_holder.elias_stats;
            break;
        
        case "Lincoln":
            statholder = obj_stat_holder.lincoln_stats;
            break;
        
        case "Bianca":
            statholder = obj_stat_holder.bianca_stats;
            break;
        
        case "Sophia":
            statholder = obj_stat_holder.sophia_stats;
            break;
        
        case "Sloane":
            statholder = obj_stat_holder.sloane_stats;
            break;
        
        case "Brooke":
            statholder = obj_stat_holder.brooke_stats;
            break;
        
        case "Benji":
            statholder = obj_stat_holder.benji_stats;
            break;
        
        case "Caius":
            statholder = obj_stat_holder.caius_stats;
            break;
        
        case "Sara":
            statholder = obj_stat_holder.sara_stats;
            break;
        
        case "Samara":
            statholder = obj_stat_holder.samara_stats;
            break;
        
        case "Corvan":
            statholder = obj_stat_holder.corvan_stats;
            break;
        
        case "Aurima":
            statholder = obj_stat_holder.aurima_stats;
            break;
        
        case "Vesta":
            statholder = obj_stat_holder.vesta_stats;
            break;
        
        case "Iris":
            statholder = obj_stat_holder.iris_stats;
            break;
        
        case "Ford":
            statholder = obj_stat_holder.ford_stats;
            break;
        
        case "Monroe":
            statholder = obj_stat_holder.monroe_stats;
            break;
        
        case "Maeve":
            statholder = obj_stat_holder.kitara_stats;
            break;
        
        case "Thae'Lanel":
            statholder = obj_stat_holder.thaelanel_stats;
            break;
        
        case "Wren":
            statholder = obj_stat_holder.wren_stats;
            break;
        
        case "Faust":
            statholder = obj_stat_holder.faust_stats;
            break;
        
        case "Fenton":
            statholder = obj_stat_holder.fenton_stats;
            break;
        
        case "Alexa":
            statholder = obj_stat_holder.alexa_stats;
            break;
        
        case "Rose":
            statholder = obj_stat_holder.rose_stats;
            break;
        
        case "Liberty":
            statholder = obj_stat_holder.liberty_stats;
            break;
        
        case "Helena":
            statholder = obj_stat_holder.helena_stats;
            break;
    }
    
    if (statholder != 0)
    {
        if (is_string(ds_grid_get(statholder, 5, 0)))
            ds_grid_set(statholder, 5, 0, 0);
        
        ds_grid_set(statholder, 5, 0, ds_grid_get(statholder, 5, 0) + ds_grid_get(obj_room_info.gamestats, 1, ii));
        
        if (is_string(ds_grid_get(statholder, 5, 1)))
            ds_grid_set(statholder, 5, 1, 0);
        
        ds_grid_set(statholder, 5, 1, ds_grid_get(statholder, 5, 1) + ds_grid_get(obj_room_info.gamestats, 2, ii));
        
        if (is_string(ds_grid_get(statholder, 5, 2)))
            ds_grid_set(statholder, 5, 2, 0);
        
        ds_grid_set(statholder, 5, 2, ds_grid_get(statholder, 5, 2) + ds_grid_get(obj_room_info.gamestats, 3, ii));
        
        if (is_string(ds_grid_get(statholder, 5, 3)))
            ds_grid_set(statholder, 5, 3, 0);
        
        ds_grid_set(statholder, 5, 3, ds_grid_get(statholder, 5, 3) + ds_grid_get(obj_room_info.gamestats, 4, ii));
        
        if (is_string(ds_grid_get(statholder, 5, 4)))
            ds_grid_set(statholder, 5, 4, 0);
        
        ds_grid_set(statholder, 5, 4, ds_grid_get(statholder, 5, 4) + ds_grid_get(obj_room_info.gamestats, 5, ii));
        
        if (is_string(ds_grid_get(statholder, 5, 5)))
            ds_grid_set(statholder, 5, 5, 0);
        
        ds_grid_set(statholder, 5, 5, ds_grid_get(statholder, 5, 5) + ds_grid_get(obj_room_info.gamestats, 6, ii));
        
        if (is_string(ds_grid_get(statholder, 5, 6)))
            ds_grid_set(statholder, 5, 6, 0);
        
        ds_grid_set(statholder, 5, 6, ds_grid_get(statholder, 5, 6) + ds_grid_get(obj_room_info.gamestats, 7, ii));
        
        if (is_string(ds_grid_get(statholder, 5, 7)))
            ds_grid_set(statholder, 5, 7, 0);
        
        ds_grid_set(statholder, 5, 7, ds_grid_get(statholder, 5, 7) + ds_grid_get(obj_room_info.gamestats, 8, ii));
    }
}
