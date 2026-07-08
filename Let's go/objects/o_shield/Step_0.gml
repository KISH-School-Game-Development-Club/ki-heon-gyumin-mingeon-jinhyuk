x = o_player.x
y = o_player.y
image_xscale =  sign(o_player.dashdir)
if(o_player.sdur > 0){
	visible = 1
	mask_index = -1
}else if(o_player.sdur <= 0){
	visible = 0
	mask_index = -4
}
if (o_shield.visible == true) {
    if (array_get_index(global.mainwalls, o_shield) == -1) {
        array_push(global.mainwalls, o_shield);
    }
}else{
    var _index = array_get_index(global.mainwalls, o_shield);
    if (_index != -1) {
        array_delete(global.mainwalls, _index, 1);
    }
}