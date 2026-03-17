if activated{

if keyboard_check_pressed(selectbutton){
   selectbuttonpressed = true
} else{
   selectbuttonpressed = false
}
  
for(var i = 0; i < instance_count; i++){
    if !array_contains(selectable, instance_id[i]) and !array_contains(ignore, instance_id[i].object_index){
        array_resize(selectable, array_length(selectable))
        array_set(selectable, array_length(selectable), instance_id[i])
    }
}
if array_length(selectable) > 0{
    
    for(var i = 0; i < array_length(selectable); i++){
        if !instance_exists(selectable[i]){
            array_delete(selectable, i, 1)
            i--
        }
    }
    
    smallest = scr_debug_dist(selectable[0].object_index, mouse_x, mouse_y)
    for(var i = 0; i < array_length(selectable); i++){
        if scr_debug_dist(selectable[i], mouse_x, mouse_y) < smallest{
            smallest = scr_debug_dist(selectable[i], mouse_x, mouse_y)
           obj_nearest = selectable[i]
        }
    }
}
if array_contains(ignore, obj_nearest){
   obj_nearest = noone
}

if show_obj_bounds = true and instance_exists(obj) and instance_exists(obj_nearest){
    draw_rectangle_colour(obj_nearest.x-obj_nearest.sprite_width/2, obj_nearest.y-obj_nearest.sprite_height/2, obj_nearest.x+obj_nearest.sprite_width/2, obj_nearest.y+obj_nearest.sprite_height/2, db_col, db_col, db_col, db_col, true)
    draw_set_halign(fa_left)
    if lock = false{
       draw_text_color(center.topleft_x+20, center.topleft_y+20, string(object_get_name(obj_nearest.object_index)) + " (" + sprite_get_name(obj_nearest.sprite_index) + ")", db_col, db_col, db_col, db_col, 1)
    } else{
       draw_text_color(center.topleft_x+20, center.topleft_y+20, string(object_get_name(obj.object_index)) + " (" + sprite_get_name(obj.sprite_index) + ")", db_col, db_col, db_col, db_col, 1)
    }
} else if show_obj_bounds = true and (!instance_exists(obj) or !instance_exists(obj_nearest)){
   obj = obj_debug
   obj_nearest = obj_debug
   lock = false
}
if show_obj_bounds = true and keyboard_check_pressed(vk_lcontrol){
   show_obj_bounds = false
} else if keyboard_check_pressed(vk_lcontrol){
   show_obj_bounds = true
}

if mouse_check_button(mb_left) and lock = false and instance_exists(obj_nearest){
   obj = obj_nearest
   with obj{    
    x = mouse_x
    y = mouse_y
   }
} else if mouse_check_button(mb_left) and instance_exists(obj){
   with obj{
    x = mouse_x
    y = mouse_y
   }
}

if instance_exists(obj) and keyboard_check_pressed(vk_backspace) and obj != obj_debug.object_index{
    instance_destroy(obj)
}

if lock = true and keyboard_check_pressed(vk_alt){
    lock = false
} else if keyboard_check_pressed(vk_alt){
    obj = obj_nearest
    lock = true
}

if spawn = true{
    if keyboard_check_pressed(vk_divide) and selected > 0{
        selected--
    } else if keyboard_check_pressed(vk_multiply) and selected < total-1{
        selected++
    }
    for(var i = 0; i < total; i++){
        color = c_white
        if selected = i{
            color = db_col
            if object_get_sprite(asset_get_index(object_get_name(selected))) != -1{
                var spr = object_get_sprite(asset_get_index(object_get_name(selected)))
                draw_sprite_ext(spr, -1, center.topleft_x+200, center.topleft_y+20*i-selected*20+80, 1, 1, 0, spr_color, spr_alpha)
            }
        }
        draw_set_halign(fa_left)
        draw_text_color(center.topleft_x+200, center.topleft_y+20*i-selected*20+80, object_get_name(i), color, color, color, color, 1)
        color = c_white
        if selectbuttonpressed{
            obj_spawn = selected
        }
    }
    if selectbuttonpressed{
        obj_spawn_real = asset_get_index(object_get_name(obj_spawn))
        obj_spawn_real = instance_create_depth(center.x, center.y, depth, obj_spawn_real)
        array_resize(selectable, array_length(selectable))
        array_set(selectable, array_length(selectable), obj_spawn_real.id)
    }
    if keyboard_check_pressed(vk_add){
        spawn = false
    }
} else{
    if keyboard_check_pressed(vk_add){
        spawn = true
    }
}

if show_obj_bounds = true and instance_exists(obj_spawn_real){
    draw_rectangle_color(obj_spawn_real.x-obj_spawn_real.sprite_width/2, obj_spawn_real.y-obj_spawn_real.sprite_height/2, obj_spawn_real.x+obj_spawn_real.sprite_width/2, obj_spawn_real.y+obj_spawn_real.sprite_height/2, db_col, db_col, db_col, db_col, true)
    draw_set_halign(fa_left)
    draw_text_color(center.topleft_x+20, center.topleft_y+40, string(object_get_name(obj_spawn_real.object_index)) + " (" + sprite_get_name(obj_spawn_real.sprite_index) + ")", db_col, db_col, db_col, db_col, 1)
}
    
}

if keyboard_check_pressed(vk_rcontrol) and global.use_debug_switch and activated{
    activated = false    
} else if keyboard_check_pressed(vk_rcontrol) and global.use_debug_switch and !activated{
    activated = true
}

if debug_warning{
    show_debug_message(warning_message)
}