//reset can_close
if submenu = "select"{
    can_close = true
}

var pos = "bottom"
if obj_mainchara.y > center.y{
    pos = "top"
}

//navigate submenu
if control{
    if submenu = "select" and selected < 2 and global.downbuttonpressed1{
        selected++
        scr_snd(snd_squeak)
    } else if submenu = "select" and selected > 0 and global.upbuttonpressed1{
        selected--
        scr_snd(snd_squeak)
    }  else if submenu = "item" and selected < array_length(global.inventory) - 1 and global.downbuttonpressed1{
        selected++
        scr_snd(snd_squeak)
    } else if submenu = "item" and selected > 0 and global.upbuttonpressed1{
        selected--
        scr_snd(snd_squeak)
    } else if submenu = "item_options" and selected < 2 and global.rightbuttonpressed1{
        selected++
        scr_snd(snd_squeak)
    } else if submenu = "item_options" and selected > 0 and global.leftbuttonpressed1{
        selected--
        scr_snd(snd_squeak)
    } else if submenu = "cell" and selected < array_length(global.contacts) - 1 and global.downbuttonpressed1{
        selected++
        scr_snd(snd_squeak)
    } else if submenu = "cell" and selected > 0 and global.upbuttonpressed1{
        selected--
        scr_snd(snd_squeak)
    }
    
    if submenu = "select" and selected = 0 and global.selectbuttonpressed{ //select to item
        submenu = "item"
        can_close = false
    } else if submenu = "item" and global.cancelbuttonpressed{ //item to select
        submenu = "select"
        selected = 0
    } else if submenu = "select" and selected = 1 and global.selectbuttonpressed{ //select to stat
        submenu = "stat"
        can_close = false
    } else if submenu = "stat" and global.cancelbuttonpressed{ //stat to select
        submenu = "select"
    } else if submenu = "select" and selected = 2 and global.selectbuttonpressed{ //select to cell
        submenu = "cell"
        selected = 0
        can_close = false
    } else if submenu = "cell" and global.cancelbuttonpressed{ //cell to select
        submenu = "select"
        selected = 2
    } else if submenu = "cell" and global.selectbuttonpressed{ //cell use
        scr_snd(snd_phone)
        scr_txtb(get_dia($"cell.{string(global.contacts[selected].id)}"), pos)
        submenu = "select"
        control = false
    } else if submenu = "item" and global.selectbuttonpressed{ //item to item options
        submenu = "item_options"
        selected_item = selected
        selected = 0
        can_close = false
    } else if submenu = "item_options" and global.cancelbuttonpressed{ //item options to item
        submenu = "item"
        selected = selected_item
    } else if submenu = "item_options" and selected = 0 and global.selectbuttonpressed{ //item options use
        if struct_exists(global.item.food, global.inv[selected_item]){ //food
            scr_eat(selected_item, global.stats.mainchara, pos)
            submenu = "select"
            control = false
        } else if struct_exists(global.item.weapon, global.inv[selected_item]){ //weapon
            scr_equip_weapon(selected_item, global.stats.mainchara, pos)
            scr_snd(snd_item)
            submenu = "select"
            control = false
        } else if struct_exists(global.item.armor, global.inv[selected_item]){ //armor
            scr_equip_armor(selected_item)
            scr_snd(snd_item)
            submenu = "select"
            control = false
        }
    } else if submenu = "item_options" and selected = 1 and global.selectbuttonpressed{ //item options info
        scr_txtb(global.inventory[selected_item].desc, pos)
        submenu = "select"
        control = false
    } else if submenu = "item_options" and selected = 2 and global.selectbuttonpressed{ //item options drop
        scr_item_delete(selected_item)
        close = true
    }
}

//update soul pos
if submenu = "select"{
    soul_x_left = box_left_x + x_off + 16
    soul_y_left = box_bot_y + y_off + 18 + (selected * 18)
    
    soul_x = soul_x_left
    soul_y = soul_y_left
} else if submenu = "item" or submenu = "cell"{
    soul_x_right = box_right_x + x_off + 12
    soul_y_right = box_top_y + y_off + 22 + (selected * 16)
    
    soul_x = soul_x_right
    soul_y = soul_y_right
} else if submenu = "item_options"{
    soul_x_bot = box_right_x + x_off + 14 + (selected * 50)
    if selected = 2{
       soul_x_bot = box_right_x + x_off + 24 + (selected * 50) 
    }
    soul_y_bot = box_top_y + y_off + 162
    
    soul_x = soul_x_bot
    soul_y = soul_y_bot
}

//destroy
if (global.cancelbuttonpressed and can_close and control or close) or (instance_exists(obj_txtb) and obj_txtb.do_destroy){
    obj_mainchara.can_move = true
    instance_destroy()
}