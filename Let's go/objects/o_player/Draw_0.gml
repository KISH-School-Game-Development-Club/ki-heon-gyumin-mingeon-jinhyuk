draw_self()

draw_text(100, 100, string(scool));
draw_text(100, 200, string(global.player_hp));
if instance_exists(o_enemy_boss){
	draw_text(100, 500, string(o_enemy_boss.speedy));
}
draw_text(100, 600, string(test));


