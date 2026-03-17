function scr_updatecontrols(){
if file_exists("controls.ini"){
	ini_open("controls.ini")
	obj_initialize.selectkey = ini_read_string("Save", "Select", "Z")
	obj_initialize.cancelkey = ini_read_string("Save", "Cancel", "X")
	obj_initialize.sprintkey = ini_read_string("Save", "Sprint", "X")
	obj_initialize.menukey = ini_read_string("Save", "Menu", "C")
	obj_initialize.upkey = ini_read_string("Save", "Up", "W")
	obj_initialize.downkey = ini_read_string("Save", "Down", "S")
	obj_initialize.leftkey = ini_read_string("Save", "Left", "A")
	obj_initialize.rightkey = ini_read_string("Save", "Right", "D")
}

global.selectbutton = ord(obj_initialize.selectkey)
global.cancelbutton = ord(obj_initialize.cancelkey)
global.sprintbutton = ord(obj_initialize.sprintkey)
global.menubutton = ord(obj_initialize.menukey)
global.upbutton = ord(obj_initialize.upkey)
global.downbutton = ord(obj_initialize.downkey)
global.leftbutton = ord(obj_initialize.leftkey)
global.rightbutton = ord(obj_initialize.rightkey)
}