var bonding = 340;
var name1 = bonding.selected.name;
var name2 = bonding.selected2.name;
var level = ds_grid_get(bonding.selected.personalarray, 6, ds_grid_value_y(bonding.selected.personalarray, 7, 0, 7, 9, name2));
filebranch = "Bonds_English";
switch (global.language)
{
    case "French":
        filebranch = "Bonds_French//";
        break;
    case "German":
        filebranch = "Bonds_German//";
        break;
    case "Italian":
        filebranch = "Bonds_Italian//";
        break;
    case "Spanish":
        filebranch = "Bonds_Spanish//";
        break;
    case "Japanese":
        filebranch = "Bonds_Japanese//";
        break;
    case "Korean":
        filebranch = "Bonds_Korean//";
        break;
    case "Chinese":
        filebranch = "Bonds_Chinese//";
        break;
}
if (name1 == "Garrick" || name2 == "Garrick")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 27; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 1)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 1)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Garrick";
            speakerhighlighted = 1;
            expression1 = 2;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 2, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, 769, 3);
            ds_priority_add(expressionpool1, 2, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, 155, 4);
            ds_priority_add(expressionpool1, 2, 4);
            ds_priority_add(expressionpool2, 3, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 766, 7);
            ds_priority_add(expressionpool1, 2, 7);
            ds_priority_add(expressionpool2, 2, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 2, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, 156, 9);
            ds_priority_add(expressionpool1, 2, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, 764, 10);
            ds_priority_add(expressionpool1, 6, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 6, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 2, 13);
            ds_priority_add(soundpool, 150, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 3, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 2, 15);
            ds_priority_add(expressionpool2, 3, 15);
            ds_priority_add(soundpool, 149, 16);
            ds_priority_add(expressionpool1, 2, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, 770, 17);
            ds_priority_add(expressionpool1, 2, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 2, 18);
            ds_priority_add(expressionpool2, 2, 18);
            ds_priority_add(soundpool, -4, 19);
            ds_priority_add(expressionpool1, 0, 19);
            ds_priority_add(expressionpool2, 0, 19);
            ds_priority_add(soundpool, 152, 20);
            ds_priority_add(expressionpool1, 0, 20);
            ds_priority_add(expressionpool2, 2, 20);
            ds_priority_add(soundpool, 761, 21);
            ds_priority_add(expressionpool1, 0, 21);
            ds_priority_add(expressionpool2, 2, 21);
            ds_priority_add(soundpool, -4, 22);
            ds_priority_add(expressionpool1, 0, 22);
            ds_priority_add(expressionpool2, 0, 22);
            ds_priority_add(soundpool, -4, 23);
            ds_priority_add(expressionpool1, 2, 23);
            ds_priority_add(expressionpool2, 0, 23);
            ds_priority_add(soundpool, -4, 24);
            ds_priority_add(expressionpool1, 2, 24);
            ds_priority_add(expressionpool2, 0, 24);
            ds_priority_add(soundpool, 766, 25);
            ds_priority_add(expressionpool1, 2, 25);
            ds_priority_add(expressionpool2, 0, 25);
            ds_priority_add(soundpool, -4, 26);
            ds_priority_add(expressionpool1, 2, 26);
            ds_priority_add(expressionpool2, 2, 26);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1084;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 49; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 29)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 29)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Garrick";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 3, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, 776, 4);
            ds_priority_add(expressionpool1, 3, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, 150, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, 766, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, 771, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 3, 12);
            ds_priority_add(soundpool, 152, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, 776, 14);
            ds_priority_add(expressionpool1, 3, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 3, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, 773, 16);
            ds_priority_add(expressionpool1, 3, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 3, 17);
            ds_priority_add(expressionpool2, 2, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, 158, 19);
            ds_priority_add(expressionpool1, 0, 19);
            ds_priority_add(expressionpool2, 2, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 3, 20);
            ds_priority_add(expressionpool2, 2, 20);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1084;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 92; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 51)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 51)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Garrick";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, 155, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 3, 2);
            ds_priority_add(soundpool, 776, 3);
            ds_priority_add(expressionpool1, 3, 3);
            ds_priority_add(expressionpool2, 3, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 3, 4);
            ds_priority_add(expressionpool2, 3, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 4, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 3, 6);
            ds_priority_add(expressionpool2, 3, 6);
            ds_priority_add(soundpool, 778, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 3, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 3, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 3, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, 771, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 3, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, 764, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, 152, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, 770, 17);
            ds_priority_add(expressionpool1, 2, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, 156, 18);
            ds_priority_add(expressionpool1, 2, 18);
            ds_priority_add(expressionpool2, 3, 18);
            ds_priority_add(soundpool, -4, 19);
            ds_priority_add(expressionpool1, 6, 19);
            ds_priority_add(expressionpool2, 3, 19);
            ds_priority_add(soundpool, 150, 20);
            ds_priority_add(expressionpool1, 6, 20);
            ds_priority_add(expressionpool2, 0, 20);
            ds_priority_add(soundpool, 774, 21);
            ds_priority_add(expressionpool1, 0, 21);
            ds_priority_add(expressionpool2, 0, 21);
            ds_priority_add(soundpool, 145, 22);
            ds_priority_add(expressionpool1, 0, 22);
            ds_priority_add(expressionpool2, 1, 22);
            ds_priority_add(soundpool, -4, 23);
            ds_priority_add(expressionpool1, 0, 23);
            ds_priority_add(expressionpool2, 3, 23);
            ds_priority_add(soundpool, 147, 24);
            ds_priority_add(expressionpool1, 0, 24);
            ds_priority_add(expressionpool2, 0, 24);
            ds_priority_add(soundpool, -4, 25);
            ds_priority_add(expressionpool1, 2, 25);
            ds_priority_add(expressionpool2, 0, 25);
            ds_priority_add(soundpool, -4, 26);
            ds_priority_add(expressionpool1, 2, 26);
            ds_priority_add(expressionpool2, 2, 26);
            ds_priority_add(soundpool, 773, 27);
            ds_priority_add(expressionpool1, 2, 27);
            ds_priority_add(expressionpool2, 2, 27);
            ds_priority_add(soundpool, -4, 28);
            ds_priority_add(expressionpool1, 2, 28);
            ds_priority_add(expressionpool2, 0, 28);
            ds_priority_add(soundpool, -4, 29);
            ds_priority_add(expressionpool1, 0, 29);
            ds_priority_add(expressionpool2, 0, 29);
            ds_priority_add(soundpool, 152, 30);
            ds_priority_add(expressionpool1, 0, 30);
            ds_priority_add(expressionpool2, 2, 30);
            ds_priority_add(soundpool, -4, 31);
            ds_priority_add(expressionpool1, 0, 31);
            ds_priority_add(expressionpool2, 0, 31);
            ds_priority_add(soundpool, 763, 32);
            ds_priority_add(expressionpool1, 6, 32);
            ds_priority_add(expressionpool2, 0, 32);
            ds_priority_add(soundpool, 153, 33);
            ds_priority_add(expressionpool1, 6, 33);
            ds_priority_add(expressionpool2, 2, 33);
            ds_priority_add(soundpool, -4, 34);
            ds_priority_add(expressionpool1, 2, 34);
            ds_priority_add(expressionpool2, 0, 34);
            ds_priority_add(soundpool, -4, 35);
            ds_priority_add(expressionpool1, 2, 35);
            ds_priority_add(expressionpool2, 0, 35);
            ds_priority_add(soundpool, -4, 36);
            ds_priority_add(expressionpool1, 0, 36);
            ds_priority_add(expressionpool2, 0, 36);
            ds_priority_add(soundpool, 154, 37);
            ds_priority_add(expressionpool1, 0, 37);
            ds_priority_add(expressionpool2, 0, 37);
            ds_priority_add(soundpool, -4, 38);
            ds_priority_add(expressionpool1, 0, 38);
            ds_priority_add(expressionpool2, 0, 38);
            ds_priority_add(soundpool, 147, 39);
            ds_priority_add(expressionpool1, 0, 39);
            ds_priority_add(expressionpool2, 0, 39);
            ds_priority_add(soundpool, -4, 40);
            ds_priority_add(expressionpool1, 0, 40);
            ds_priority_add(expressionpool2, 0, 40);
            ds_priority_add(soundpool, -4, 41);
            ds_priority_add(expressionpool1, 0, 41);
            ds_priority_add(expressionpool2, 0, 41);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1084;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
if (name1 == "Maren" || name2 == "Maren")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 113; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 94)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 94)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Maren";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, 764, 2);
            ds_priority_add(expressionpool1, 6, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, 467, 3);
            ds_priority_add(expressionpool1, 6, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 466, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, 772, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, 463, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, 474, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 3, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 3, 16);
            ds_priority_add(soundpool, 473, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 3, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 2, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, -4, 19);
            ds_priority_add(expressionpool1, 2, 19);
            ds_priority_add(expressionpool2, 2, 19);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1088;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 137; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 115)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 115)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Maren";
            speakerhighlighted = 2;
            expression1 = 3;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 3, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 3, 3);
            ds_priority_add(expressionpool2, 3, 3);
            ds_priority_add(soundpool, 764, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 3, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, 761, 6);
            ds_priority_add(expressionpool1, 3, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 474, 7);
            ds_priority_add(expressionpool1, 3, 7);
            ds_priority_add(expressionpool2, 3, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, 776, 11);
            ds_priority_add(expressionpool1, 3, 11);
            ds_priority_add(expressionpool2, 3, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 3, 12);
            ds_priority_add(expressionpool2, 3, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 4, 13);
            ds_priority_add(expressionpool2, 3, 13);
            ds_priority_add(soundpool, 475, 14);
            ds_priority_add(expressionpool1, 4, 14);
            ds_priority_add(expressionpool2, 4, 14);
            ds_priority_add(soundpool, 777, 15);
            ds_priority_add(expressionpool1, 3, 15);
            ds_priority_add(expressionpool2, 3, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 3, 16);
            ds_priority_add(expressionpool2, 3, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 3, 17);
            ds_priority_add(expressionpool2, 3, 17);
            ds_priority_add(soundpool, 474, 18);
            ds_priority_add(expressionpool1, 3, 18);
            ds_priority_add(expressionpool2, 3, 18);
            ds_priority_add(soundpool, 778, 19);
            ds_priority_add(expressionpool1, 0, 19);
            ds_priority_add(expressionpool2, 3, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 0, 20);
            ds_priority_add(expressionpool2, 3, 20);
            ds_priority_add(soundpool, -4, 21);
            ds_priority_add(expressionpool1, 0, 21);
            ds_priority_add(expressionpool2, 3, 21);
            ds_priority_add(soundpool, 471, 22);
            ds_priority_add(expressionpool1, 0, 22);
            ds_priority_add(expressionpool2, 0, 22);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1088;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 163; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 139)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 139)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Maren";
            speakerhighlighted = 1;
            expression1 = 2;
            expression2 = 0;
            ds_priority_add(soundpool, 470, 2);
            ds_priority_add(expressionpool1, 2, 2);
            ds_priority_add(expressionpool2, 2, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 3, 3);
            ds_priority_add(expressionpool2, 2, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 3, 4);
            ds_priority_add(soundpool, 771, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 776, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, 471, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 2, 8);
            ds_priority_add(soundpool, 769, 9);
            ds_priority_add(expressionpool1, 2, 9);
            ds_priority_add(expressionpool2, 2, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 2, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 2, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, 469, 12);
            ds_priority_add(expressionpool1, 2, 12);
            ds_priority_add(expressionpool2, 2, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, 764, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 3, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, 471, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 3, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, 466, 19);
            ds_priority_add(expressionpool1, 3, 19);
            ds_priority_add(expressionpool2, 0, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 0, 20);
            ds_priority_add(expressionpool2, 0, 20);
            ds_priority_add(soundpool, -4, 21);
            ds_priority_add(expressionpool1, 0, 21);
            ds_priority_add(expressionpool2, 0, 21);
            ds_priority_add(soundpool, -4, 22);
            ds_priority_add(expressionpool1, 2, 22);
            ds_priority_add(expressionpool2, 0, 22);
            ds_priority_add(soundpool, -4, 23);
            ds_priority_add(expressionpool1, 2, 23);
            ds_priority_add(expressionpool2, 2, 23);
            ds_priority_add(soundpool, 801, 24);
            ds_priority_add(expressionpool1, 2, 24);
            ds_priority_add(expressionpool2, 2, 24);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1088;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
if (name1 == "Alden" || name2 == "Alden")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 188; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 165)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 165)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Alden";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, 94, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 2, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 2, 4);
            ds_priority_add(soundpool, 774, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, 91, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 2, 6);
            ds_priority_add(soundpool, 769, 7);
            ds_priority_add(expressionpool1, 2, 7);
            ds_priority_add(expressionpool2, 2, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 2, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, 772, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, 92, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 2, 12);
            ds_priority_add(soundpool, 773, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, 101, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 5, 14);
            ds_priority_add(soundpool, 777, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 5, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, 99, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 4, 18);
            ds_priority_add(soundpool, -4, 19);
            ds_priority_add(expressionpool1, 6, 19);
            ds_priority_add(expressionpool2, 4, 19);
            ds_priority_add(soundpool, 103, 20);
            ds_priority_add(expressionpool1, 6, 20);
            ds_priority_add(expressionpool2, 0, 20);
            ds_priority_add(soundpool, 770, 21);
            ds_priority_add(expressionpool1, 2, 21);
            ds_priority_add(expressionpool2, 0, 21);
            ds_priority_add(soundpool, -4, 22);
            ds_priority_add(expressionpool1, 2, 22);
            ds_priority_add(expressionpool2, 2, 22);
            ds_priority_add(soundpool, -4, 23);
            ds_priority_add(expressionpool1, 2, 23);
            ds_priority_add(expressionpool2, 2, 23);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1127;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 208; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 190)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 190)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Alden";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 3;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 3, 2);
            ds_priority_add(soundpool, 764, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 3, 3);
            ds_priority_add(soundpool, 101, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 3, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 3, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 6, 7);
            ds_priority_add(expressionpool2, 3, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 6, 8);
            ds_priority_add(expressionpool2, 4, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 3, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, 761, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 4, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 3, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 3, 12);
            ds_priority_add(soundpool, 783, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 3, 13);
            ds_priority_add(soundpool, 101, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 4, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 3, 15);
            ds_priority_add(soundpool, 801, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 3, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 1, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 1, 18);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1127;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 228; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 210)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 210)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Alden";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 6, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, 103, 3);
            ds_priority_add(expressionpool1, 6, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, 102, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 776, 7);
            ds_priority_add(expressionpool1, 3, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 5, 9);
            ds_priority_add(soundpool, 783, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 5, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 2, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 2, 13);
            ds_priority_add(expressionpool2, 5, 13);
            ds_priority_add(soundpool, 772, 14);
            ds_priority_add(expressionpool1, 2, 14);
            ds_priority_add(expressionpool2, 2, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 2, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 2, 17);
            ds_priority_add(soundpool, 770, 18);
            ds_priority_add(expressionpool1, 2, 18);
            ds_priority_add(expressionpool2, 2, 18);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1127;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
if (name1 == "Cia" || name2 == "Cia")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 248; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 230)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 230)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Cia";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, 326, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 4, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 2, 3);
            ds_priority_add(expressionpool2, 4, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, 764, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 3, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, 330, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 3, 8);
            ds_priority_add(soundpool, 766, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 3, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, 772, 13);
            ds_priority_add(expressionpool1, 3, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 3, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 3, 15);
            ds_priority_add(soundpool, 336, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 2, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, 328, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1097;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 265; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 250)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 250)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Cia";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 2;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, 324, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 3, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 330, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 3, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, 326, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, 322, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 3, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 3, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, 769, 15);
            ds_priority_add(expressionpool1, 2, 15);
            ds_priority_add(expressionpool2, 0, 15);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1097;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 296; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 267)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 267)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Cia";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 1;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 1, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 1, 3);
            ds_priority_add(soundpool, 783, 4);
            ds_priority_add(expressionpool1, 6, 4);
            ds_priority_add(expressionpool2, 1, 4);
            ds_priority_add(soundpool, 328, 5);
            ds_priority_add(expressionpool1, 6, 5);
            ds_priority_add(expressionpool2, 4, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 2, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 2, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, 325, 11);
            ds_priority_add(expressionpool1, 2, 11);
            ds_priority_add(expressionpool2, 2, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 2, 12);
            ds_priority_add(soundpool, 329, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 1, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 1, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, 764, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, -4, 19);
            ds_priority_add(expressionpool1, 0, 19);
            ds_priority_add(expressionpool2, 3, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 0, 20);
            ds_priority_add(expressionpool2, 3, 20);
            ds_priority_add(soundpool, 330, 21);
            ds_priority_add(expressionpool1, 0, 21);
            ds_priority_add(expressionpool2, 3, 21);
            ds_priority_add(soundpool, 771, 22);
            ds_priority_add(expressionpool1, 0, 22);
            ds_priority_add(expressionpool2, 3, 22);
            ds_priority_add(soundpool, -4, 23);
            ds_priority_add(expressionpool1, 0, 23);
            ds_priority_add(expressionpool2, 3, 23);
            ds_priority_add(soundpool, -4, 24);
            ds_priority_add(expressionpool1, 0, 24);
            ds_priority_add(expressionpool2, 3, 24);
            ds_priority_add(soundpool, -4, 25);
            ds_priority_add(expressionpool1, 0, 25);
            ds_priority_add(expressionpool2, 0, 25);
            ds_priority_add(soundpool, -4, 26);
            ds_priority_add(expressionpool1, 3, 26);
            ds_priority_add(expressionpool2, 0, 26);
            ds_priority_add(soundpool, -4, 27);
            ds_priority_add(expressionpool1, 3, 27);
            ds_priority_add(expressionpool2, 2, 27);
            ds_priority_add(soundpool, -4, 28);
            ds_priority_add(expressionpool1, 6, 28);
            ds_priority_add(expressionpool2, 2, 28);
            ds_priority_add(soundpool, -4, 29);
            ds_priority_add(expressionpool1, 2, 29);
            ds_priority_add(expressionpool2, 2, 29);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1097;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
if (name1 == "Elias" || name2 == "Elias")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 312; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 298)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 298)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Elias";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, 178, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 6, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 6, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 783, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, 773, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 2, 12);
            ds_priority_add(soundpool, 761, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 2, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1103;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 336; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 314)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 314)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Elias";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 3, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 3, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, 186, 4);
            ds_priority_add(expressionpool1, 3, 4);
            ds_priority_add(expressionpool2, 3, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, 184, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 6, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, 182, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 3, 13);
            ds_priority_add(soundpool, 766, 14);
            ds_priority_add(expressionpool1, 3, 14);
            ds_priority_add(expressionpool2, 3, 14);
            ds_priority_add(soundpool, 177, 15);
            ds_priority_add(expressionpool1, 3, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, 186, 19);
            ds_priority_add(expressionpool1, 0, 19);
            ds_priority_add(expressionpool2, 3, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 0, 20);
            ds_priority_add(expressionpool2, 0, 20);
            ds_priority_add(soundpool, -4, 21);
            ds_priority_add(expressionpool1, 0, 21);
            ds_priority_add(expressionpool2, 0, 21);
            ds_priority_add(soundpool, -4, 22);
            ds_priority_add(expressionpool1, 0, 22);
            ds_priority_add(expressionpool2, 0, 22);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1103;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 362; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 338)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 338)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Elias";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 3;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 3, 2);
            ds_priority_add(expressionpool2, 3, 2);
            ds_priority_add(soundpool, 777, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 3, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 3, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 3, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 3, 6);
            ds_priority_add(expressionpool2, 3, 6);
            ds_priority_add(soundpool, 776, 7);
            ds_priority_add(expressionpool1, 3, 7);
            ds_priority_add(expressionpool2, 3, 7);
            ds_priority_add(soundpool, 186, 8);
            ds_priority_add(expressionpool1, 3, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 3, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 3, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 3, 11);
            ds_priority_add(soundpool, 778, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 3, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, 772, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, 783, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 6, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, 180, 19);
            ds_priority_add(expressionpool1, 6, 19);
            ds_priority_add(expressionpool2, 2, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 2, 20);
            ds_priority_add(expressionpool2, 2, 20);
            ds_priority_add(soundpool, -4, 21);
            ds_priority_add(expressionpool1, 2, 21);
            ds_priority_add(expressionpool2, 2, 21);
            ds_priority_add(soundpool, -4, 22);
            ds_priority_add(expressionpool1, 2, 22);
            ds_priority_add(expressionpool2, 2, 22);
            ds_priority_add(soundpool, 188, 23);
            ds_priority_add(expressionpool1, 2, 23);
            ds_priority_add(expressionpool2, 4, 23);
            ds_priority_add(soundpool, -4, 24);
            ds_priority_add(expressionpool1, 2, 24);
            ds_priority_add(expressionpool2, 2, 24);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1103;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
if (name1 == "Lincoln" || name2 == "Lincoln")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 380; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 364)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 364)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Lincoln";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, 734, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 771, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, 736, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 2, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, 735, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, 772, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1093;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 399; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 382)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 382)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Lincoln";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 3;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 3, 2);
            ds_priority_add(soundpool, 777, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 3, 3);
            ds_priority_add(soundpool, 739, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 3, 4);
            ds_priority_add(soundpool, 776, 5);
            ds_priority_add(expressionpool1, 3, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, 733, 6);
            ds_priority_add(expressionpool1, 4, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 3, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 3, 8);
            ds_priority_add(expressionpool2, 3, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 3, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, 735, 10);
            ds_priority_add(expressionpool1, 3, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 3, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, 739, 12);
            ds_priority_add(expressionpool1, 3, 12);
            ds_priority_add(expressionpool2, 3, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 3, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, 801, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, 741, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1093;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 416; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 401)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 401)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Lincoln";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 2, 2);
            ds_priority_add(soundpool, 778, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 2, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, 765, 5);
            ds_priority_add(expressionpool1, 1, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 3, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 3, 8);
            ds_priority_add(expressionpool2, 3, 8);
            ds_priority_add(soundpool, 739, 9);
            ds_priority_add(expressionpool1, 3, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, 735, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 1, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 1, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 1, 15);
            ds_priority_add(expressionpool2, 1, 15);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1093;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
if (name1 == "Sloane" || name2 == "Sloane")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 436; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 418)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 418)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Sloane";
            speakerhighlighted = 1;
            expression1 = 6;
            expression2 = 1;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 6, 2);
            ds_priority_add(expressionpool2, 1, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 1, 3);
            ds_priority_add(soundpool, 383, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 1, 4);
            ds_priority_add(soundpool, 386, 5);
            ds_priority_add(expressionpool1, 6, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 6, 6);
            ds_priority_add(expressionpool2, 2, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 3, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, 771, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 6, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, 764, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, 387, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, 388, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 2, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 3, 18);
            ds_priority_add(expressionpool2, 0, 18);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1134;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 455; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 438)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 438)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Sloane";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, 776, 4);
            ds_priority_add(expressionpool1, 3, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 382, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 2, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, 771, 9);
            ds_priority_add(expressionpool1, 3, 9);
            ds_priority_add(expressionpool2, 2, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 4, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, 782, 12);
            ds_priority_add(expressionpool1, 3, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, 379, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 2, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 2, 15);
            ds_priority_add(expressionpool2, 1, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 2, 16);
            ds_priority_add(expressionpool2, 1, 16);
            ds_priority_add(soundpool, 377, 17);
            ds_priority_add(expressionpool1, 6, 17);
            ds_priority_add(expressionpool2, 4, 17);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1134;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 477; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 457)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 457)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Sloane";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, 387, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 2, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 2, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 382, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 2, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, 377, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 4, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 3, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, 385, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 3, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, 384, 19);
            ds_priority_add(expressionpool1, 0, 19);
            ds_priority_add(expressionpool2, 0, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 3, 20);
            ds_priority_add(expressionpool2, 0, 20);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1134;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
if (name1 == "Sara" || name2 == "Sara")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 497; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 479)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 479)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Sara";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 2, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, 211, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 205, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, 771, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, 769, 14);
            ds_priority_add(expressionpool1, 2, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 2, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, 210, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1170;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 529; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 499)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 499)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Sara";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 3, 2);
            ds_priority_add(soundpool, 764, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 3, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, 210, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, 205, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 3, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, 211, 17);
            ds_priority_add(expressionpool1, 3, 17);
            ds_priority_add(expressionpool2, 3, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, -4, 19);
            ds_priority_add(expressionpool1, 0, 19);
            ds_priority_add(expressionpool2, 0, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 0, 20);
            ds_priority_add(expressionpool2, 0, 20);
            ds_priority_add(soundpool, 207, 21);
            ds_priority_add(expressionpool1, 0, 21);
            ds_priority_add(expressionpool2, 2, 21);
            ds_priority_add(soundpool, -4, 22);
            ds_priority_add(expressionpool1, 0, 22);
            ds_priority_add(expressionpool2, 0, 22);
            ds_priority_add(soundpool, 766, 23);
            ds_priority_add(expressionpool1, 6, 23);
            ds_priority_add(expressionpool2, 0, 23);
            ds_priority_add(soundpool, -4, 24);
            ds_priority_add(expressionpool1, 0, 24);
            ds_priority_add(expressionpool2, 0, 24);
            ds_priority_add(soundpool, -4, 25);
            ds_priority_add(expressionpool1, 0, 25);
            ds_priority_add(expressionpool2, 0, 25);
            ds_priority_add(soundpool, 211, 26);
            ds_priority_add(expressionpool1, 0, 26);
            ds_priority_add(expressionpool2, 0, 26);
            ds_priority_add(soundpool, -4, 27);
            ds_priority_add(expressionpool1, 0, 27);
            ds_priority_add(expressionpool2, 0, 27);
            ds_priority_add(soundpool, -4, 28);
            ds_priority_add(expressionpool1, 0, 28);
            ds_priority_add(expressionpool2, 2, 28);
            ds_priority_add(soundpool, -4, 29);
            ds_priority_add(expressionpool1, 2, 29);
            ds_priority_add(expressionpool2, 0, 29);
            ds_priority_add(soundpool, 205, 30);
            ds_priority_add(expressionpool1, 2, 30);
            ds_priority_add(expressionpool2, 2, 30);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1170;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 552; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 531)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 531)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Sara";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, 208, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 2, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 2, 3);
            ds_priority_add(soundpool, 205, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 773, 7);
            ds_priority_add(expressionpool1, 6, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, 212, 8);
            ds_priority_add(expressionpool1, 6, 8);
            ds_priority_add(expressionpool2, 2, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 2, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 2, 10);
            ds_priority_add(soundpool, 769, 11);
            ds_priority_add(expressionpool1, 2, 11);
            ds_priority_add(expressionpool2, 2, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 2, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, 783, 17);
            ds_priority_add(expressionpool1, 3, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, -4, 19);
            ds_priority_add(expressionpool1, 2, 19);
            ds_priority_add(expressionpool2, 0, 19);
            ds_priority_add(soundpool, 210, 20);
            ds_priority_add(expressionpool1, 2, 20);
            ds_priority_add(expressionpool2, 2, 20);
            ds_priority_add(soundpool, -4, 21);
            ds_priority_add(expressionpool1, 2, 21);
            ds_priority_add(expressionpool2, 2, 21);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1170;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
if (name1 == "Vesta" || name2 == "Vesta")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 567; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 554)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 554)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Vesta";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, 710, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 0, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, 771, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, 774, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1192;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 589; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 569)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 569)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Vesta";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, 766, 4);
            ds_priority_add(expressionpool1, 3, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 0, 5);
            ds_priority_add(expressionpool2, 2, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 2, 6);
            ds_priority_add(soundpool, 710, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, 776, 8);
            ds_priority_add(expressionpool1, 3, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 3, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 0, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, 709, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 1, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 1, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 1, 14);
            ds_priority_add(expressionpool2, 3, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 3, 15);
            ds_priority_add(expressionpool2, 3, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 3, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, 783, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, 716, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            ds_priority_add(soundpool, -4, 19);
            ds_priority_add(expressionpool1, 0, 19);
            ds_priority_add(expressionpool2, 2, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 0, 20);
            ds_priority_add(expressionpool2, 0, 20);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1192;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 619; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 591)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 591)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Vesta";
            speakerhighlighted = 2;
            expression1 = 0;
            expression2 = 3;
            ds_priority_add(soundpool, 776, 2);
            ds_priority_add(expressionpool1, 3, 2);
            ds_priority_add(expressionpool2, 3, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 3, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 3, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, 716, 5);
            ds_priority_add(expressionpool1, 3, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 3, 6);
            ds_priority_add(expressionpool2, 3, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 3, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, 764, 8);
            ds_priority_add(expressionpool1, 3, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 3, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 3, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, -4, 11);
            ds_priority_add(expressionpool1, 4, 11);
            ds_priority_add(expressionpool2, 0, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 3, 12);
            ds_priority_add(expressionpool2, 0, 12);
            ds_priority_add(soundpool, 771, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 3, 14);
            ds_priority_add(soundpool, 760, 15);
            ds_priority_add(expressionpool1, 1, 15);
            ds_priority_add(expressionpool2, 3, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 0, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 0, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 3, 18);
            ds_priority_add(soundpool, 778, 19);
            ds_priority_add(expressionpool1, 3, 19);
            ds_priority_add(expressionpool2, 0, 19);
            ds_priority_add(soundpool, 700, 20);
            ds_priority_add(expressionpool1, 0, 20);
            ds_priority_add(expressionpool2, 0, 20);
            ds_priority_add(soundpool, -4, 21);
            ds_priority_add(expressionpool1, 0, 21);
            ds_priority_add(expressionpool2, 0, 21);
            ds_priority_add(soundpool, -4, 22);
            ds_priority_add(expressionpool1, 0, 22);
            ds_priority_add(expressionpool2, 0, 22);
            ds_priority_add(soundpool, -4, 23);
            ds_priority_add(expressionpool1, 6, 23);
            ds_priority_add(expressionpool2, 3, 23);
            ds_priority_add(soundpool, 718, 24);
            ds_priority_add(expressionpool1, 0, 24);
            ds_priority_add(expressionpool2, 3, 24);
            ds_priority_add(soundpool, -4, 25);
            ds_priority_add(expressionpool1, 2, 25);
            ds_priority_add(expressionpool2, 3, 25);
            ds_priority_add(soundpool, -4, 26);
            ds_priority_add(expressionpool1, 3, 26);
            ds_priority_add(expressionpool2, 3, 26);
            ds_priority_add(soundpool, -4, 27);
            ds_priority_add(expressionpool1, 0, 27);
            ds_priority_add(expressionpool2, 0, 27);
            ds_priority_add(soundpool, -4, 28);
            ds_priority_add(expressionpool1, 2, 28);
            ds_priority_add(expressionpool2, 0, 28);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1192;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
if (name1 == "Liberty" || name2 == "Liberty")
{
    if (level == 1)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 639; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 621)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 621)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Liberty";
            speakerhighlighted = 2;
            expression1 = 3;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 1, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, 823, 3);
            ds_priority_add(expressionpool1, 1, 3);
            ds_priority_add(expressionpool2, 2, 3);
            ds_priority_add(soundpool, -4, 4);
            ds_priority_add(expressionpool1, 3, 4);
            ds_priority_add(expressionpool2, 2, 4);
            ds_priority_add(soundpool, -4, 5);
            ds_priority_add(expressionpool1, 3, 5);
            ds_priority_add(expressionpool2, 0, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 0, 6);
            ds_priority_add(soundpool, 828, 7);
            ds_priority_add(expressionpool1, 0, 7);
            ds_priority_add(expressionpool2, 3, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 3, 8);
            ds_priority_add(expressionpool2, 0, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 0, 9);
            ds_priority_add(expressionpool2, 0, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 6, 10);
            ds_priority_add(expressionpool2, 0, 10);
            ds_priority_add(soundpool, 821, 11);
            ds_priority_add(expressionpool1, 6, 11);
            ds_priority_add(expressionpool2, 2, 11);
            ds_priority_add(soundpool, 764, 12);
            ds_priority_add(expressionpool1, 3, 12);
            ds_priority_add(expressionpool2, 2, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 3, 13);
            ds_priority_add(expressionpool2, 3, 13);
            ds_priority_add(soundpool, -4, 14);
            ds_priority_add(expressionpool1, 3, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, 778, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 0, 15);
            ds_priority_add(soundpool, 822, 16);
            ds_priority_add(expressionpool1, 0, 16);
            ds_priority_add(expressionpool2, 3, 16);
            ds_priority_add(soundpool, 761, 17);
            ds_priority_add(expressionpool1, 0, 17);
            ds_priority_add(expressionpool2, 3, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 0, 18);
            ds_priority_add(expressionpool2, 0, 18);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1181;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 2)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 661; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 641)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 641)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Liberty";
            speakerhighlighted = 1;
            expression1 = 0;
            expression2 = 0;
            ds_priority_add(soundpool, -4, 2);
            ds_priority_add(expressionpool1, 0, 2);
            ds_priority_add(expressionpool2, 0, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 0, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, 766, 4);
            ds_priority_add(expressionpool1, 3, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, 828, 5);
            ds_priority_add(expressionpool1, 3, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 0, 6);
            ds_priority_add(expressionpool2, 3, 6);
            ds_priority_add(soundpool, -4, 7);
            ds_priority_add(expressionpool1, 2, 7);
            ds_priority_add(expressionpool2, 0, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 0, 8);
            ds_priority_add(expressionpool2, 3, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 6, 9);
            ds_priority_add(expressionpool2, 3, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 6, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, 821, 11);
            ds_priority_add(expressionpool1, 0, 11);
            ds_priority_add(expressionpool2, 3, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 0, 12);
            ds_priority_add(expressionpool2, 3, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 0, 13);
            ds_priority_add(expressionpool2, 0, 13);
            ds_priority_add(soundpool, 777, 14);
            ds_priority_add(expressionpool1, 0, 14);
            ds_priority_add(expressionpool2, 0, 14);
            ds_priority_add(soundpool, 828, 15);
            ds_priority_add(expressionpool1, 0, 15);
            ds_priority_add(expressionpool2, 3, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 2, 16);
            ds_priority_add(expressionpool2, 3, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 2, 17);
            ds_priority_add(expressionpool2, 4, 17);
            ds_priority_add(soundpool, 827, 18);
            ds_priority_add(expressionpool1, 2, 18);
            ds_priority_add(expressionpool2, 2, 18);
            ds_priority_add(soundpool, -4, 19);
            ds_priority_add(expressionpool1, 6, 19);
            ds_priority_add(expressionpool2, 2, 19);
            ds_priority_add(soundpool, -4, 20);
            ds_priority_add(expressionpool1, 4, 20);
            ds_priority_add(expressionpool2, 2, 20);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1181;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
    else if (level == 3)
    {
        instance_deactivate_all(true);
        with (instance_create(0, 0, obj_text_holder))
        {
        }
        with (instance_create(0, 0, obj_dialogue_character_display))
        {
            instance_activate_object(obj_game_data);
            instance_activate_object(obj_controller);
            var file = file_text_open_read("Bonds//" + filebranch + "Bonds_Irving.txt");
            for (ii = 0; ii <= 681; ii += 1)
            {
                if (file_text_eof(file))
                {
                    break;
                }
                if (ii > 663)
                {
                    ds_priority_add(speakerpool, file_text_read_string(file), ii);
                }
                file_text_readln(file);
                if (ii > 663)
                {
                    ds_priority_add(obj_text_holder.text_holder, file_text_read_string(file), ii);
                }
                file_text_readln(file);
            }
            file_text_close(file);
            unit1 = "Irving";
            unit2 = "Liberty";
            speakerhighlighted = 2;
            ds_priority_add(soundpool, 776, 2);
            ds_priority_add(expressionpool1, 3, 2);
            ds_priority_add(expressionpool2, 2, 2);
            ds_priority_add(soundpool, -4, 3);
            ds_priority_add(expressionpool1, 3, 3);
            ds_priority_add(expressionpool2, 0, 3);
            ds_priority_add(soundpool, 765, 4);
            ds_priority_add(expressionpool1, 1, 4);
            ds_priority_add(expressionpool2, 0, 4);
            ds_priority_add(soundpool, 828, 5);
            ds_priority_add(expressionpool1, 3, 5);
            ds_priority_add(expressionpool2, 3, 5);
            ds_priority_add(soundpool, -4, 6);
            ds_priority_add(expressionpool1, 1, 6);
            ds_priority_add(expressionpool2, 3, 6);
            ds_priority_add(soundpool, 819, 7);
            ds_priority_add(expressionpool1, 1, 7);
            ds_priority_add(expressionpool2, 4, 7);
            ds_priority_add(soundpool, -4, 8);
            ds_priority_add(expressionpool1, 1, 8);
            ds_priority_add(expressionpool2, 4, 8);
            ds_priority_add(soundpool, -4, 9);
            ds_priority_add(expressionpool1, 1, 9);
            ds_priority_add(expressionpool2, 4, 9);
            ds_priority_add(soundpool, -4, 10);
            ds_priority_add(expressionpool1, 1, 10);
            ds_priority_add(expressionpool2, 3, 10);
            ds_priority_add(soundpool, 778, 11);
            ds_priority_add(expressionpool1, 3, 11);
            ds_priority_add(expressionpool2, 3, 11);
            ds_priority_add(soundpool, -4, 12);
            ds_priority_add(expressionpool1, 1, 12);
            ds_priority_add(expressionpool2, 3, 12);
            ds_priority_add(soundpool, -4, 13);
            ds_priority_add(expressionpool1, 3, 13);
            ds_priority_add(expressionpool2, 3, 13);
            ds_priority_add(soundpool, 831, 14);
            ds_priority_add(expressionpool1, 3, 14);
            ds_priority_add(expressionpool2, 1, 14);
            ds_priority_add(soundpool, -4, 15);
            ds_priority_add(expressionpool1, 3, 15);
            ds_priority_add(expressionpool2, 1, 15);
            ds_priority_add(soundpool, -4, 16);
            ds_priority_add(expressionpool1, 3, 16);
            ds_priority_add(expressionpool2, 3, 16);
            ds_priority_add(soundpool, -4, 17);
            ds_priority_add(expressionpool1, 3, 17);
            ds_priority_add(expressionpool2, 1, 17);
            ds_priority_add(soundpool, -4, 18);
            ds_priority_add(expressionpool1, 1, 18);
            ds_priority_add(expressionpool2, 1, 18);
            if (ds_grid_value_exists(obj_game_data.characters, 0, 0, 29, 5, 1122))
            {
                actor1 = 1122;
            }
            else
            {
                actor1 = 1119;
            }
            actor2 = 1181;
            speaker = ds_priority_delete_min(speakerpool);
            speakerpositionx = display_get_gui_width() * 0.25;
        }
        with (instance_create(0, 0, obj_text_scroll))
        {
            text = ds_priority_delete_min(obj_text_holder.text_holder);
            audio = true;
            alarm[1] = 1;
        }
    }
}
with (obj_dialogue_character_display)
{
    bonddist = true;
}
instance_destroy();
