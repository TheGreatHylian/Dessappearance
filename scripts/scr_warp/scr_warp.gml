function scr_warp(room, x = 0, y = 0, facing = "down", do_fade = true, seconds = 0.2){
    if !instance_exists(obj_mainchara){
        instance_create_depth(x, y, depth, obj_mainchara)
    }
    if do_fade{
        var fade = instance_create_depth(0, 0, -9999, obj_fade)
    	fade.target_x = x
    	fade.target_y = y
    	fade.target_room = room
    	fade.facing = facing
        fade.increment = 1 / (60 * seconds)
    }
}