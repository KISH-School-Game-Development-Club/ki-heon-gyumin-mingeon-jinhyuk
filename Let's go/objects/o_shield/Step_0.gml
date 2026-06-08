x = o_player.x
y = o_player.y
image_xscale =  sign(o_player.dashdir)
if(o_player.sdur > 0){
	visible = 1
	global.mainwalls = [o_wall, o_floor_test_ver, o_wall2, o_shield];
}else if(o_player.sdur <= 0){
	visible = 0
	global.mainwalls = [o_wall, o_floor_test_ver, o_wall2];
}