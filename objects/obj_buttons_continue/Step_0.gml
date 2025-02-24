//slide on screen
if(x < 10){

	x += 1

}

//don't shake
x[0] = round(x[0.1])
y[0] = round(y[0.1])

//start save
ini_open("dessappearance.ini")
if(image_index = 0 and keyboard_check_pressed(ord("Z"))){

	room_goto(global.start_room)
	var instantiated = instance_create_layer(global.start_x, global.start_y, "Player", obj_player)
	global.new_game = false
	
}
if (image_index = 1 and keyboard_check(ord("Z"))){

	file_delete("dessappearance.ini")
	game_restart()

}
ini_close()