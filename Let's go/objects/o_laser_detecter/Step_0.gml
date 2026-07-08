//레이저 끝점 계산
var length = 0;
 var hit_wall = false;
while (length < max_length && hit_wall != true) {
    var check_x = x + lengthdir_x(length, laser_angle);
    var check_y = y + lengthdir_y(length, laser_angle);
    hit_wall = false;
    for (var i = 0; i < array_length(global.mainwalls); i++) {
        if (position_meeting(check_x, check_y, global.mainwalls[i])) {
            hit_wall = true;
        }
    }
    if (hit_wall) {
        laser_end_x = check_x;
        laser_end_y = check_y;
    }
    
    length += 4;
    
    // 벽에 안 부딪힐 때
    laser_end_x = check_x;
    laser_end_y = check_y;
}

//플레이어 감지
if (collision_line(x, y, laser_end_x, laser_end_y, o_player, false, true)) {
detected = true;
}