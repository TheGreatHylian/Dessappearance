slots = []

if file_exists(global.json){
    save = json_to_var()
    global.num_slots = save[0]
} else{
    global.num_slots = 1
}
if global.slot > global.num_slots{
    global.num_slots = global.slot
}
for(var i = 1; i <= global.num_slots; i++){
    slots[i] = {}
}

if file_exists(global.json){
    
    if array_length(save)-1 < array_length(slots){
        array_resize(save, array_length(save))
        for(var i = array_length(save); i < array_length(slots); i++){
            array_resize(save, array_length(save))
            save[i] = {}
        }
    }
    
    for(var i = 1; i <= global.num_slots; i++){
        slots[i] = save[i]
    }
    
    slot = slots[global.slot]
    
    if variable_struct_names_count(slot) > 0{
        global.new_game = false
        global.name = slot.mainchara.name
    	global.start_room = asset_get_index(slot.game.rm)
    	global.start_x = slot.mainchara.mainchara_x
    	global.start_y = slot.mainchara.mainchara_y
        global.facing = slot.mainchara.facing
        global.party_exists = bool(slot.party.exists)
        if global.party_exists{
    	   global.party_member_1 = asset_get_index(slot.party.party_arr[0])
    	   global.party_member_2 = asset_get_index(slot.party.party_arr[1])
        }
    	global.party_member_1_follow_distance = 40
    	global.party_member_2_follow_distance = 80
    }
    
}
global.slots = slots

if file_exists(global.json) and global.new_game = false{
    json = json_to_var()
    global.oldtime = json[global.slot].game.time
} else {
    global.oldtime = 0
}

//items -------------------------------------------------------------------------------------------------------------------------
cap = true

global.item = {
    
    food : { //food ----------------------------------------------------------------------------
        
        susie_candy : {
            
            id : "susie_candy",
            name : get_txt("item.food.susie_candy.name"),
            name_short : get_txt("item.food.susie_candy.name_short"),
            name_serious : get_txt("item.food.susie_candy.name_serious"),
            desc : get_txt("item.food.susie_candy.desc"),
            use : get_txt("item.food.susie_candy.use"),
            
            heals : 100,
            heals_noelle : 1000
            
        },
        
        ralsei_candy : {
            
            id : "ralsei_candy",
            name : get_txt("item.food.ralsei_candy.name"),
            name_short : get_txt("item.food.ralsei_candy.name_short"),
            name_serious : get_txt("item.food.ralsei_candy.name_serious"),
            desc : get_txt("item.food.ralsei_candy.desc"),
            use : get_txt("item.food.ralsei_candy.use"),
            
            heals : 80,
            cap
            
        },
        
        noelle_candy : {
            
            id : "noelle_candy",
            name : get_txt("item.food.noelle_candy.name"),
            name_short : get_txt("item.food.noelle_candy.name_short"),
            name_serious : get_txt("item.food.noelle_candy.name_serious"),
            desc : get_txt("item.food.noelle_candy.desc"),
            use : get_txt("item.food.noelle_candy.use"),
            
            heals : 85,
            heals_sus : 140
            
        },
        
        kris_candy : {
            
            id : "kris_candy",
            name : get_txt("item.food.kris_candy.name"),
            name_short : get_txt("item.food.kris_candy.name_short"),
            name_serious : get_txt("item.food.kris_candy.name_serious"),
            desc : get_txt("item.food.kris_candy.desc"),
            use : get_txt("item.food.kris_candy.use"),
            
            heals : 20,
            heals_sus : 90
            
        },
        
        bisicle : {
            
            id : "bisicle",
            name : get_txt("item.food.bisicle.name"),
            desc : get_txt("item.food.bisicle.desc"),
            use : get_txt("item.food.bisicle.use"),
            shop_desc : "Eat it twice!",
            
            heals : 11,
            
        },
        
         unisicle : {
            
            id : "unisicle",
            name : get_txt("item.food.unisicle.name"),
            desc : get_txt("item.food.unisicle.desc"),
            use : get_txt("item.food.unisicle.use"),
            
            heals : 11,
            
        },
        
        cinnamon_bun : {
            
            id : "cinnamon_bun",
            name : get_txt("item.food.cinnamon_bun.name"),
            name_short : get_txt("item.food.cinnamon_bun.name_short"),
            name_serious : get_txt("item.food.cinnamon_bun.name_serious"),
            desc : get_txt("item.food.cinnamon_bun.desc"),
            use : get_txt("item.food.cinnamon_bun.use"),
            shop_desc : "It's my own#recipe.",
            
            heals : 22,
            
        },
        
        crab_apple : {
            
            id : "crab_apple",
            name : get_txt("item.food.crab_apple.name"),
            name_short : get_txt("item.food.crab_apple.name_short"),
            desc : get_txt("item.food.crab_apple.desc"),
            use : get_txt("item.food.crab_apple.use"),
            shop_desc : "(Looks#like a#crab.)",
            
            heals : 18
        },
        
        sea_tea : { //will give speed boost in battle tutorials
            
            id : "sea_tea",
            name : get_txt("item.food.sea_tea.name"),
            desc : get_txt("item.food.sea_tea.desc"),
            use : get_txt("item.food.sea_tea.use"),
            shop_desc : "SPEED#up in#battle.",
            
            heals : 10
        }
        
    },
    
    weapon : { //weapons ----------------------------------------------------------------------------
        
        stick : {
            
            id : "stick",
            name : get_txt("item.weapon.stick.name"),
            name_short : get_txt("item.weapon.stick.name_short"),
            name_serious : get_txt("item.weapon.stick.name_serious"),
            desc : get_txt("item.weapon.stick.desc"),
            use : get_txt("item.weapon.stick.use"),
            
            at : 1,
            
        },
        
        hair_brush : {
            
            id : "hair_brush",
            name : get_txt("item.weapon.hair_brush.name"),
            name_short : get_txt("item.weapon.hair_brush.name_short"),
            name_serious : get_txt("item.weapon.hair_brush.name_serious"),
            desc : get_txt("item.weapon.hair_brush.desc"),
            use : get_txt("item.weapon.hair_brush.use"),
            
            at : 3
            
        },
        
        tough_glove : {
            
            id : "tough_glove",
            name : get_txt("item.weapon.tough_glove.name"),
            name_short : get_txt("item.weapon.tough_glove.name_short"),
            name_serious : get_txt("item.weapon.tough_glove.name_serious"),
            desc : get_txt("item.weapon.tough_glove.desc"),
            use : get_txt("item.weapon.tough_glove.use"),
            shop_desc : get_txt("item.weapon.tough_glove.shop_desc"),
            
            at : 5
            
        }, torn_notebook : { //will give iframes in battle tutorials
            
            id : "torn_notebook",
            name : get_txt("item.weapon.torn_notebook.name"),
            name_short : get_txt("item.weapon.torn_notebook.name_short"),
            name_serious : get_txt("item.weapon.torn_notebook.name_serious"),
            desc : get_txt("item.weapon.torn_notebook.desc"),
            use : get_txt("item.weapon.torn_notebook.use"),
            shop_desc : "Invincible#longer",
            
            at : 2
            
        }
        
    },
    
    armor : { //armor ----------------------------------------------------------------------------
        
        leaf : {
        
            id : "leaf",
            name : get_txt("item.armor.leaf.name"),
            name_serious : get_txt("item.armor.leaf.name_serious"),
            desc : get_txt("item.armor.leaf.desc"),
            use : get_txt("item.armor.leaf.use"),
            
            df : -1
            
        },
        
        cowboy_hat : {
        
            id : "cowboy_hat",
            name : get_txt("item.armor.cowboy_hat.name"),
            name_short : get_txt("item.armor.cowboy_hat.name_short"),
            name_serious : get_txt("item.armor.cowboy_hat.name_serious"),
            desc : get_txt("item.armor.cowboy_hat.desc"),
            use : get_txt("item.armor.cowboy_hat.use"),
            
            at : 64,
            df : 53,
            magic : 6, //dw
            
            graze_bonus : 4
            
        },
        
        manly_bandanna : {
        
            id : "manly_bandanna",
            name : get_txt("item.armor.manly_bandanna.name"),
            name_short : get_txt("item.armor.manly_bandanna.name_short"),
            name_serious : get_txt("item.armor.manly_bandanna.name_serious"),
            desc : get_txt("item.armor.manly_bandanna.desc"),
            use : get_txt("item.armor.manly_bandanna.use"),
            shop_desc : get_txt("item.armor.manly_bandanna.shop_desc"),
            
            df : 7
            
        },
        
        cloudy_glasses : { //will give iframes in battle tutorial
        
            id : "cloudy_glasses",
            name : get_txt("item.armor.cloudy_glasses.name"),
            name_short : get_txt("item.armor.cloudy_glasses.name_short"),
            name_serious : get_txt("item.armor.cloudy_glasses.name_serious"),
            desc : get_txt("item.armor.cloudy_glasses.desc"),
            use : get_txt("item.armor.cloudy_glasses.use"),
            shop_desc : "Invincible#longer",
            
            df : 5
            
        }
        
    },
    
    key : { //key ----------------------------------------------------------------------------
        
        sap_card : {
            
            id : "sap_card",
            name : get_txt("item.key.sap_card.name"),
            desc : get_txt("item.key.sap_card.desc"),
            use : get_txt("item.key.sap_card.use"),
            
            can_use : true
            
        },
        
        silver_key : { //copied from undertale
            
            id : "silver_key",
            name : get_txt("item.key.silver_key.name"),
            
            can_use : false
            
        },
        
        lancer : { //copied from deltarune
            
            id : "lancer",
            name : get_txt("item.key.lancer.name"),
            desc : get_txt("item.key.lancer.desc"), //"Welcome to my house. As you can see, I've knocked over many chairs because I get so tilted at the towers," Memphis welcomes his guests as he gestures with open arms. "This isn't really tilted or a tower... " Silver rudely interjects. "Well, you see, it's a gamer pad. Not many girls come in here ‘cause I get friendzoned so frequently. But that's okay," Memphis explains. Silver innocently responds, "I'd like to be in the friendzone. I'd like friends!" A pained look is cast on Memphis's face. "It's not as pleasant as you'd think." He steps closer towards the group, arms cautiously outstretched as if telling a campfire tale. "They don't treat you like a friend. They treat you like an item." Silver and Blaze share looks of concern and Memphis continues,“Sometimes I wish I could be more than just an accessory to these women, but unfortunately, as a gamer, I don't get respect.” Silver, still in denial, tells Memphis, “Well, I'm not a gamer, so maybe they'll respect me!” “That just makes you a beta cuck,” Memphis states. “That's the difference between you and I, Silver the Hedgehog. I'm a alpha gamer,” he rightfully proclaims. Memphis logs onto Fortnite. “Anyway... where we droppin', boys? These are all the new maps that they've added, and that's a newspaper.”     
            
            can_use : false
            
        }
        
    }
    
}

global.inventory = [global.item.food.cinnamon_bun, global.item.armor.leaf, global.item.food.crab_apple]

//cell -------------------------------------------------------------------------------------------------------------------------
global.cell = {
    
    toriel : { //toriel ----------------------------------------------------------------------------
        
        id : "toriel",
        name : get_txt("menu.cell_names.toriel"),
        text : get_txt("cell.toriel")
        
    },
    
    papyrus : {
        
        id : "papyrus",
        name : get_txt("menu.cell_names.papyrus"),
        text : get_txt("cell.papyrus")
        
    },
    
    sans : { //sans ----------------------------------------------------------------------------
        
        id : "sans",
        name : get_txt("menu.cell_names.sans"),
        text : get_txt("cell.sans")
        
    }
    
}

global.contacts = [global.cell.toriel, global.cell.papyrus]
scr_update_lists(true)

//stats -------------------------------------------------------------------------------------------------------------------------
global.stats = {
    
    mainchara : {
        
        name : global.name,
        hp : 20,
        hp_max : 20,
        at : 1,
        df : 2,
        mg : 0,
        wp : global.item.weapon.torn_notebook,
        ar : global.item.armor.cloudy_glasses,
        lv : 1,
        xp : 0,
        next_lv : 10,
        money : 0,
        spells : []
        
    },
    
    susie : {
        
        name : "Susie",
        hp : 30,
        hp_max : 30,
        at : 2,
        df : 3,
        mg : 0,
        wp : global.item.weapon.hair_brush,
        ar : global.item.armor.manly_bandanna,
        lv : 1,
        xp : 0,
        next_lv : 10,
        spells : []
        
    },
    
    toriel : { //toriel ----------------------------------------------------------------------------
        
        name : "Toriel",
        hp : 440,
        at : 6,
        df : 1,
        xp_gain : 0,
        money_gain : 0
        
    },
    
    papyrus : { //papyrus ----------------------------------------------------------------------------
        
        name : "Papyrus",
        hp : 680,
        at : 8,
        df : 2,
        xp_gain : 100,
        money_gain : 1
        
    },
    
    sans : { //sans ----------------------------------------------------------------------------
        
        name : "Sans",
        hp : 1,
        at : 1,
        df : 1,
        xp_gain : 0,
        money_gain : 0
        
    }
    
}

global.stats_dw = {
    
    mainchara : { //mainchara ----------------------------------------------------------------------------
        
        name : global.name,
        hp : 90,
        hp_max : 90,
        at : 10,
        df : 2,
        mg : 0,
        wp : global.item.weapon.torn_notebook,
        ar : global.item.armor.cloudy_glasses,
        lv : 1,
        xp : 0,
        next_lv : 10,
        money : 0,
        spells : []
        
    },
    
    susie : {
        
        name : "Susie",
        hp : 110,
        hp_max : 100,
        at : 14,
        df : 2,
        mg : 1,
        wp : global.item.weapon.hair_brush,
        ar : global.item.armor.manly_bandanna,
        lv : 1,
        xp : 0,
        next_lv : 10,
        spells : []
        
    }
    
}

if file_exists(global.json) and global.new_game = false{
    global.stats.mainchara.hp = slot.mainchara.hp
    global.stats.mainchara.hp_max = slot.mainchara.hp_max
    global.stats.mainchara.at = slot.mainchara.at
    global.stats.mainchara.df = slot.mainchara.df
    global.stats.mainchara.mg = slot.mainchara.mg
    global.stats.mainchara.wp = scr_equipable_id_convert(slot.mainchara.wp)
    global.stats.mainchara.ar = scr_equipable_id_convert(slot.mainchara.ar)
    global.stats.mainchara.lv = slot.mainchara.lv
    global.stats.mainchara.xp = slot.mainchara.xp
    global.stats.mainchara.money = slot.mainchara.money
    global.stats.mainchara.next_lv = 10 //will be calculated in later vid
    global.has_cell = slot.mainchara.cell
}

room_goto(rm_title)