switch (selected)
{
    case 0:
        if (obj_cursor.selectedactor != -4)
        {
            var chestemp = collision_point(obj_cursor.selectedactor.GridX * 32, obj_cursor.selectedactor.GridY * 32, obj_objective_openchest, false, true);
            var chestitem = chestemp.item;
            if (global.randomitems)
            {
                chestitem = random_range(0, 100);
                if (chestitem < 60)
                {
                    chestitem = choose(321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 340, 341, 342, 343, 495);
                }
                else if (chestitem < 80)
                {
                    chestitem = choose(370, 371, 372, 373, 374, 375, 376, 377, 378, 496, 497);
                }
                else
                {
                    chestitem = choose(400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 498);
                }
            }
            if (chestitem < 494)
            {
                if (obj_cursor.selectedactor.Itemycoord5 == 0)
                {
                    ds_grid_set(obj_cursor.selectedactor.personalarray, 3, 5, chestitem);
                    with (obj_cursor.selectedactor)
                    {
                        scr_update_equipment_all();
                    }
                    with (instance_create(0, 0, obj_dropped_item))
                    {
                        droppeditem = chestitem;
                    }
                }
                else if (obj_cursor.selectedactor.Itemycoord6 == 0)
                {
                    ds_grid_set(obj_cursor.selectedactor.personalarray, 3, 6, chestitem);
                    with (obj_cursor.selectedactor)
                    {
                        scr_update_equipment_all();
                    }
                    with (instance_create(0, 0, obj_dropped_item))
                    {
                        droppeditem = chestitem;
                    }
                }
                else if (obj_cursor.selectedactor.Itemycoord7 == 0)
                {
                    ds_grid_set(obj_cursor.selectedactor.personalarray, 3, 7, chestitem);
                    with (obj_cursor.selectedactor)
                    {
                        scr_update_equipment_all();
                    }
                    with (instance_create(0, 0, obj_dropped_item))
                    {
                        droppeditem = chestitem;
                    }
                }
                else if (obj_cursor.selectedactor.Itemycoord8 == 0)
                {
                    ds_grid_set(obj_cursor.selectedactor.personalarray, 3, 8, chestitem);
                    with (obj_cursor.selectedactor)
                    {
                        scr_update_equipment_all();
                    }
                    with (instance_create(0, 0, obj_dropped_item))
                    {
                        droppeditem = chestitem;
                    }
                }
                else
                {
                    for (ii = 0; ii <= 100; ii += 1)
                    {
                        if (ds_grid_get(obj_storage_holder.item_storage, ii, 0) == 0)
                        {
                            ds_grid_set(obj_storage_holder.item_storage, ii, 0, chestitem);
                        }
                    }
                    with (instance_create(0, 0, obj_dropped_item))
                    {
                        droppeditem = chestitem;
                        pickuptype = "Storage Received ";
                    }
                }
            }
            else if (chestitem == 495)
            {
                ds_grid_set(obj_game_data.data, 0, 6, ds_grid_get(obj_game_data.data, 0, 6) + 1);
                with (instance_create(0, 0, obj_dropped_item))
                {
                    droppeditem = 495;
                    pickuptype = "Gained one ";
                }
            }
            else if (chestitem == 496)
            {
                ds_grid_set(obj_game_data.data, 0, 7, ds_grid_get(obj_game_data.data, 0, 7) + 1);
                with (instance_create(0, 0, obj_dropped_item))
                {
                    droppeditem = 496;
                    pickuptype = "Gained one ";
                }
            }
            else if (chestitem == 497)
            {
                ds_grid_set(obj_game_data.data, 0, 8, ds_grid_get(obj_game_data.data, 0, 8) + 1);
                with (instance_create(0, 0, obj_dropped_item))
                {
                    droppeditem = 497;
                    pickuptype = "Gained one ";
                }
            }
            else if (chestitem == 498)
            {
                ds_grid_set(obj_game_data.data, 0, 9, ds_grid_get(obj_game_data.data, 0, 9) + 1);
                with (instance_create(0, 0, obj_dropped_item))
                {
                    droppeditem = 498;
                    pickuptype = "Gained one ";
                }
            }
            with (collision_point(obj_cursor.selectedactor.x, obj_cursor.selectedactor.y, obj_objective_openchest, false, true))
            {
                if (partner1 != -4)
                {
                    instance_destroy(partner1);
                }
                if (partner2 != -4)
                {
                    instance_destroy(partner2);
                }
                instance_destroy();
            }
            obj_cursor.selectedactor.actions = 0;
            obj_cursor.selectedactor.attackactions = 0;
        }
        with (obj_droppers_parent)
        {
            instance_destroy();
        }
        obj_cursor.selectedactor = -4;
        obj_cursor.cursor_active = true;
        obj_cursor.buttoncollision = false;
        break;
}
instance_destroy();
