if(file_exists(global.json) and !global.new_game){
	instance_create_depth(-60, 67, 100, obj_buttons_continue)
} else{
	instance_create_depth(-60, 67, 100, obj_buttons)
}