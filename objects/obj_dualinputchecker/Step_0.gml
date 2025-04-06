//select
if keyboard_check_pressed(global.selectbutton) or keyboard_check_pressed(vk_enter){
	global.selectbuttonpressed = true
} else{
	global.selectbuttonpressed = false
}

//sprint
if keyboard_check_pressed(global.sprintbutton) or keyboard_check_pressed(vk_shift){
	global.sprintbuttonpressed = true
} else{
	global.sprintbuttonpressed = false
}

//up
if keyboard_check_pressed(global.upbutton) or keyboard_check_pressed(vk_up){
	global.upbuttonpressed1 = true
} else{
	global.upbuttonpressed1 = false
}

if keyboard_check(global.upbutton) or keyboard_check(vk_up){
	global.upbuttonpressed = true
} else{
	global.upbuttonpressed = false
}

//down
if keyboard_check_pressed(global.downbutton) or keyboard_check_pressed(vk_down){
	global.downbuttonpressed1 = true
} else{
	global.downbuttonpressed1 = false
}

if keyboard_check(global.downbutton) or keyboard_check(vk_down){
	global.downbuttonpressed = true
} else{
	global.downbuttonpressed = false
}

//left
if keyboard_check_pressed(global.leftbutton) or keyboard_check_pressed(vk_left){
	global.leftbuttonpressed1 = true
} else{
	global.leftbuttonpresse1 = false
}

if keyboard_check(global.leftbutton) or keyboard_check(vk_left){
	global.leftbuttonpressed = true
} else{
	global.leftbuttonpressed = false
}

//right
if keyboard_check_pressed(global.rightbutton) or keyboard_check_pressed(vk_right){
	global.rightbuttonpressed1 = true
} else{
	global.rightbuttonpresse1 = false
}

if keyboard_check(global.rightbutton) or keyboard_check(vk_right){
	global.rightbuttonpressed = true
} else{
	global.rightbuttonpressed = false
}