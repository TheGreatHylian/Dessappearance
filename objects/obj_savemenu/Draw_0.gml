if saved = false{

draw_set_font(fnt_main_sans)
draw_sprite_stretched(spr_simplebox, -1, center.x - 106, center.y - 60, 212, 87)
draw_text(center.x - 90, center.y - 46, name)
draw_text(center.x - 10, center.y - 46, "LV" + string(lv))
draw_text(center.x + 50, center.y - 46, time)

draw_text(center.x - 90, center.y - 26, rm)

if selected = 0{
	draw_sprite(spr_heart_cursor, -1, center.x - 86, center.y + 6)
}
if selected = 1{
	draw_sprite(spr_heart_cursor, -1, center.x, center.y + 6)
}

draw_text(center.x - 76, center.y - 0.5, "Save")
draw_text(center.x + 10, center.y - 0.5, "Return")

} else{

draw_sprite_stretched_ext(spr_simplebox, -1, center.x - 106, center.y - 60, 212, 87, c_white, 1)
draw_text_color(center.x - 90, center.y - 46, name, c_yellow, c_yellow, c_yellow, c_yellow, 1)
draw_text_color(center.x - 10, center.y - 46, "LV" + string(lv), c_yellow, c_yellow, c_yellow, c_yellow, 1)
draw_text_color(center.x + 50, center.y - 46, time, c_yellow, c_yellow, c_yellow, c_yellow, 1)

draw_text_color(center.x - 90, center.y - 26, rm, c_yellow, c_yellow, c_yellow, c_yellow, 1)

draw_text_color(center.x - 76, center.y - 0.5, "Save", c_yellow, c_yellow, c_yellow, c_yellow, 1)
draw_text_color(center.x + 10, center.y - 0.5, "Return", c_yellow, c_yellow, c_yellow, c_yellow, 1)

}