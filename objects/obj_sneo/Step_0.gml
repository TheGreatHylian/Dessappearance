//anim test
if mode = 0{
	y = y + sin(timer*freq)*amp
}
if mode = 1{
	y = y + sin(timer*freq)*amp
	x = x + cos(timer*freq)*amp
}
if mode = 2{
	x = x + cos(timer*freq)*amp
}
if mode = 3{
	y = y + sin(timer*freq)*amp
	x = x + sin(timer*freq)*amp
}
if mode = 4{
	y = y - sin(timer*freq)*amp
	x = x + sin(timer*freq)*amp
}
timer++

if keyboard_check_pressed(vk_f5){
	mode = 0
}
if keyboard_check_pressed(vk_f6){
	mode = 1
}
if keyboard_check_pressed(vk_f7){
	mode = 2
}
if keyboard_check_pressed(vk_f8){
	mode = 3
}
if keyboard_check_pressed(vk_f9){
	mode = 4
}