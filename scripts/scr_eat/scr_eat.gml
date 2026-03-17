function scr_eat(index, target = global.stats.mainchara){
    
    food = global.inventory[index]
    hp = target.hp
    hp_max = target.hp_max
    cap = true
    
    if hp > hp_max or struct_exists(food, "cap"){
        cap = false
    }
    
    hp += food.heals
    
    
    if hp > hp_max and cap{
        hp = hp_max
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
    
}