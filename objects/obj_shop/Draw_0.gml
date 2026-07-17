draw_sprite(keeper.bg, keeper.bg_anim, center.x + keeper.bg_xoff, center.y - keeper.bg_yoff)
draw_sprite(keeper.sprite, anim, center.x - keeper.spr_xoff, center.y - keeper.spr_yoff)

draw_sprite(keeper.eyes, eye_frame, center.x - keeper.spr_xoff, center.y - keeper.spr_yoff - keeper.eye_off)
draw_sprite(keeper.mouth, mouth_frame, center.x - keeper.spr_xoff, center.y - keeper.spr_yoff - keeper.mouth_off)
if instance_exists(obj_txtb) and obj_txtb.shop_face != -1{
    draw_sprite(keeper.face, face_frame, center.x - keeper.spr_xoff, center.y - keeper.spr_yoff - keeper.face_off)
}

draw_set_font(keeper.fontsans)
draw_set_halign(fa_left)

if menu = "select"{
    
    draw_sprite_stretched(box, anim, 0, 120, 214, 121)
    draw_sprite_stretched(box, anim, 210, 120, 111, 121)
    
    draw_text(230, 210, string(global.stats.mainchara.money) + "G")
    draw_text(280, 210, string(array_length(global.inventory)) + "/8")
    
    
    draw_sprite(soul, anim, 229, 138 + (selected * 20))
    
    for(var i = 0; i < 4; i++){
        draw_text(240, 130 + (i * 20), options[i])
    }
    
}

if menu = "buy"{
    
    if percent < 1{
        percent += 1/30
    }
    pos = animcurve_channel_evaluate(curve, percent)
    info_y = info_bottom - (dist * pos)
    
    draw_sprite_stretched(box, anim, 210, info_y, 111, 85)
    
    if selected != array_length(stock){
        var item = stock[selected]
        var plus = get_txt("shop.plus")
        switch item.type{
        	case "armor":
                if item.stat - global.stats.mainchara.ar.df >= 0{
                    plus = get_txt("shop.plus")
                } else{
                    plus = ""
                }
                draw_text(224, info_y + 14, string_clean(get_txt("shop.armor"), [item.stat]))
                draw_text(224, info_y + 30, string_clean(get_txt("shop.armor_comp"), [plus, item.stat - global.stats.mainchara.ar.df]))
                draw_text(224, info_y + 46, string_clean(item.desc))
                break
            case "weapon":
                if item.stat - global.stats.mainchara.wp.at >= 0{
                    plus = "+"
                } else{
                    plus = ""
                }
                draw_text(224, info_y + 14, string_clean(get_txt("shop.weapon"), [item.stat]))
                draw_text(224, info_y + 30, string_clean(get_txt("shop.weapon_comp"), [plus, item.stat - global.stats.mainchara.wp.at]))
                draw_text(224, info_y + 46, string_clean(item.desc))
                break
            case "food":
                draw_text(224, info_y + 14, string_clean(get_txt("shop.food"), [item.stat]))
                draw_text(224, info_y + 30, string_clean(item.desc))
                break
        }
    }
    
    draw_sprite_stretched(box, anim, 0, 120, 214, 121)
    draw_sprite_stretched(box, anim, 210, 120, 111, 121)
    
    draw_set_font(keeper.fontsans)
    draw_text(230, 210, $"{global.stats.mainchara.money}{currency}")
    draw_text(280, 210, $"{array_length(global.inventory)}/8")
    
    for(var i = 0; i < array_length(stock); i++){
        draw_text(30, 130 + (i * 20), $"{stock[i].price}G - {stock[i].name}")
    }
    draw_text(30, 130 + (array_length(stock) * 20), get_txt("shop.exit"))
    if buy_flavor != "buying"{
        draw_sprite(soul, anim, 19, 138 + (selected * 20))
    } else{
        for(var i = 0; i < 2; i++){
            draw_text(240, 170 + (i * 20), yn[i])
        }
        draw_sprite(soul, anim, 229, 178 + (selected_yn * 20))
    }
    
    
}

if menu= "sell"{
    
    sellable = []
    for(var i = 0; i < array_length(global.inventory); i++){
        if !array_contains(no_sell, global.inventory[i]){
            array_resize(sellable, array_length(sellable) + 1)
            len = array_length(sellable) - 1
            sellable[len] = global.inventory[i]
            array_resize(link, array_length(sellable))
            link[len] = i
        }
    }
    
    if keeper.refuse_buy{
        draw_sprite_stretched(box, anim, 0, 120, 320, 120)
    } else if array_length(sellable) = 0 and !selling{
        draw_sprite_stretched(box, anim, 0, 120, 320, 120)
    } else{
        draw_sprite_stretched(box, anim, 0, 120, 320, 120)
        selling = true
        draw_text_color(240, 210, $"({global.stats.mainchara.money} {currency})", c_yellow, c_yellow, c_yellow, c_yellow, 1)
        draw_text(40, 210, get_txt("shop.exit"))
        
        for(var i = 0; i < 4; i++){
            for(var j = 0; j < 2; j++){
                var k = i + (j*4)
                if k < array_length(sellable){
                    var item_id = sellable[k].id
                    if variable_instance_exists(keeper.buy_prices, item_id){
                        var price = struct_get(keeper.buy_prices, item_id)
                        draw_text(40 + (j * 150), 130 + (i * 20), $"{price}{currency} - {sellable[k].name}")
                    } else{
                        draw_text(40 + (j * 150), 130 + (i * 20), $"0{currency} - {sellable[k].name}")
                    }
                }
            }
        }
        
        var high = 3
        if col = "right"{
            high = abs(5-array_length(sellable))
        } else if col = "left" and array_length(sellable) < 4{
            high = array_length(sellable) - 1
        }
        
        var ex_squeak = false
        if global.downbuttonpressed1 and selected = high and menu_timer <= 0{
            ex = true
            col = "left"
            ex_squeak = true
        } else if global.upbuttonpressed1 and ex and menu_timer <= 0{
            ex = false
            selected = 4
            ex_squeak = true
        }
        
        var sel = selected
        var old_col = col
        
        if global.downbuttonpressed1 and selected < 3{
            selected++
            menu_timer = 1
        } else if global.upbuttonpressed1 and selected > 0 and !ex{
            selected--
            menu_timer = 1
        } else if global.rightbuttonpressed1 and col = "left"  and !ex{
            col = "right"
            menu_timer = 1
        } else if global.leftbuttonpressed1 and col = "right"{
            col = "left"
            menu_timer = 1
        }
        
        if array_length(sellable) = 0{
            ex = true
        }
        
        if global.selectbuttonpressed and ex and menu_timer <= 0{
            menu = "select"
            menu_timer = 2
            selected = 1
            ex = false
            selling = false
        } else{
            
            while array_length(sellable) <= 4 and col = "right" and array_length(sellable) != 0{
                col = "left"
                sel = selected
            }
            while array_length(sellable) <= selected and col = "left" and array_length(sellable) != 0{
                selected--
                sel = selected
            }
            while selected + 4 >= array_length(sellable) and col = "right" and array_length(sellable) != 0{
                selected--
                sel = selected
            }
            
            var coloff = 0
            if col = "right"{
                coloff = 150
            }
            
            var ex_soul_h = 0
            if ex{
                ex_soul_h = 80 - (selected * 20)
            }
            
            if (sel != selected or ex_squeak or old_col != col) and !ex{
                scr_snd(snd_squeak)
            }
            draw_sprite(soul, anim, 26 + coloff, 140 + (selected * 20) + ex_soul_h)
        }
    }
}

if menu = "talk"{
    var opts = keeper.lines.talk_options
    
    draw_sprite_stretched(box, anim, 0, 120, 214, 121)
    draw_sprite_stretched(box, anim, 210, 120, 111, 121)
    
    draw_text(230, 210, string(global.stats.mainchara.money) + currency)
    draw_text(280, 210, string(array_length(global.inventory))+ "/8")
    
    for(var i = 0; i < array_length(opts); i++){
        var new_txt = ""
        if chat[i] != struct_get(keeper.lines, orig_chat[i]) and is_new[i] and i < array_length(opts){
            talk_col = c_yellow
            new_txt = get_txt("shop.new")
        } else{
        	talk_col = c_white
        }
        draw_text_color(30, 130 + (i * 20), opts[i] + new_txt, talk_col, talk_col, talk_col, talk_col, 1)
    }
    draw_text(30, 130 + (array_length(opts) * 20), get_txt("shop.exit"))
    draw_sprite(soul, anim, 19, 138 + (selected * 20))
}

if menu = "talking"{
    draw_sprite_stretched(box, anim, 0, 120, 320, 120)
}

if menu = "exit"{
    draw_sprite_stretched(box, anim, 0, 120, 320, 120)
}