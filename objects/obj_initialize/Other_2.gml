slots = []

if file_exists(global.json){
    save = scr_json_to_var()
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
    json = scr_json_to_var()
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
            name : "Susie Candy",
            name_short : "SusCandy",
            name_serious : "S. Candy",
            desc : "Susie-shaped candy. Looks ferocious!",
            
            heals : 100,
            heals_noelle : 1000
            
        },
        
        ralsei_candy : {
            
            id : "ralsei_candy",
            name : "Ralsei Candy",
            name_short : "RalCandy",
            name_serious : "R. Candy",
            desc : "Ralsei-shaped candy. Looks pretty!",
            
            heals : 80,
            cap
            
        },
        
        noelle_candy : {
            
            id : "noelle_candy",
            name : "Noelle Candy",
            name_short : "NolCandy",
            name_serious : "N. Candy",
            desc : "Noelle-shaped candy. Looks fluffy!",
            
            heals : 85,
            heals_sus : 140
            
        },
        
        kris_candy : {
            
            id : "kris_candy",
            name : "Kris Candy",
            name_short : "KrsCandy",
            name_serious : "K. Candy",
            desc : "Kris-shaped candy. Looks ...uncomfortable?",
            
            heals : 20,
            heals_sus : 90
            
        },
        
        bisicle : {
            
            id : "bisicle",
            name : "Bisicle",
            desc : "It's a two-pronged popsicle, so you can eat it twice.",
            
            heals : 11,
            
        },
        
         unisicle : {
            
            id : "unisicle",
            name : "Uniscicle",
            desc : "It's a two-pronged popsicle, so you can eat it twice.",
            
            heals : 11,
            
        },
        
        cinnamon_bun : {
            
            id : "cinnamon_bun",
            name : "Cinnamon Bun",
            name_short : "CinnaBun",
            name_serious : "C. Bun",
            desc : "A Cinnamon roll in a shape of a bunny.",
            
            heals : 22,
            
        },
        
        crab_apple : {
            
            id : "crab_apple",
            name : "Crab Apple",
            name_short : "CrabApple",
            desc : "An aquatic fruit that resembles a crustacean.",
            
            heals : 18
        },
        
        sea_tea : { //will give speed boost in battle tutorials
            
            id : "sea_tea",
            name : "Sea Tea",
            desc : "Made from glowing marshwater.",
            
            heals : 10
        }
        
    },
    
    weapon : { //weapons ----------------------------------------------------------------------------
        
        stick : {
            
            id : "stick",
            name : "Sharp Stick",
            name_short : "Stik",
            name_serious : "Stick",
            desc : "Just a really cool stick. Something about it tells you it's been though a lot...",
            
            at : 1,
            
        },
        
        hair_brush : {
            
            id : "hair_brush",
            name : "Hair Brush",
            name_short : "HairBrush",
            name_serious : "Brush",
            desc : "Susie's hair brush.",
            
            at : 3
            
        },
        
        tough_glove : {
            
            id : "tough_glove",
            name : "Tough Glove",
            name_short : "TuffGlove",
            name_serious : "Glove",
            desc : "A worn pink leather glove. For five-fingered folk.",
            
            at : 5
            
        }, torn_notebook : { //will give iframes in battle tutorials
            
            id : "torn_notebook",
            name : "Torn Notebook",
            name_short : "TornNotbo",
            name_serious : "Notebook",
            desc : "Contains illegible scrawls. Increases INV by 6.",
            
            at : 2
            
        }
        
    },
    
    armor : { //armor ----------------------------------------------------------------------------
        
        leaf : {
        
            id : "leaf",
            name : "Sad Leaf",
            name_serious : "Leaf",
            desc : "So bad it takes away defense.",
            
            df : -1
            
        },
        
        cowboy_hat : {
        
            id : "cowboy_hat",
            name : "Cowboy Hat",
            name_short : "CowHat",
            name_serious : "Hat",
            desc : "Jongler gave you their hat. It will protect you with its life.",
            
            at : 64,
            df : 53,
            magic : 6, //dw
            
            graze_bonus : 4
            
        },
        
        manly_bandanna : {
        
            id : "manly_bandanna",
            name : "Manly Bandanna",
            name_short : "Mandanna",
            name_serious : "Bandanna",
            desc : "It has seen some wear. It has abs drawn on it.",
            
            df : 7
            
        },
        
        cloudy_glasses : { //will give iframes in battle tutorial
        
            id : "cloudy_glasses",
            name : "Cloudy Glasses",
            name_short : "ClodGlass",
            name_serious : "Glasses",
            desc : "Glasses marred with wear. Increases INV by 9. (After you get hurt by an attack, you stay invulnerable for longer.)",
            
            df : 5
            
        }
        
    },
    
    key : { //key ----------------------------------------------------------------------------
        
        sap_card : {
            
            id : "sap_card",
            name : "Sap Card",
            desc : "A card given to you by Wing Gaster. Covered in Sap.",
            
            can_use : true
            
        },
        
        silver_key : { //copied from undertale
            
            id : "silver_key",
            name : "Silver Key",
            
            can_use : false
            
        },
        
        lancer : { //copied from deltarune
            
            id : "lancer",
            name : "Lancer",
            desc : "Hohoho! I'm a tough boy! Treat me like one of your ITEMS!", //"Welcome to my house. As you can see, I've knocked over many chairs because I get so tilted at the towers," Memphis welcomes his guests as he gestures with open arms. "This isn't really tilted or a tower... " Silver rudely interjects. "Well, you see, it's a gamer pad. Not many girls come in here ‘cause I get friendzoned so frequently. But that's okay," Memphis explains. Silver innocently responds, "I'd like to be in the friendzone. I'd like friends!" A pained look is cast on Memphis's face. "It's not as pleasant as you'd think." He steps closer towards the group, arms cautiously outstretched as if telling a campfire tale. "They don't treat you like a friend. They treat you like an item." Silver and Blaze share looks of concern and Memphis continues,“Sometimes I wish I could be more than just an accessory to these women, but unfortunately, as a gamer, I don't get respect.” Silver, still in denial, tells Memphis, “Well, I'm not a gamer, so maybe they'll respect me!” “That just makes you a beta cuck,” Memphis states. “That's the difference between you and I, Silver the Hedgehog. I'm a alpha gamer,” he rightfully proclaims. Memphis logs onto Fortnite. “Anyway... where we droppin', boys? These are all the new maps that they've added, and that's a newspaper.”     
            
            can_use : false
            
        }
        
    }
    
}

global.inventory = [global.item.food.cinnamon_bun, global.item.armor.leaf, global.item.food.crab_apple]

//cell -------------------------------------------------------------------------------------------------------------------------
global.cell = {
    
    toriel : { //toriel ----------------------------------------------------------------------------
        
        id : "toriel",
        name : "Call Home",
        text : "Hello, Kris!"
        
    },
    
    papyrus : {
        
        id : "papyrus",
        name : "Papyrus's Phone",
        text : "I, THE GREAT PAPYRUS, CHALLENGE YOU TO TRY GETTING BY US!"
        
    },
    
    sans : { //sans ----------------------------------------------------------------------------
        
        id : "sans",
        name : "Sans's Phone",
        text : "maybe it's the way you're dressed?"
        
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