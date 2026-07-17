function scr_eat(index, target = global.stats.mainchara, pos = "bottom"){
    
    food = global.inventory[index]
    hp = target.hp
    hp_max = target.hp_max
    cap = true
    healed = 0
    maxed = false
    
    if hp > hp_max or struct_exists(food, "cap"){
        cap = false
    }
    
    hp += food.heals
    healed += food.heals
    
    if hp > hp_max and cap{
        hp = hp_max
        maxed = true
    }
    
    target.hp = hp
    
    del = true
    
    if food = global.item.food.bisicle{
        global.inventory[index] = global.item.food.unisicle
        del = false
    }
    
    if del{
        scr_item_delete(index)
    }
    
    scr_update_lists()
    scr_snd(snd_swallow)
    instance_create_depth(x, y, depth, obj_heal_snd)
    
    if !maxed{
        scr_txtb(get_txt("menu.eat"), pos, [food.use, healed])
    } else if maxed and del{
        scr_txtb(get_txt("menu.eat_max"), pos, [food.use])
    }
    
}