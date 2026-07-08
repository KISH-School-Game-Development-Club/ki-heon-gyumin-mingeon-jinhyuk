//레이저 끝점 계산
var current_length = 0;
 var hit_wall = false;
while (current_length < max_length && hit_wall != true) {
    var check_x = x + lengthdir_x(current_length, laser_angle);
    var check_y = y + lengthdir_y(current_length, laser_angle);
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
    
    current_length += 4; // 4픽셀씩 검사
    
    // 벽에 안 부딪힐 때
    laser_end_x = check_x;
    laser_end_y = check_y;
}
