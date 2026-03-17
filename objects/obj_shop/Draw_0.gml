draw_sprite(keeper.bg, keeper.bg_anim, center.x + keeper.bg_xoff, center.y - keeper.bg_yoff)
draw_sprite(keeper.sprite, anim, center.x - keeper.spr_xoff, center.y - keeper.spr_yoff)

draw_set_font(keeper.fontsans)
draw_set_halign(fa_left)

if menu = "select"{
    
    draw_sprite_stretched(box, anim, 0, 120, 214, 121)
    draw_sprite_stretched(box, anim, 210, 120, 111, 121)
    
    if welcome = true{
        for(var i = 0; i < array_length(keeper.lines.intro); i++){
            draw_set_font(keeper.fontmono)
            draw_text(20, 130 + (i * 18), star)
            draw_text(36, 130 + (i * 18), keeper.lines.intro[i])
            draw_set_font(keeper.fontsans)
        }
    } else{
    	for(var i = 0; i < array_length(keeper.lines.random_flavor); i++){
            draw_set_font(keeper.fontmono)
            draw_text(20, 130 + (i * 18), star)
            draw_text(36, 130 + (i * 18), keeper.lines.random_flavor[i])
            draw_set_font(keeper.fontsans)
        }
    }
    
    draw_text(230, 210, string(global.stats.mainchara.money) + "G")
    draw_text(280, 210, string(array_length(global.inventory)) + "/8")
    
    if global.downbuttonpressed1 and selected < 3{
        selected++
        scr_snd(snd_squeak)
    } else if global.upbuttonpressed1 and selected > 0{
        selected--
        scr_snd(snd_squeak)
    }
    
    draw_sprite(soul, anim, 229, 138 + (selected * 20))
    
    for(var i = 0; i < 4; i++){
        draw_text(240, 130 + (i * 20), options[i])
    }
    
    if global.selectbuttonpressed{
        switch options[selected]{
        	case "Buy":
                menu = "buy"
                selected = 0
                welcome = false
                break
            
            case "Sell":
                menu = "sell"
                if !keeper.refuse_buy{
                    selected = 0
                    welcome = false
                }
                break
            
            case "Talk":
                menu = "talk"
                selected = 0
                welcome = false
                break
            
            case "Exit":
                menu = "exit"
                break
        }
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
        var plus = "+"
        switch item.type{
        	case "armor":
                if item.stat - global.stats.mainchara.ar.df >= 0{
                    plus = "+"
                } else{
                    plus = ""
                }
                draw_text(224, info_y + 14, $"Armor: {item.stat}DF")
                draw_text(224, info_y + 30, $"({plus}{item.stat - global.stats.mainchara.ar.df} DF)")
                draw_text(224, info_y + 46, item.desc)
                break
            case "weapon":
                if item.stat - global.stats.mainchara.wp.at >= 0{
                    plus = "+"
                } else{
                    plus = ""
                }
                draw_text(224, info_y + 14, $"Weapon: {item.stat}AT")
                draw_text(224, info_y + 30, $"({plus}{item.stat - global.stats.mainchara.wp.at} AT)")
                draw_text(224, info_y + 46, item.desc)
                break
            case "food":
                draw_text(224, info_y + 14, $"Heals: {item.stat}")
                draw_text(224, info_y + 30, item.desc)
                break
        }
    }
    
    draw_sprite_stretched(box, anim, 0, 120, 214, 121)
    draw_sprite_stretched(box, anim, 210, 120, 111, 121)
    
    draw_set_font(keeper.fontmono)
    switch buy_flavor{
        case "default":
            draw_text(230, 130, keeper.lines.buy)
            break
        case "broke":
            draw_text(230, 130, keeper.lines.broke)
            break
        case "thanks":
            draw_text(230, 130, keeper.lines.thanks)
            break
        case "full":
            draw_text(230, 130, keeper.lines.full)
            break
        case "buying":
            draw_set_font(keeper.fontsans)
            draw_text(230, 130, $"Buy it for\n{stock[selected].price}G ?")
            draw_set_font(keeper.fontmono)
            break
        case "looking":
            draw_text(230, 130, keeper.lines.looking)
            break
    }
    draw_set_font(keeper.fontsans)
    draw_text(230, 210, $"{global.stats.mainchara.money}G")
    draw_text(280, 210, $"{array_length(global.inventory)}/8")
    
    if buy_flavor != "buying"{
        if global.downbuttonpressed1 and selected < array_length(stock){
            selected++
            scr_snd(snd_squeak)
        } else if global.upbuttonpressed1 and selected > 0{
            selected--
            scr_snd(snd_squeak)
        }
    } else{
        if global.downbuttonpressed1 and selected_yn < 1{
            selected_yn++
            scr_snd(snd_squeak)
        } else if global.upbuttonpressed1 and selected_yn > 0{
            selected_yn--
            scr_snd(snd_squeak)
        }
    }
    
    for(var i = 0; i < array_length(stock); i++){
        draw_text(30, 130 + (i * 20), $"{stock[i].price}G - {stock[i].name}")
    }
    draw_text(30, 130 + (array_length(stock) * 20), "Exit")
    if buy_flavor != "buying"{
        draw_sprite(soul, anim, 19, 138 + (selected * 20))
    }
    
    if selected = array_length(stock){
        percent = 0
        if global.selectbuttonpressed{
            menu = "select"
            selected = 0
            menu_timer = 2
            buy_flavor = "default"
        }
    } else if menu_timer <= 0 and buy_flavor != "buying"{
        if global.selectbuttonpressed{
            buy_flavor = "buying"
            selected_yn = 0
            menu_timer = 1
        } else if global.cancelbuttonpressed{
            menu = "select"
            selected = 0
            menu_timer = 2
            buy_flavor = "default"
            percent = 0
        }
    }
    
    if buy_flavor = "buying"{
        for(var i = 0; i < 2; i++){
            draw_text(240, 170 + (i * 20), yn[i])
        }
        draw_sprite(soul, anim, 229, 178 + (selected_yn * 20))
        if yn[selected_yn] = "Yes" and global.selectbuttonpressed  and menu_timer <= 0{
            if global.stats.mainchara.money >= stock[selected].price and array_length(global.inventory) < 8{
                global.stats.mainchara.money -= stock[selected].price
                scr_item_add(stock[selected].item)
                scr_snd(snd_buyitem)
                buy_flavor = "thanks"
                menu_timer = 2
            } else if global.stats.mainchara.money < stock[selected].price{
                buy_flavor = "broke"
                menu_timer = 2
            } else if global.stats.mainchara.money >= stock[selected].price and array_length(global.inventory) >= 8{
                buy_flavor = "full"
                menu_timer = 2
            }
        } else if yn[selected_yn] = "No" and global.selectbuttonpressed{
            buy_flavor = "looking"
            menu_timer = 2
        }
    }
    if global.cancelbuttonpressed{
        buy_flavor = "looking"
        menu_timer = 2
    }
    menu_timer--
    
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
        var ref_lines = keeper.lines.refuse_buy
        for(var i = 0; i < array_length(ref_lines[page]); i++){
            draw_set_font(keeper.fontmono)
            draw_text(30, 130 + (i * 18), star)
            draw_text(46, 130 + (i * 18), ref_lines[page][i])
            draw_set_font(keeper.fontsans)
        }
        if global.selectbuttonpressed and menu_timer <= 0 and page < array_length(ref_lines) - 1{
            page++
            menu_timer = 2
        } else if global.selectbuttonpressed and menu_timer <= 0 and page = array_length(ref_lines) - 1{
            menu = "select"
            selected = 1
            menu_timer = 2
            page = 0
            ref_count++
            if variable_instance_exists(keeper.lines, "refuse_buy" + string(ref_count)){
                keeper.lines.refuse_buy = variable_instance_get(keeper.lines, "refuse_buy" + string(ref_count))
            }
        }
    } else if array_length(sellable) = 0 and !selling{
        draw_sprite_stretched(box, anim, 0, 120, 320, 120)
        for(var i = 0; i < array_length(keeper.lines.no_items); i++){
            draw_set_font(keeper.fontmono)
            draw_text(30, 130 + (i * 18), star)
            draw_text(46, 130 + (i * 18), keeper.lines.no_items[i])
            draw_set_font(keeper.fontsans)
            if global.selectbuttonpressed and menu_timer <= 0{
                menu = "select"
                menu_timer = 2
                selected = 1
            }
        }
    } else{
        draw_sprite_stretched(box, anim, 0, 120, 320, 120)
        selling = true
        draw_text_color(240, 210, $"({global.stats.mainchara.money} G)", c_yellow, c_yellow, c_yellow, c_yellow, 1)
        draw_text(40, 210, "Exit")
        
        for(var i = 0; i < 4; i++){
            for(var j = 0; j < 2; j++){
                var k = i + (j*4)
                if k < array_length(sellable){
                    var item_id = sellable[k].id
                    if variable_instance_exists(keeper.buy_prices, item_id){
                        var price = struct_get(keeper.buy_prices, item_id)
                        draw_text(40 + (j * 150), 130 + (i * 20), $"{price}G - {sellable[k].name}")
                    } else{
                        draw_text(40 + (j * 150), 130 + (i * 20), $"0G - {sellable[k].name}")
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
        
        if global.selectbuttonpressed and !ex and menu_timer <= 0 and array_length(sellable) > 0{
            var c = 0
            if col = "right"{c=4}
            var item_id = sellable[selected+c].id
            if variable_instance_exists(keeper.buy_prices, item_id){
                var price = struct_get(keeper.buy_prices, item_id)
                global.stats.mainchara.money += price
            }
            scr_item_delete(link[selected+c])
            scr_update_lists()
            scr_snd(snd_buyitem)
            menu_timer = 1
            sel = selected
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
    menu_timer--
}

if menu = "talk"{
    var opts = keeper.lines.talk_options
    draw_sprite_stretched(box, anim, 0, 120, 214, 121)
    draw_sprite_stretched(box, anim, 210, 120, 111, 121)
    
    draw_set_font(keeper.fontmono)
    draw_text(230, 130, keeper.lines.talk_flavor)
    draw_set_font(keeper.fontsans)
    draw_text(230, 210, string(global.stats.mainchara.money) + "G")
    draw_text(280, 210, string(array_length(global.inventory))+ "/8")
    
    if global.downbuttonpressed1 and selected < array_length(opts){
        selected++
        scr_snd(snd_squeak)
    } else if global.upbuttonpressed1 and selected > 0{
        selected--
        scr_snd(snd_squeak)
    }
    
    for(var i = 0; i < array_length(opts); i++){
        var new_txt = ""
        if chat[i] != struct_get(keeper.lines, orig_chat[i]) and is_new[i] and i < array_length(opts){
            talk_col = c_yellow
            new_txt = " (NEW)"
        } else{
        	talk_col = c_white
        }
        draw_text_color(30, 130 + (i * 20), opts[i] + new_txt, talk_col, talk_col, talk_col, talk_col, 1)
    }
    draw_text(30, 130 + (array_length(opts) * 20), "Exit")
    draw_sprite(soul, anim, 19, 138 + (selected * 20))
    
    if selected = array_length(opts){
        if global.selectbuttonpressed{
            menu = "select"
            selected = 2
            menu_timer = 2
        }
    } else if global.selectbuttonpressed and menu_timer <= 0{
        menu = "talking"
        menu_timer = 2
    } else if global.cancelbuttonpressed and menu_timer <= 0{
        menu = "select"
        selected = 2
        menu_timer = 2
    }
    menu_timer--
}

if menu = "talking"{
    draw_sprite_stretched(box, anim, 0, 120, 320, 120)
    var talk_lines = chat[selected]
    for(var i = 0; i < array_length(talk_lines[page]); i++){
        draw_set_font(keeper.fontmono)
        draw_text(30, 130 + (i * 18), star)
        draw_text(46, 130 + (i * 18), talk_lines[page][i])
        draw_set_font(keeper.fontsans)
    }
    if global.selectbuttonpressed and menu_timer <= 0 and page < array_length(talk_lines) - 1{
        page++
        menu_timer = 2
    } else if global.selectbuttonpressed and menu_timer <= 0 and page = array_length(talk_lines) - 1{
        menu = "talk"
        menu_timer = 2
        page = 0
        talk_count[selected] += 1
        var lines = keeper.lines
        var lines_names = variable_instance_get_names(lines)
        
        if array_contains(lines_names, orig_chat[selected] + string(talk_count[selected])){
            chat[selected] = struct_get(lines, orig_chat[selected] + string(talk_count[selected]))
            
        } else if array_contains(lines_names, new_chat[selected] + string(talk_count_new[selected])){
            chat[selected] = struct_get(lines, new_chat[selected] + string(talk_count_new[selected]))
            talk_count_new[selected] += 1
            
        } else if array_contains(lines_names, orig_chat[selected] + "_new") and talk_count_new[selected] = 1{
            chat[selected] = struct_get(lines, orig_chat[selected] + "_new")
            new_chat[selected] += "_new"
            talk_count_new[selected] += 1
            is_new[selected] = true
            keeper.lines.talk_options[selected] = struct_get(lines, new_chat[selected] + "_name")
            
        } else if array_contains(lines_names, new_chat[selected] + string(talk_count_new[selected]+1000)){
            chat[selected] = struct_get(lines, new_chat[selected] + string(talk_count_new[selected]+1000))
            talk_count_new[selected] += 1
            
        } else if array_contains(lines_names, new_chat[selected] + "_new"){
            chat[selected] = struct_get(lines, new_chat[selected] + "_new")
            new_chat[selected] += "_new"
            talk_count_new[selected] = -998
            is_new[selected] = true
            keeper.lines.talk_options[selected] = struct_get(lines, new_chat[selected] + "_name")
            
        } else if array_contains(lines_names, orig_chat[selected] + "_fin") and talk_count[selected] > 1{
            chat[selected] = struct_get(lines, orig_chat[selected] + "_fin")
            is_new[selected] = false
            
        }
    }
    menu_timer--
}

if menu = "exit"{
    draw_sprite_stretched(box, anim, 0, 120, 320, 120)
    for(var i = 0; i < array_length(keeper.lines.outro); i++){
        draw_set_font(keeper.fontmono)
        draw_text(30, 130 + (i * 18), star)
        draw_text(46, 130 + (i * 18), keeper.lines.outro[i])
    }
    
    if global.selectbuttonpressed and exit_timer <= 0{
        scr_warp(keeper.warp_rm, keeper.warp_x, keeper.warp_y, keeper.warp_facing)
    }
    exit_timer--
}