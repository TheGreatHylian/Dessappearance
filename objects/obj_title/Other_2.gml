//variable
global.start_room = rm_paps
global.start_x = 160
global.start_y = 140

global.new_game = false

//rooms ids
global.rm0 = 0
global.rm1 = 1
global.rm2 = 2
global.rm3 = 3
global.rm4 = 4
global.rm5 = 5

if(file_exists("dessappearance.ini")){

	instance_create_depth(-60, 67, 100, obj_buttons_continue)

	ini_open("dessappearance.ini")
	global.start_room = ini_read_string("Save1", "room", rm_paps)
	global.start_x = ini_read_real("Save1", "x", 160)
	global.start_y = ini_read_real("Save1", "y", 140)
	ini_close()

} else{

	instance_create_depth(-60, 67, 100, obj_buttons)

}

if(global.start_room = 0){

	global.start_room = rm_test

}
if(global.start_room = 1){

	global.start_room = rm_paps

}
if(global.start_room = 2){

	global.start_room = rm_test_waterfall

}

