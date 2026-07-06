with (obj_door_1)
{
    if (x > (other.x - 100) && x < (other.x + 100))
    {
        frame = 1;
        global.map[x1 / 32][y1 / 32].passable = true;
        global.map[x2 / 32][y2 / 32].passable = true;
    }
}
