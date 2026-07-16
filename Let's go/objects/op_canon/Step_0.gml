if (global.paused) exit;
shootcool --
if shootcool <= 0{
	instance_create_layer(x, y, "enemy", which_bullet);
	shootcool = reshootcool;
}

