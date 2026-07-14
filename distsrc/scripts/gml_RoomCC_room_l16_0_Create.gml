equippedcoord = 180;
name = "Dragon";
level = 30;
xpvalue = 40;
tempHP = 2500;

if (global.difficulty == "Deity")
    HP = 2800;
else if (global.difficulty == "Demigod")
    HP = 2500;
else if (global.difficulty == "Mortal")
    HP = 2200;

strength = 40;
magic = 35;
pwr = 45;
dodge = 0;
accuracy = 150;
crit = 0;
eff_spd = 4;
spd = 5;
constitution = 18;
fortitude = 14;
mastery = 30;
dexterity = 10;
luck = 25;
move = 0;
boss = true;
equippedweapon = "Claws";
cancountermelee = true;
cancounterranged = false;
damagesubtype = "slashing";
dtype = "heavy";
attacktype = "melee";
attackrange = 64;
damagetype = "hybrid";
class = "";
onlyranged = false;
scr_update_equipment_all();
fullportrait = 890;
head = 890;
head2 = 890;
ds_list_clear(strikes);
ds_list_clear(critstrikes);
ds_list_add(strikes, 41);
ds_list_add(critstrikes, 41);
combatlength = 57;
combatlengthcrit = 57;
spell1 = 50;
spell2 = 55;
dodgefreeze = 4;
normalsprite = 3148;
normalattack = 3146;
normalcrit = 3146;
hurtsprite = 3148;
normaldodge = 3148;
