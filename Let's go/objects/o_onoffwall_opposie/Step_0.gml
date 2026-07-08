if (o_gamecontroller.onoff == 0){
	visible = 1
	mask_index = -1
}else if (o_gamecontroller.onoff == 1){
	visible = 0
	mask_index = asset_get_index("noone");
}

if (o_onoffwall_opposie.visible == true) {
    if (array_get_index(global.mainwalls, o_onoffwall_opposie) == -1) {
        array_push(global.mainwalls, o_onoffwall_opposie);
    }
	if (array_get_index(global.dashwalls, o_onoffwall_opposie) == -1) {
        array_push(global.dashwalls, o_onoffwall_opposie);
    }
}else{
    var _index = array_get_index(global.mainwalls, o_onoffwall_opposie);
	var _index2 = array_get_index(global.dashwalls, o_onoffwall_opposie);
    if (_index != -1) {
        array_delete(global.mainwalls, _index, 1);
		array_delete(global.dashwalls, _index2, 1);
    }
}