selectedbonder = -4;
secondbonder = -4;
ds_priority_destroy(bondersview);

if (instance_exists(obj_bond_conversations))
{
    with (obj_bond_conversations)
        instance_destroy();
}
