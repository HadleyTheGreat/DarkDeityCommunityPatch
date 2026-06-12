if (path_exists(movementpath))
    path_delete(movementpath);

with (obj_attack_display)
{
    if (owner == other.id)
        instance_destroy();
}

with (obj_chains)
{
    if (owner == other.id)
        instance_destroy();
}

with (obj_boon)
{
    if (owner == other.id)
        instance_destroy();
}

with (obj_disarm)
{
    if (owner == other.id)
        instance_destroy();
}

if (ds_exists(strikes, ds_type_list))
    ds_list_destroy(strikes);

if (ds_exists(critstrikes, ds_type_list))
    ds_list_destroy(critstrikes);

if (ds_exists(skillslots, ds_type_grid))
    ds_grid_destroy(skillslots);

if (ds_exists(footsteps, ds_type_list))
    ds_list_destroy(footsteps);

if (ds_exists(footstepscrit, ds_type_list))
    ds_list_destroy(footstepscrit);

if (ds_exists(footsteps2, ds_type_list))
    ds_list_destroy(footsteps2);

if (ds_exists(footstepscrit2, ds_type_list))
    ds_list_destroy(footstepscrit2);

if (ds_exists(footsteps3, ds_type_list))
    ds_list_destroy(footsteps3);

if (ds_exists(footstepscrit3, ds_type_list))
    ds_list_destroy(footstepscrit3);

if (ds_exists(footsteps4, ds_type_list))
    ds_list_destroy(footsteps4);

if (ds_exists(footstepscrit4, ds_type_list))
    ds_list_destroy(footstepscrit4);

if (ds_exists(footsteps5, ds_type_list))
    ds_list_destroy(footsteps5);

if (ds_exists(footstepscrit5, ds_type_list))
    ds_list_destroy(footstepscrit5);

if (ds_exists(footsteps6, ds_type_list))
    ds_list_destroy(footsteps6);

if (ds_exists(footstepscrit6, ds_type_list))
    ds_list_destroy(footstepscrit6);

if (ds_exists(effects, ds_type_grid))
    ds_grid_destroy(effects);
