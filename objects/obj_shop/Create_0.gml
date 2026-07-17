itm = global.item

items = {
    
    tough_glove : {
        
        name : itm.weapon.tough_glove.name,
        price : 25,
        type : "weapon",
        stat : itm.weapon.tough_glove.at,
        desc : itm.weapon.tough_glove.shop_desc,
        item : itm.weapon.tough_glove
        
    },
    
    tough_glove_2 : { //cheeper
        
        name : itm.weapon.tough_glove.name,
        price : 10,
        type : "weapon",
        stat : itm.weapon.tough_glove.at,
        desc : itm.weapon.tough_glove.shop_desc,
        item : itm.weapon.tough_glove
        
    },
    
    manly_bandanna : {
        
        name : itm.armor.manly_bandanna.name,
        price : 50,
        type : "armor",
        stat : itm.armor.manly_bandanna.df,
        desc : itm.armor.manly_bandanna.shop_desc,
        item : itm.armor.manly_bandanna
        
    },
    
    bisicle : {
        
        name : itm.food.bisicle.name,
        price : 15,
        type : "food",
        stat : string(itm.food.bisicle.heals) + "HP x2",
        desc : itm.food.bisicle.shop_desc,
        item : itm.food.bisicle
        
    },
    
    cinnamon_bun : {
        
        name : itm.food.cinnamon_bun.name,
        price : 25,
        type : "food",
        stat : itm.food.cinnamon_bun.heals,
        desc : itm.food.cinnamon_bun.shop_desc,
        item : itm.food.cinnamon_bun
        
    },
    
    crab_apple : {
        
        name : itm.food.crab_apple.name,
        price : 25,
        type : "food",
        stat : itm.food.crab_apple.heals,
        desc : itm.food.crab_apple.shop_desc,
        item : itm.food.crab_apple
        
    },
    
    sea_tea : {
        
        name : itm.food.sea_tea.name,
        price : 18,
        type : "food",
        stat : itm.food.sea_tea.heals,
        desc : itm.food.sea_tea.shop_desc,
        item : itm.food.sea_tea
        
    },
    
    cloudly_glasses : {
        
        name : itm.armor.cloudy_glasses.name,
        price : 30,
        type : "armor",
        stat : itm.armor.cloudy_glasses.df,
        desc : itm.armor.cloudy_glasses.shop_desc,
        item : itm.armor.cloudy_glasses
        
    },
    
    torn_notebook : {
        
        name : itm.weapon.torn_notebook.name,
        price : 55,
        type : "weapon",
        stat : itm.weapon.torn_notebook.at,
        desc : itm.weapon.torn_notebook.shop_desc,
        item : itm.weapon.torn_notebook
        
    }
    
}

qc = {
    
    sprite : spr_qc,
    face : spr_qc_face,
    eyes : spr_qc_eyes,
    mouth : spr_qc_mouth,
    spr_xoff : -1,
    spr_yoff : 56,
    
    face_off : 20,
    eye_off : 21,
    does_blink : true,
    blink_period : 240,
    blink_fps : 4,
    blink_frames : 4,
    mouth_off : 11,
    simple_mouth : true,
    
    bg : spr_shop_qc,
    bg_xoff : 0,
    bg_yoff : 60,
    bg_anim : -1,
    
    refuse_buy : true,
    buy_prices : {
        bisicle : 2,
        manly_bandanna : 4
    },
    
    fontsans : global.fontsans,
    fontmono : global.fontdefault,
    
    lines : {
        
        intro : get_dia("intro"),
        outro : get_dia("outro"),
        buy : get_dia("buy"),
        buying : get_dia("buying"),
        thanks : get_dia("thanks"),
        broke : get_dia("broke"),
        full : get_dia("full"),
        looking : get_dia("looking"),
        random_flavor : get_dia("random_flavor"),
        talk_flavor : get_dia("talk_flavor"),
        talk_options : get_dia("talk_options"),
        talk_one : get_dia("talk_one"),
        talk_one2 : get_dia("talk_one2"),
        talk_one_new_name : get_dia("talk_one_new_name"),
        talk_one_new : get_dia("talk_one_new"),
        talk_one_new2 : get_dia("talk_one_new2"),
        talk_one_new3 : get_dia("talk_one_new3"),
        talk_one_new_new_name : get_dia("talk_one_new_new_name"),
        talk_one_new_new : get_dia("talk_one_new_new"),
        talk_one_new_new2 : get_dia("talk_one_new_new2"),
        talk_one_fin : get_dia("talk_one_fin"),
        talk_two : get_dia("talk_two"),
        talk_three : get_dia("talk_three"),
        talk_four : get_dia("talk_four"),
        refuse_buy : get_dia("refuse_buy"),
        refuse_buy2 : get_dia("refuse_buy2"),
        no_items : get_dia("no_items")
        
    },
    
    warp_rm : rm_noelle_main,
    warp_x : 556,
    warp_y : 505,
    warp_facing : "down"
    
}

gerson = {
    
    sprite : spr_gerson_shop,
    face : noone,
    eyes : noone,
    mouth : noone,
    spr_xoff : 10,
    spr_yoff : 38,
    
    bg : spr_shop_gerson,
    bg_xoff : 0,
    bg_yoff : 60,
    bg_anim : -1,
    
    refuse_buy : true,
    buy_prices : {
    },
    
    fontsans : global.fontsans,
    fontmono : global.fontdefault,
    lines : {
        intro : [
            "Woah there!",
            "I've got some neat\njunk for sale."
        ],
        outro : [
            "Be careful out there, kid!"
        ],
        buy : "What are\nyou lookin\nfor?",
        thanks : "Thanks!\nWa ha ha.",
        broke : "You're\na bit\nshort\non cash.",
        full : "You're\ncarrying\ntoo much!",
        looking : "Careful\nwith that.",
        random_flavor : [
            "Don't be shy now."
        ],
        talk_flavor : "Anything\nyou\nwanna\nknow?",
        talk_options : [
            "About yourself",
            "That emblem",
            "The King",
            "About Undyne"
        ],
        talk_one : [
            [
                "I've been around a long time.",
                "Maybe too long."
            ],
            [
                "Studying history sure is\neasy when you've lived through\nso much of it yourself!",
                "Wa ha ha!"
            ]
        ],
        talk_two : [ //all talk must be 2d arrays
            [
                "Eh?",
                "You don't know what that is?"
            ],
            [
                "What are they teaching you\nkids in school nowadays...?",
                "Wa ha ha!"
            ],
            [
                "That's the Delta Rune, the emblem of our kingdom.",
                "The Kingdom..."
            ],
            [
                "... of Monsters."
            ],
            [
                "Wahaha!",
                "Great name, huh?",
                "It's as I always say..."
            ],
            [
                "Ol' King Fluffybuns can't name\nfor beans!"
            ]
        ],
        talk_two_new : [
            [
                "That emblem actually predates\nwritten history.",
                "The original meaning has been\nlost to time..."
            ],
            [
                "All we know is that the\ntriangles symbolize us monsters\nbelow, and the winged circle\nabove symbolizes..."
            ],
            [
                "Somethin' else."
            ],
            [
                "Most people say it's the 'angel,' from the prophecy..."
            ]
        ],
        talk_two_new_name : "Emblem's meaning",
        talk_two_new_new : [
            [
                "Oh yeah...",
                "The prophecy."
            ],
            [
                "Legend has it, an 'angel' who has\nseen the surface will descend\nfrom above and bring us freedom."
            ],
            [
                "Lately, the people have been\ntaking a bleaker outlook..."
            ],
            [
                "Callin' that winged circle the\n'Angel of Death.'"
            ],
            [
                "A harbinger of destruction,\nwaitin' to 'free' us from\nthis mortal realm..."
            ],
            [
                "In my opinion, when I see\nthat little circle..."
            ],
            [
                "I jus' think it looks neat!",
                "Wahaha!"
            ]
        ],
        talk_two_new_new_name : "The prophecy",
        talk_two_fin : [
            [
                "What's that?",
                "You want me to repeat myself?"
            ],
            [
                "Heck no!",
                "Your eyes still work...",
                "Go read a book or something!",
                "Wahaha!"
            ]
        ],
        talk_three : [
            [
                "King Fluffybuns?",
                "He's a friendly, happy-go-lucky\nkind of guy..."
            ],
            [
                "If you keep walking around long\nenough, you'll probably meet him.",
                "He loves to walk around and\ntalk to people."
            ],
            [
                "Eh?",
                "Why do I call Dreemurr\n'Fluffybuns?'",
                "Oh, that's a great story!"
            ],
            [
                "..."
            ],
            [
                "I don't remember it."
            ],
            [
                "But if you come back much\nlater, I'm sure I'll have\nremembered by then."
            ]
        ],
        talk_four : [
            [
                "Undyne?",
                "Yeah, she's a local hero\naround here."
            ],
            [
                "Through grit and determination\nalone, she fought her way to\nthe top of the Royal Guard."
            ],
            [
                "Actually, she just came through\nhere asking about someone who\nlooked just like you..."
            ],
            [
                "I'd watch your back, kid.",
                "And buy some items...",
                "It might just save your hide!",
                "Wa ha ha!"
            ]
        ],
        refuse_buy : [ //must be a 2d arrray
            [
                "Ha!",
                "I'm tryin' to get RID of\nmy junk, not get more of it!"
            ],
            [
                "Though, I've heard if you\nwant to sell stuff, the Temmie\nVillage is your best bet."
            ],
            [
                "Where is it?"
            ],
            [
                "I don't remember."
            ]
        ],
        refuse_buy2 : [
            [
                "For the last time, I'm not\ntaking it!"
            ]
        ],
        no_items : [
            "You don't have any items\nI can buy."
        ]
    },
    
    warp_rm : rm_noelle_main,
    warp_x : 380,
    warp_y : 505,
    warp_facing : "down"
    
}

scr_keeper()

switch keeper{
    
    case qc:
        stock = [
            items.tough_glove,
            items.manly_bandanna,
            items.bisicle,
            items.cinnamon_bun
        ]
        chat = [
            qc.lines.talk_one,
            qc.lines.talk_two,
            qc.lines.talk_three,
            qc.lines.talk_four
        ]
        break
    case gerson:
        stock = [
            items.crab_apple,
            items.sea_tea,
            items.cloudly_glasses,
            items.torn_notebook
        ]
        chat = [
            gerson.lines.talk_one,
            gerson.lines.talk_two,
            gerson.lines.talk_three,
            gerson.lines.talk_four
        ]
    
}

box = spr_simplebox_thick
anim = -1
blink_timer = keeper.blink_period
face_frame = 0
eye_frame = 0
mouth_frame = 0
style = "light"

currency = get_dia("currency")
star = "*"
options = [
    get_txt("shop.buy"),
    get_txt("shop.sell"),
    get_txt("shop.talk"),
    get_txt("shop.exit")
]
yn = get_txt("sys.yn")

orig_chat = []
var all_lines = struct_get_names(keeper.lines)
for(var i = 0; i < array_length(all_lines); i++){
    if array_contains(chat, variable_instance_get(keeper.lines, all_lines[i])){
        array_resize(orig_chat, array_length(orig_chat))
        orig_chat[i] = all_lines[i]
    }
}
for(var i = 0; i < array_length(orig_chat); i++){
    if orig_chat[i] = 0{
        array_delete(orig_chat, i, 1)
        i--
    }
}
new_chat = variable_clone(orig_chat)

menu = "select"
welcome = true
selected = 0
soul = spr_soul_menu
menu_timer = 1
page = 0
buy_flavor = "default"
selected_yn = 0

ref_count = 1
talk_count = [1, 1, 1, 1]
talk_count_new = [1, 1, 1, 1]
talk_col = c_white
is_new = [false, false, false, false]

no_sell = [global.item.armor.cowboy_hat, global.item.food.noelle_candy, global.item.key.lancer, global.item.key.sap_card, global.item.key.silver_key]
sellable = []
link = []
col = "left"
ex = false
selling = false

for(var i = 0; i < array_length(global.inventory); i++){
    if !array_contains(no_sell, global.inventory[i]){
        array_resize(sellable, array_length(sellable) + 1)
        len = array_length(sellable) - 1
        sellable[len] = global.inventory[i]
        array_resize(link, array_length(sellable))
        link[len] = i
    }
}

curve = animcurve_get_channel(ac_buy_popup, "curve1")
percent = 0
pos = animcurve_channel_evaluate(curve, percent)
info_top = 39
info_bottom = 123
dist = info_bottom - info_top
info_y = info_bottom - (dist * pos)

exit_timer = 1
obj_mainchara.can_move = false
obj_mainchara.y -= 50