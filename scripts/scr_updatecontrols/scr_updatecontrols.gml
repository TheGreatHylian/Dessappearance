function scr_updatecontrols(){
if file_exists("controls.ini"){
	ini_open("controls.ini")
	obj_title.selectkey = ini_read_string("Save", "Select", "Z")
	obj_title.cancelkey = ini_read_string("Save", "Cancel", "X")
	obj_title.sprintkey = ini_read_string("Save", "Sprint", "X")
	obj_title.menukey = ini_read_string("Save", "Menu", "C")
	obj_title.upkey = ini_read_string("Save", "Up", "W")
	obj_title.downkey = ini_read_string("Save", "Down", "S")
	obj_title.leftkey = ini_read_string("Save", "Left", "A")
	obj_title.rightkey = ini_read_string("Save", "Right", "D")
}

global.selectbutton = ord(obj_title.selectkey)
global.cancelbutton = ord(obj_title.cancelkey)
global.sprintbutton = ord(obj_title.sprintkey)
global.menubutton = ord(obj_title.menukey)
global.upbutton = ord(obj_title.upkey)
global.downbutton = ord(obj_title.downkey)
global.leftbutton = ord(obj_title.leftkey)
global.rightbutton = ord(obj_title.rightkey)
}