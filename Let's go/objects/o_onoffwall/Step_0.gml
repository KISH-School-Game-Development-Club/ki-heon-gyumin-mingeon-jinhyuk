if (o_gamecontroller.onoff == 1){
	visible = 1
	mask_index = -1
}else if (o_gamecontroller.onoff == 0){
	visible = 0
	mask_index = asset_get_index("noone");
}

if (o_onoffwall.visible == true) {
    if (array_get_index(global.mainwalls, o_onoffwall) == -1) {
        array_push(global.mainwalls, o_onoffwall);
    }
	if (array_get_index(global.dashwalls, o_onoffwall) == -1) {
        array_push(global.dashwalls, o_onoffwall);
    }
}else{
    var index = array_get_index(global.mainwalls, o_onoffwall);
	var index2 = array_get_index(global.dashwalls, o_onoffwall);
    if (index != -1) {
        array_delete(global.mainwalls, index, 1);
		array_delete(global.dashwalls, index2, 1);
    }
}