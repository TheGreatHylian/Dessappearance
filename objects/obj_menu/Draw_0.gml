//update the offset
x_off = center.topleft_x
y_off = center.topleft_y

if obj_mainchara.y > center.y{
    box_stats_mini_y = box_stats_bot
} else{
    box_stats_mini_y = box_stats_top
}

//top stats
draw_sprite_stretched(box, frame, box_left_x + x_off, box_stats_mini_y + y_off, box_left_w, box_stats_mini_h)

//reset font draw settings
draw_set_halign(fa_left)
draw_set_color(c_white)

draw_set_font(fnt_main_sans)
draw_text(box_left_x + x_off + 8, box_stats_mini_y + y_off + 5, name)

draw_set_font(fnt_small)
draw_text(box_left_x + x_off + 8, box_stats_mini_y + y_off + 22, get_txt("menu.lv_mini"))
draw_text(box_left_x + x_off + 26, box_stats_mini_y + y_off + 22, lv)

draw_text(box_left_x + x_off + 8, box_stats_mini_y + y_off + 31, get_txt("menu.hp_mini"))
draw_text(box_left_x + x_off + 26, box_stats_mini_y + y_off + 31, string(hp) + "/" + string(hp_max))

draw_text(box_left_x + x_off + 8, box_stats_mini_y + y_off + 40, get_txt("menu.g_mini"))
draw_text(box_left_x + x_off + 26 - money_off, box_stats_mini_y + y_off + 40, money)

//select
draw_sprite_stretched(box, frame, box_left_x + x_off, box_bot_y + y_off, box_left_w, box_select_h)

draw_set_font(fnt_main_sans)
draw_text_color(box_left_x + x_off + 26, box_bot_y + y_off + 10, get_txt("menu.item"), item_color, item_color, item_color, item_color, 1)
draw_text(box_left_x + x_off + 26, box_bot_y + y_off + 28, get_txt("menu.stat"))
if has_cell{
    draw_text_color(box_left_x + x_off + 26, box_bot_y + y_off + 46, get_txt("menu.cell"), cell_color, cell_color, cell_color, cell_color, 1)
}

//right box
if submenu = "item"{
    box_right_h = box_item_h
} else if submenu = "stat"{
    box_right_h = box_stats_h
} else if submenu = "cell"{
    box_right_h = box_cell_h
}

if submenu != "select"{
    draw_sprite_stretched(box, frame, box_right_x + x_off, box_top_y + y_off, box_right_w, box_right_h)
}

//item
if submenu = "item" or submenu = "item_options"{
    for(var i = 0; i < array_length(global.inventory); i++){
        draw_text(box_right_x + x_off + 22, box_top_y + y_off + 14 + (i * 16), global.inventory[i].name)
    }
    
    draw_text(box_right_x + x_off + 22, box_top_y + y_off + 154, get_txt("menu.use"))
    draw_text(box_right_x + x_off + 72, box_top_y + y_off + 154, get_txt("menu.info"))
    draw_text(box_right_x + x_off + 132, box_top_y + y_off + 154, get_txt("menu.drop"))
    
}

//stat
if submenu = "stat"{
    draw_text(box_right_x + x_off + 14, box_top_y + y_off + 16, "\"" + name + "\"")
    
    draw_text(box_right_x + x_off + 98, box_top_y + y_off + 16, comment)
    
    draw_text(box_right_x + x_off + 14, box_top_y + y_off + 46, get_txt("menu.lv") + string(lv))
    draw_text(box_right_x + x_off + 14, box_top_y + y_off + 62, get_txt("menu.hp") + string(hp) + " / " + string(hp_max))
    
    draw_text(box_right_x + x_off + 14, box_top_y + y_off + 94, get_txt("menu.at") + string(at) + " (" + string(weapon_at) + ")")
    draw_text(box_right_x + x_off + 14, box_top_y + y_off + 110, get_txt("menu.df") + string(df) + " (" + string(armor_df) + ")")
    
    draw_text(box_right_x + x_off + 98, box_top_y + y_off + 94, get_txt("menu.xp") + string(xp))
    draw_text(box_right_x + x_off + 98, box_top_y + y_off + 110, get_txt("menu.next") + string(next_lv))
    
    draw_text(box_right_x + x_off + 14, box_top_y + y_off + 140, get_txt("menu.wp") + string(wp.name))
    draw_text(box_right_x + x_off + 14, box_top_y + y_off + 156, get_txt("menu.ar") + string(ar.name))
    
    draw_text(box_right_x + x_off + 14, box_top_y + y_off + 176, get_txt("menu.g") + string(money))
    
}

//cell
if submenu = "cell"{
    for(var i = 0; i < array_length(global.contacts); i++){
        draw_text(box_right_x + x_off + 22, box_top_y + y_off + 14 + (i * 16), global.contacts[i].name)
    }
}

if submenu != "stat" and !instance_exists(obj_txtb){
    draw_sprite(soul, frame, soul_x, soul_y)
}