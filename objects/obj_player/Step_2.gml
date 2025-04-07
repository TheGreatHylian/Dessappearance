if instance_exists(obj_kris){
	if  global.upbuttonpressed1 or global.downbuttonpressed1 or global.leftbuttonpressed1 or global.rightbuttonpressed1{
		obj_kris.image_index = 1
	}
}

if endpress = true{
	global.upbuttonpressed1 = false
	global.downbuttonpressed1 = false
	global.leftbuttonpressed1 = false
	global.rightbuttonpressed1 = false
	endpress = false
}