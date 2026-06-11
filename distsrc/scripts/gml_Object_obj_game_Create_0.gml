if (camera_get_view_x(view_camera[0]) < 96)
    camera_set_view_pos(view_camera[0], 96, camera_get_view_y(view_camera[0]));

if (camera_get_view_y(view_camera[0]) < 96)
    camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]), 96);

if (camera_get_view_width(view_camera[0]) > min(room_width - 542, 576) || camera_get_view_height(view_camera[0]) > min(room_height - 390, 324))
{
    do
        camera_set_view_size(view_camera[0], camera_get_view_width(view_camera[0]) - 128, camera_get_view_height(view_camera[0]) - 72);
    until (camera_get_view_width(view_camera[0]) <= min(room_width - 542, 576) && camera_get_view_height(view_camera[0]) <= min(room_height - 390, 324));
}

if (camera_get_view_width(view_camera[0]) < min(room_width - 542, 576) && camera_get_view_height(view_camera[0]) < min(room_height - 390, 324))
    camera_set_view_size(view_camera[0], camera_get_view_width(view_camera[0]) + 128, camera_get_view_height(view_camera[0]) + 72);

instance_create(96, 96, obj_cursor_follower);
instance_create(0, 0, obj_room_transition_in);
instance_create(0, 0, obj_audio_loader);
loader = 0;
spelllistchunking = ds_list_create();
pack1 = 0;
turndelay = 0;
savegrid = ds_grid_create(100, 10);
savegrid2 = ds_grid_create(1, 5);
ds_list_add(spelllistchunking, 209, 210, 211, 212, 213, 214, 215, 216, 229, 230, 231, 232, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 285, 286, 287, 288, 305, 306, 307, 308, 309, 310, 311, 312);
state = "initializing";
turn_counter = 0;
global.attacker = -4;
redturnkeeper = 0;
redturnenforcer = 0;
map_width = room_width / 32;
map_height = room_height / 32;
enemiesonmap = 0;
enemyturnskip = false;

for (xx = 0; xx <= map_width; xx += 1)
{
    for (yy = 0; yy <= map_height; yy += 1)
    {
        global.map[xx][yy] = instance_create_depth(xx * 32, yy * 32, 0, obj_node);
        global.map[xx][yy].GridX = xx;
        global.map[xx][yy].GridY = yy;
        global.map[xx][yy].occupant = -4;
    }
}

for (xx = 0; xx < map_width; xx += 1)
{
    for (yy = 0; yy < map_height; yy += 1)
    {
        node = global.map[xx][yy];
        
        if (xx > 0)
        {
            ds_list_add(node.neighbors, global.map[xx - 1][yy]);
            ds_list_add(node.viewneighborsmelee, global.map[xx - 1][yy]);
        }
        
        if (xx < (map_width - 1))
        {
            ds_list_add(node.neighbors, global.map[xx + 1][yy]);
            ds_list_add(node.viewneighborsmelee, global.map[xx + 1][yy]);
        }
        
        if (yy > 0)
        {
            ds_list_add(node.neighbors, global.map[xx][yy - 1]);
            ds_list_add(node.viewneighborsmelee, global.map[xx][yy - 1]);
        }
        
        if (yy < (map_height - 1))
        {
            ds_list_add(node.neighbors, global.map[xx][yy + 1]);
            ds_list_add(node.viewneighborsmelee, global.map[xx][yy + 1]);
        }
        
        if (yy > 0 && xx > 0)
            ds_list_add(node.viewneighborsranged, global.map[xx - 1][yy - 1]);
        
        if (yy < (map_height - 1) && xx < (map_width - 1))
            ds_list_add(node.viewneighborsranged, global.map[xx + 1][yy + 1]);
        
        if (yy < (map_height - 1) && xx > 0)
            ds_list_add(node.viewneighborsranged, global.map[xx - 1][yy + 1]);
        
        if (yy > 0 && xx < (map_width - 1))
            ds_list_add(node.viewneighborsranged, global.map[xx + 1][yy - 1]);
        
        if (yy > 1)
            ds_list_add(node.viewneighborsranged, global.map[xx][yy - 2]);
        
        if (xx > 1)
            ds_list_add(node.viewneighborsranged, global.map[xx - 2][yy]);
        
        if (xx < (map_width - 2))
            ds_list_add(node.viewneighborsranged, global.map[xx + 2][yy]);
        
        if (yy < (map_height - 2))
            ds_list_add(node.viewneighborsranged, global.map[xx][yy + 2]);
    }
}

instance_create_depth(x, y, -3, obj_cursor);
obj_cursor.cursor_active = false;
alarm[0] = 30;
actorcontingent = -4;
combatskills = ds_list_create();
combatskillscounter = ds_list_create();
