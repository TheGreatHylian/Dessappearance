draw_text_color(x, y-20, str1, c_white, c_white, c_white, c_white, 255) //lw norm

draw_text_color(x+jon, y+jonn, str1, c_dkgray, c_dkgray, c_navy, c_navy, 255) //dw norm
draw_text_color(x, y, str1, c_white, c_white, c_white, c_white, 255)

draw_text_color(x+0.5, y+20.5, str1, #4C4C00, #4C4C00, #4C4C00, #4C4C00, 255)//dw y
draw_text_color(x, y+20, str1, c_white, c_white, c_yellow, c_yellow, 255)

draw_text_color(x+0.5, y+40.5, str1, c_maroon, c_maroon, c_maroon, c_maroon, 255) //dw r
draw_text_color(x, y+40, str1, c_white, c_white, c_red, c_red, 255)

draw_text_color(x+0.5, y+60.5, str1, c_navy, c_navy, c_navy, c_navy, 255) //dw b
draw_text_color(x, y+60, str1, c_white, c_white, c_navy, c_navy, 255)

draw_text_color(x+0.5, y+80.5, str1, c_green, c_green, c_green, c_green, 255) //dw g
draw_text_color(x, y+80, str1, c_white, c_white, c_lime, c_lime, 255)

if keyboard_check_pressed(vk_end){
	jon -= 0.1
}
if keyboard_check_pressed(vk_home){
	jon += 0.1
}
if keyboard_check_pressed(vk_delete){
	jonn -= 0.1
}
if keyboard_check_pressed(vk_insert){
	jonn += 0.1
}
draw_text(x-40,y,jon)
draw_text(x-40,y+20,jonn)