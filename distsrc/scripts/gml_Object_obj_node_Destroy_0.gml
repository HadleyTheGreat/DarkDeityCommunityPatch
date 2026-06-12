if (variable_instance_exists(id, "neighbors"))
{
    if (ds_exists(neighbors, ds_type_list))
        ds_list_destroy(neighbors);
}

if (variable_instance_exists(id, "viewneighborsmelee"))
{
    if (ds_exists(viewneighborsmelee, ds_type_list))
        ds_list_destroy(viewneighborsmelee);
}

if (variable_instance_exists(id, "viewneighborsranged"))
{
    if (ds_exists(viewneighborsranged, ds_type_list))
        ds_list_destroy(viewneighborsranged);
}
