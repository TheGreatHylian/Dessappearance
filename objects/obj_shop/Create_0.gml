items = {
    
    tough_glove : {
        
        name : "Tough Glove",
        price : 25,
        type : "weapon",
        stat : global.item.weapon.tough_glove.at,
        desc : "Slap 'em.",
        item : global.item.weapon.tough_glove
        
    },
    
    tough_glove_2 : { //cheeper
        
        name : "Tough Glove",
        price : 10,
        type : "weapon",
        stat : global.item.weapon.tough_glove.at,
        desc : "Slap 'em.",
        item : global.item.weapon.tough_glove
        
    },
    
    manly_bandanna : {
        
        name : "Manly Bandana",
        price : 50,
        type : "armor",
        stat : global.item.armor.manly_bandanna.df,
        desc : "It has abs\non it.",
        item : global.item.armor.manly_bandanna
        
    },
    
    bisicle : {
        
        name : "Bisicle",
        price : 15,
        type : "food",
        stat : string(global.item.food.bisicle.heals) + "HP x2",
        desc : "Eat it twice!",
        item : global.item.food.bisicle
        
    },
    
    cinnamon_bun : {
        
        name : "Cinnamon Bun",
        price : 25,
        type : "food",
        stat : global.item.food.cinnamon_bun.heals,
        desc : "It's my own\nrecipe.",
        item : global.item.food.cinnamon_bun
        
    },
    
    crab_apple : {
        
        name : "Crab Apple",
        price : 25,
        type : "food",
        stat : global.item.food.crab_apple.heals,
        desc : "(Looks\nlike a\ncrab.)",
        item : global.item.food.crab_apple
        
    },
    
    sea_tea : {
        
        name : "Sea Tea",
        price : 18,
        type : "food",
        stat : global.item.food.sea_tea.heals,
        desc : "SPEED\nup in\nbattle.",
        item : global.item.food.sea_tea
        
    },
    
    cloudly_glasses : {
        
        name : "Cloudly Glasses",
        price : 30,
        type : "armor",
        stat : global.item.armor.cloudy_glasses.df,
        desc : "Invincible\nlonger",
        item : global.item.armor.cloudy_glasses
        
    },
    
    torn_notebook : {
        
        name : "Torn Notebook",
        price : 55,
        type : "weapon",
        stat : global.item.weapon.torn_notebook.at,
        desc : "Invincible\nlonger",
        item : global.item.weapon.torn_notebook
        
    }
    
}

qc = {
    
    sprite : spr_qc,
    face : spr_qc_face,
    eyes : spr_qc_eyes,
    mouth : spr_qc_mouth,
    spr_xoff : -1,
    spr_yoff : 56,
    
    bg : spr_shop_qc,
    bg_xoff : 0,
    bg_yoff : 60,
    bg_anim : -1,
    
    refuse_buy : false,
    buy_prices : {
        bisicle : 2,
        manly_bandanna : 4
    },
    
    fontsans : global.fontsans,
    fontmono : global.fontdefault,
    
    lines : {
        
        intro : [
            "Hello, traveller.",
            "How can I help you?"
        ],
        outro : [
            "Bye now!",
            "Come again sometime!"
        ],
        buy : "What would\nyou like\nto buy?",
        thanks : "Thanks for\nyour\npurchase.",
        broke : "That's not\nenough\nmoney.",
        full : "You're\ncarrying\ntoo much.",
        looking : "Just\nlooking?",
        random_flavor : [
            "Take your time."
        ],
        talk_flavor : "Care to\nchat?",
        talk_options : [
            "Say hello",
            "What to do here",
            "Town history",
            "Your life"
        ],
        talk_hello : [ //all talk must be 2d arrays
            [
                "Hiya! Welcome to Snowdin!",
                "I can't remember the last\ntime I saw a fresh face around\nhere."
            ],
            [
                "Where did you come from?",
                "The capital?"
            ],
            [
                "You don't look like a tourist.",
                "Are you here by yourself?"
            ]
        ],
        talk_hello2 : [
            [
                "Something different!"
            ],
            [
                "It's crazy!!"
            ]
        ],
        talk_hello_new : [
            [
                "And now it's new!!",
                "And the text was yellow!!!"
            ]
        ],
        talk_hello_new_name : "Something New?",
        talk_hello_new2 : [
            [
                "It's new. It goes on more."
            ]
        ],
        talk_hello_new3 : [
            [
                "BUT WAIT! THERE'S MORE!!!!!"
            ]
        ],
        talk_hello_new_new : [
            [
                "dats right baeby.",
                "moer."
            ]
        ],
        talk_hello_new_new_name : "MORE????",
        talk_hello_new_new2 : [
            [
                "da moer...",
                "it neva edns......"
            ]
        ],
        talk_hello_fin : [
            [
                "nah, i was just messin with ya.",
                "it ova now."
            ]
        ],
        talk_whatdo : [
            [
                "You want to know what to do\nhere in Snowdin?"
            ],
            [
                "Grillby's has food, and the\nlibrary has information..."
            ],
            [
                "If you're tired, you can take\na nap at the inn.",
                "It's right next door - my sister runs it."
            ],
            [
                "And if you're bored, you can\nsit outside and watch those wacky\nskeleton brothers do their thing."
            ],
            [
                "There's two of 'em...",
                "Brothers, I think.",
                "They just showed up one day and...",
                "... asserted themselves."
            ],
            [
                "The town has gotten a lot\nmore interesting since then."
            ]
        ],
        talk_history : [
            [
                "Think back to your history\nclass..."
            ],
            [
                "A long time ago, monsters lived\nin the RUINS back there in\nthe forest."
            ],
            [
                "Long story short, we all decided\nto leave the ruins and head\nfor the end of the caverns."
            ],
            [
                "Along the way, some fuzzy folk\ndecided they liked the cold\nand set up camp in Snowdin."
            ],
            [
                "Oh, and don't think about\ntrying to explore the RUINS..."
            ],
            [
                "The door's been locked for ages.",
                "So unless you're a ghost\nor can burrow under the door,\nforget about it."
            ]
        ],
        talk_about : [
            [
                "Life is the same as usual."
            ],
            [
                "A little claustrophobic..."
            ],
            [
                "But... we all know deep down\nthat freedom is coming,\ndon't we?"
            ],
            [
                "As long as we got that hope, we\ncan grit our teeth and face the\nsame struggles, day after day..."
            ],
            [
                "That's life, ain't it?"
            ]
        ],
        refuse_buy : [ //must be a 2d arrray
            [
                "Huh?",
                "Sell somethin'?",
                "Does this look like a\npawn shop?"
            ],
            [
                "I don't know how it works where\nyou come from... but..."
            ],
            [
                "If I started spending money\non old branches and used\nbandages, I'd be out of business\nin a jiffy!"
            ]
        ],
        refuse_buy2 : [
            [
                "If you're really hurtin' for\ncash, then maybe you could\ndo some crowdfunding."
            ],
            [
                "I hear people will pay for\nANYTHING nowadays."
            ]
        ],
        no_items : [
            "You don't have any items\nI can buy."
        ]
        
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
            qc.lines.talk_hello,
            qc.lines.talk_whatdo,
            qc.lines.talk_history,
            qc.lines.talk_about
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

star = "*"
options = [
    "Buy",
    "Sell",
    "Talk",
    "Exit"
]
yn = [
    "Yes",
    "No"
]

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