//slide on screen
if(y < 32){

	y += 1

}

//don't shake
x[0] = round(x[0.1])
y[0] = round(y[0.1])

if !instance_exists(obj_buttons) and !instance_exists(obj_buttons_continue){
	instance_create_depth(10, 67, 100, obj_buttons)
}