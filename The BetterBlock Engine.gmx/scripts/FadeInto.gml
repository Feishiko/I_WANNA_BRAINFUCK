///FadeInto(roomTo);
roomTo = argument0;
if(!instance_exists(oFadeIn)){
    var ins = instance_create(0, 0, oFadeIn);
    ins.roomTo = roomTo;
}
