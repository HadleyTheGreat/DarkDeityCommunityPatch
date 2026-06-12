if (ds_exists(item_translations, ds_type_grid))
    ds_grid_destroy(item_translations);

if (ds_exists(item_holder, ds_type_grid))
    ds_grid_destroy(item_holder);

if (ds_exists(usable_translations, ds_type_grid))
    ds_grid_destroy(usable_translations);
