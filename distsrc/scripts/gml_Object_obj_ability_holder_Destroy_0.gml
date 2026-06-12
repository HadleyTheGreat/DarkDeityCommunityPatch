if (ds_exists(skills, ds_type_grid))
    ds_grid_destroy(skills);

if (ds_exists(wounds, ds_type_grid))
    ds_grid_destroy(wounds);

if (ds_exists(skills_translations, ds_type_grid))
    ds_grid_destroy(skills_translations);
