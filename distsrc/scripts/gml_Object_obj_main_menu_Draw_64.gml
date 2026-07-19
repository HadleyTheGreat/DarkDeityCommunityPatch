var menuwidth;
if (global.language == "English")
{
    menuwidth = 0;
}
else if (global.language == "French")
{
    menuwidth = 1;
}
else if (global.language == "Italian")
{
    menuwidth = 2;
}
else if (global.language == "German")
{
    menuwidth = 3;
}
else if (global.language == "Spanish")
{
    menuwidth = 4;
}
else if (global.language == "Japanese")
{
    menuwidth = 5;
}
else if (global.language == "Korean")
{
    menuwidth = 6;
}
else if (global.language == "Chinese")
{
    menuwidth = 7;
}
var wgui = display_get_gui_width();
var hgui = display_get_gui_height();
var xgui = wgui / 1920;
var ygui = hgui / 1080;
gpu_set_texfilter(true);
if (!instance_exists(obj_main_menu_load) && !instance_exists(obj_options_menu) && !instance_exists(obj_main_menu_newgame) && !instance_exists(obj_main_menu_extras))
{
    draw_sprite_ext(spr_mainmenu_layer1, 0, 0, 0, xgui, ygui, 0, c_white, 1);
    draw_sprite_ext(spr_mainmenu_logo, 0, 0, 0, xgui, ygui, 0, c_white, 1);
    if (index1 == 1)
    {
        draw_sprite_ext(spr_mainmenu_newgamehighlight, menuwidth, 0, 0, xgui, ygui, 0, c_white, 1);
    }
    else
    {
        draw_sprite_ext(spr_mainmenu_newgame, menuwidth, 0, 0, xgui, ygui, 0, c_white, 1);
    }
    if (index2 == 1)
    {
        draw_sprite_ext(spr_mainmenu_loadhighlight, menuwidth, 0, 0, xgui, ygui, 0, c_white, 1);
    }
    else
    {
        draw_sprite_ext(spr_mainmenu_load, menuwidth, 0, 0, xgui, ygui, 0, c_white, 1);
    }
    if (global.language != "English")
    {
        if (index3 == 1)
        {
            draw_sprite_ext(spr_mainmenu_optionshighlight, menuwidth - 1, 0, 0, xgui, ygui, 0, c_white, 1);
        }
        else
        {
            draw_sprite_ext(spr_mainmenu_options, menuwidth - 1, 0, 0, xgui, ygui, 0, c_white, 1);
        }
    }
    else if (index3 == 1)
    {
        draw_sprite_ext(spr_mainmenu_optionshighlight, 0, 0, 0, xgui, ygui, 0, c_white, 1);
    }
    else
    {
        draw_sprite_ext(spr_mainmenu_options, 0, 0, 0, xgui, ygui, 0, c_white, 1);
    }
    if (global.DLC_Enabled == false)
    {
        if (index4 == 1)
        {
            draw_sprite_ext(spr_mainmenu_exithighlight, menuwidth, 0, -0.0842592 * hgui, xgui, ygui, 0, c_white, 1);
        }
        else
        {
            draw_sprite_ext(spr_mainmenu_exit, menuwidth, 0, -0.0842592 * hgui, xgui, ygui, 0, c_white, 1);
        }
    }
    else
    {
        if (index4 == 1)
        {
            draw_sprite_ext(spr_mainmenu_extrashighlight, menuwidth, 0, 0, xgui, ygui, 0, c_white, 1);
        }
        else
        {
            draw_sprite_ext(spr_mainmenu_extras, menuwidth, 0, 0, xgui, ygui, 0, c_white, 1);
        }
        if (index5 == 1)
        {
            draw_sprite_ext(spr_mainmenu_exithighlight, menuwidth, 0, 0, xgui, ygui, 0, c_white, 1);
        }
        else
        {
            draw_sprite_ext(spr_mainmenu_exit, menuwidth, 0, 0, xgui, ygui, 0, c_white, 1);
        }
    }
}
draw_set_font(font_spartan_16);
draw_set_color(c_white);
draw_set_alpha(1);
draw_text_transformed(wgui * 0.95, hgui * 0.96, "v1.58c", xgui, ygui, 0);
draw_text_transformed(wgui * 0.01, hgui * 0.96, "Community Patch v3.0.0", xgui, ygui, 0);
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_font(font_spartan_36);
if (!instance_exists(obj_main_menu_load) && !instance_exists(obj_main_menu_newgame) && !instance_exists(obj_options_menu) && !instance_exists(obj_main_menu_extras))
{
    draw_sprite_ext(spr_headline_small, 0, -wgui * 0.3, hgui * 0.85, xgui, ygui, 0, langhov1, 1);
    draw_sprite_ext(spr_headline_small, 0, -wgui * 0.15, hgui * 0.85, xgui, ygui, 0, langhov2, 1);
    draw_sprite_ext(spr_headline_small, 0, 0, hgui * 0.85, xgui, ygui, 0, langhov3, 1);
    draw_sprite_ext(spr_headline_small, 0, wgui * 0.15, hgui * 0.85, xgui, ygui, 0, langhov4, 1);
    draw_sprite_ext(spr_headline_small, 0, wgui * 0.3, hgui * 0.85, xgui, ygui, 0, langhov5, 1);
    draw_sprite_ext(spr_headline_small, 0, wgui * 0.45, hgui * 0.85, xgui, ygui, 0, langhov6, 1);
    draw_sprite_ext(spr_headline_small, 0, wgui * 0, hgui * 0.8, xgui, ygui, 0, langhov8, 1);
    draw_sprite_ext(spr_headline_small, 0, wgui * 0.15, hgui * 0.8, xgui, ygui, 0, langhov7, 1);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    draw_set_font(global.font_jp);
    draw_text_ext_transformed_color(wgui * 0.1164, hgui * 0.91, "English", 0, 1000, 0.8 * xgui, 0.8 * ygui, 0, 16777215, 16777215, 16777215, 16777215, 1);
    draw_text_ext_transformed_color((wgui * 0.1164) + (wgui * 0.15), hgui * 0.91, "Français", 0, 1000, 0.8 * xgui, 0.8 * ygui, 0, 16777215, 16777215, 16777215, 16777215, 1);
    draw_text_ext_transformed_color((wgui * 0.1164) + (wgui * 0.3), hgui * 0.91, "Italiano", 0, 1000, 0.8 * xgui, 0.8 * ygui, 0, 16777215, 16777215, 16777215, 16777215, 1);
    draw_text_ext_transformed_color((wgui * 0.1164) + (wgui * 0.45), hgui * 0.91, "Deutsch", 0, 1000, 0.8 * xgui, 0.8 * ygui, 0, 16777215, 16777215, 16777215, 16777215, 1);
    draw_text_ext_transformed_color((wgui * 0.1164) + (wgui * 0.6), hgui * 0.91, "Español", 0, 1000, 0.8 * xgui, 0.8 * ygui, 0, 16777215, 16777215, 16777215, 16777215, 1);
    draw_text_ext_transformed_color((wgui * 0.1164) + (wgui * 0.75), hgui * 0.91, "日本語", 0, 1000, 0.8 * xgui, 0.8 * ygui, 0, 16777215, 16777215, 16777215, 16777215, 1);
    draw_text_ext_transformed_color((wgui * 0.1164) + (wgui * 0.45), (hgui * 0.91) - (hgui * 0.05), "简体中文", 0, 1000, 0.8 * xgui, 0.8 * ygui, 0, 16777215, 16777215, 16777215, 16777215, 1);
    draw_set_font(font_kr);
    draw_text_ext_transformed_color((wgui * 0.1164) + (wgui * 0.3), (hgui * 0.912) - (hgui * 0.05), "한국어", 0, 1000, 0.8 * xgui, 0.8 * ygui, 0, 16777215, 16777215, 16777215, 16777215, 1);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    if (global.usingcontroller)
    {
        draw_sprite_ext(spr_prompt_gp_lb, 0, wgui * 0.02, hgui * 0.928, xgui / 3, ygui / 3, 0, c_white, 1);
    }
}
if (!instance_exists(obj_options_menu))
{
    if (global.usingcontroller != true)
    {
        gpu_set_texfilter(true);
        var clickied = 0;
        if (mouse_check_button(mb_left))
        {
            clickied = 1;
        }
        draw_sprite_ext(spr_pedro_cursor, clickied, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), wgui / 1920, hgui / 1080, 0, c_white, 1);
        gpu_set_texfilter(false);
    }
}
gpu_set_texfilter(false);
