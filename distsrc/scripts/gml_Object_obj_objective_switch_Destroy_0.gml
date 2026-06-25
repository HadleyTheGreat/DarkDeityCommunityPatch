with (obj_switchdoor)
{
    if (y == other.y)
    {
        global.map[x / 32][y / 32].passable = true;
        instance_destroy();
    }
}
