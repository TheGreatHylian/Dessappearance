if menu = "select"{
    
    if !instance_exists(obj_txtb){
        if welcome = true{
            scr_txtb_none(keeper.lines.intro, 124, 10, style)
        } else{
        	scr_txtb_none(keeper.lines.random_flavor, 124, 10, style)
        }
    }
    
    if global.downbuttonpressed1 and selected < 3{
        selected++
        scr_snd(snd_squeak)
    } else if global.upbuttonpressed1 and selected > 0{
        selected--
        scr_snd(snd_squeak)
    }
    
    if global.selectbuttonpressed{
        switch selected{
        	case 0:
                menu = "buy"
                selected = 0
                welcome = false
                menu_timer = 2
                instance_destroy(obj_txtb)
                break
            
            case 2:
                menu = "sell"
                if !keeper.refuse_buy{
                    selected = 0
                    welcome = false
                }
                menu_timer = 2
                instance_destroy(obj_txtb)
                break
            
            case 3:
                menu = "talk"
                selected = 0
                welcome = false
                menu_timer = 2
                instance_destroy(obj_txtb)
                break
            
            case 4:
                menu = "exit"
                menu_timer = 2
                instance_destroy(obj_txtb)
                break
        }
    }
    
}

if menu = "buy"{
    
    if !instance_exists(obj_txtb){
        
        switch buy_flavor{
            case "default":
                scr_txtb_none(keeper.lines.buy, -70, 10, style)
                break
            case "broke":
                scr_txtb_none(keeper.lines.broke, -70, 10, style)
                break
            case "thanks":
                scr_txtb_none(keeper.lines.thanks, -70, 10, style)
                break
            case "full":
                scr_txtb_none(keeper.lines.full, -70, 10, style)
                break
            case "buying":
                scr_txtb_none(keeper.lines.buying, -70, 10, style, true, true, [stock[selected].price])
                break
            case "looking":
                scr_txtb_none(keeper.lines.looking, -70, 10, style)
                break
        }
        
    }
    
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
    
    if selected = array_length(stock){
        percent = 0
        if global.selectbuttonpressed{
            menu = "select"
            selected = 0
            menu_timer = 2
            buy_flavor = "default"
            instance_destroy(obj_txtb)
        }
    } else if menu_timer <= 0 and buy_flavor != "buying"{
        if global.selectbuttonpressed{
            buy_flavor = "buying"
            selected_yn = 0
            menu_timer = 1
            instance_destroy(obj_txtb)
        } else if global.cancelbuttonpressed{
            menu = "select"
            selected = 0
            menu_timer = 2
            buy_flavor = "default"
            percent = 0
            instance_destroy(obj_txtb)
        }
    }
    
    if buy_flavor = "buying"{
        for(var i = 0; i < 2; i++){
            draw_text(240, 170 + (i * 20), yn[i])
        }
        draw_sprite(soul, anim, 229, 178 + (selected_yn * 20))
        if yn[selected_yn] = get_txt("sys.y") and global.selectbuttonpressed and menu_timer <= 0{
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
            instance_destroy(obj_txtb)
        } else if yn[selected_yn] = get_txt("sys.n") and global.selectbuttonpressed{
            buy_flavor = "looking"
            menu_timer = 2
            instance_destroy(obj_txtb)
        }
    }
    if global.cancelbuttonpressed{
        buy_flavor = "looking"
        menu_timer = 2
        instance_destroy(obj_txtb)
    }
    
}

if menu = "sell"{
    
    if !instance_exists(obj_txtb){
        if keeper.refuse_buy{
            
            var ref_lines = keeper.lines.refuse_buy
            scr_txtb_none(ref_lines, 114, 10, style)
            
        } else if array_length(sellable) = 0 and !selling{
            
            var no_lines = keeper.lines.no_items
            scr_txtb_none(no_lines, 114, 10, style)
            
        }
    } else if obj_txtb.do_destroy{
        menu = "select"
        selected = 1
        menu_timer = 2
        ref_count++
        if variable_instance_exists(keeper.lines, "refuse_buy" + string(ref_count)){
            keeper.lines.refuse_buy = variable_instance_get(keeper.lines, "refuse_buy" + string(ref_count))
        }
        instance_destroy(obj_txtb)
    }
    
    if !keeper.refuse_buy and global.selectbuttonpressed and !ex and menu_timer <= 0 and array_length(sellable) > 0{
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
    }
    
}

if menu = "talk"{
    
    var opts = keeper.lines.talk_options
    
    if !instance_exists(obj_txtb){
        scr_txtb_none(keeper.lines.talk_flavor, -70, 10, style)
    }
    
    if global.downbuttonpressed1 and selected < array_length(opts){
        selected++
        scr_snd(snd_squeak)
    } else if global.upbuttonpressed1 and selected > 0{
        selected--
        scr_snd(snd_squeak)
    }
    
    if selected = array_length(opts){
        if global.selectbuttonpressed{
            menu = "select"
            selected = 2
            menu_timer = 2
            instance_destroy(obj_txtb)
        }
    } else if global.selectbuttonpressed and menu_timer <= 0{
        menu = "talking"
        menu_timer = 2
        instance_destroy(obj_txtb)
    } else if global.cancelbuttonpressed and menu_timer <= 0{
        menu = "select"
        selected = 2
        menu_timer = 2
        instance_destroy(obj_txtb)
    }
    
}

if menu = "talking"{
    
    var talk_lines = chat[selected]
    if !instance_exists(obj_txtb){
        scr_txtb_none(talk_lines, 114, 10, style)
    }
    
    if obj_txtb.do_destroy{
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
    
}

if menu = "exit"{
    if !instance_exists(obj_txtb){
        scr_txtb_none(keeper.lines.outro, 114, 10, style, true, true, [], false)
    }
    
    if global.selectbuttonpressed and exit_timer <= 0{
        scr_warp(keeper.warp_rm, keeper.warp_x, keeper.warp_y, keeper.warp_facing)
    }
    exit_timer--
}

menu_timer--

//blink animation
var blink = true
if instance_exists(obj_txtb) and obj_txtb.shop_face != -1{
    blink = false
}
if keeper.does_blink and blink{
    if blink_timer > 0{
        blink_timer--
    } else{
        eye_frame += 1 / keeper.blink_fps
        if eye_frame >= keeper.blink_frames{
            eye_frame = 0
            blink_timer = keeper.blink_period
        }
    }
}

//mouth anim
if keeper.simple_mouth{
    if instance_exists(obj_txtb) and obj_txtb.mouth{
        mouth_frame = 1
    } else{
        mouth_frame = 0
    }
}

//face expression
if !blink{
    face_frame = obj_txtb.shop_face
}