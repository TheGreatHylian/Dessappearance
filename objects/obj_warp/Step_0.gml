if place_meeting(x,y, obj_player) and !instance_exists(obj_fade){

	var instantiated = instance_create_depth(0, 0, -9999, obj_fade)
	instantiated.target_x = target_x
	instantiated.target_y = target_y
	instantiated.target_room = target_room
	instantiated.facing = facing

}