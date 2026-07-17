lang = global.lang
langtxt = global.langtxt

//default values - https://www.youtube.com/watch?v=r0EQyR6aXt4
self[$ "dia"] ??= get_txt("dia.test.default_")
self[$ "txtb_loc"]  ??= "bottom"
self[$ "restore_move"] ??= true
self[$ "keep"] ??= false
self[$ "txtb_w"] ??= 289
self[$ "txtb_h"] ??= 76
self[$ "txtb_spr"] ??= spr_simplebox
self[$ "txtb_fps"] ??= 0
self[$ "txt_type"] ??= "light"
self[$ "txtb_xpos"] ??= 0
self[$ "txtb_ypos"] ??= 40
self[$ "txt_start_x"] ??= 114
self[$ "txt_start_y"] ??= 50
self[$ "big_linebreak"] ??= false
self[$ "shop"] ??= false
self[$ "locl_var"] ??= []
self[$ "can_control"] ??= true

txt_finished = false
txt_advance = false

char = 0
num_chars = string_length(dia[0][0])
char_arr = [[]]

line = 0
num_lines = array_length(dia[0])
linebreak = 0
num_linebreak = 0
linebreak_dist_val = string_height("|") //from deltarune's code
linebreak_dist = linebreak_dist_val
double_first = 0
newline_off = 0

page = 0
num_pages = array_length(dia)

txt_spd_val = 1
txt_spd = txt_spd_val
txt_col = c_white
txt_alpha = 1
font = global.fontdefault
mono_fonts = [fnt_main, fnt_main_jp, fnt_jp_comicsans]

asterisk = langtxt.sys.asterisk
start_timer = [[]]

txt_scale = 1
txt_rot = 0

if txtb_loc = "top"{
    txtb_ypos -= 155
    txt_start_y -= 155
}

voice_snds = {
    
    system : {
        snd : snd_txt,
        wait : 1
    },
    
    silent : {
        snd : snd_silent,
        wait : 0
    },
    
    susie : {
        snd : snd_txtsus,
        wait : 2
    },
    
    gerson : {
        snd : snd_txtger,
        wait : 3
    },
    
    asgore : {
        snd : snd_txtasg,
        wait : 2
    },
    
    noelle : {
        snd : snd_txtnoe,
        wait : 2
    },
    
    sans : {
        snd : snd_txtsans,
        wait : 2
    },
    
    tenna : {
        snd : snd_tv_voice_short,
        wait : 3
    },
    
    gaster : {
        snd : snd_wngdng1,
        wait : 3
    },
    
    mtt : {
        snd : snd_mtt1,
        wait : 3
    },
    
    temmie : {
        snd : snd_tem,
        wait : 2
    },
    
    papyrus : {
        snd : snd_txtpap,
        wait : 2
    }
    
}
voice = voice_snds.system
snd_timer = 0
no_snd = [" ", "^", "!", ".", "?", ",", ":", "/", "\\", "|", "*"] //from deltarune's code
dual_voice = voice
pitch = 1

portrait = {
    
    none : {
        x_off : 0,
        y_off : 0,
        spr : spr_none
    },
    
    susie : {
        x_off : 0,
        y_off : 0,
        spr : spr_face_sus_noeyes
    },
    
    asgore : {
        x_off : -4,
        y_off : -1,
        x_off_dark : 2,
        y_off_dark : -2,
        spr : spr_face_asgore,
        p0 : 1,
        p2 : 3,
        p4 : 5,
        p6 : 7,
        p8 : 9,
        p10 : 11
    },
    
    noelle : {
        x_off : 0,
        y_off : 0,
        spr : spr_face_noelle,
        p0 : 1,
        p2 : 3
    },
    
    sans : {
        x_off : 4,
        y_off : -5,
        spr : spr_face_sans
    },
    
    papyrus : {
        x_off : -5,
        y_off : 0,
        spr : spr_face_papyrus,
        p0 : 1,
        p2 : 3,
        p4 : 5,
        p6 : 7,
        p8 : 9,
        p10 : 11,
        p12 : 13,
        p14 : 15,
        p17 : 18
    }
    
}
portrait_index = 0
portrait_off_val = 57
portrait_off = 0
portrait_switch_timer = 0
portrait_switch_timer_max = 10
mouth = false
mouth_timer_max = 3
mouth_timer = mouth_timer_max
draw_portrait_index = portrait_index

dual_portrait_index = 0
dual_draw_portrait_index = dual_portrait_index

speaker = {
    
    system : {
        snd : voice_snds.system,
        do_portrait : false,
        portrait : portrait.none,
        font : global.fontdefault
    },
    
    silent : {
        snd : voice_snds.silent,
        do_portrait : false,
        portrait : portrait.none,
        font : global.fontdefault
    },
    
    susie : {
        snd : voice_snds.susie,
        do_portrait : true,
        portrait : portrait.susie,
        font : global.fontdefault
    },
    
    asgore : {
        snd : voice_snds.asgore,
        do_portrait : true,
        portrait : portrait.asgore,
        font : global.fontdefault
    },
    
    gerson : {
        snd : voice_snds.gerson,
        do_portrait : false,
        portrait : portrait.none,
        font : global.fontdefault
    },
    
    noelle : {
        snd : voice_snds.noelle,
        do_portrait : true,
        portrait : portrait.noelle,
        font : global.fontdefault
    },
    
    sans : {
        snd : voice_snds.sans,
        do_portrait : true,
        portrait : portrait.sans,
        font : global.font_comic_sans
    },
    
    tenna : {
        snd : voice_snds.tenna,
        do_portrait : false,
        portrait : portrait.none,
        font : global.fontdefault
    },
    
    papyrus : {
        snd : voice_snds.papyrus,
        do_portrait : true,
        portrait : portrait.papyrus,
        font : global.fontpapyrus
    }
    
}

spkr = speaker.system
portrait_index = 0
battle = false

txtb_fps = (1 / txtb_fps) / txtb_fps
txtb_frame = 0
txtb_loc_off = 0
asterisk_off = 16

do_skip = false
skip_timer_val = 4
skip_timer = skip_timer_val
do_destroy = false
destroy_timer = 1

if lang = "jp"{
    portrait_off_val = 50
    txt_start_x = 110
    txt_start_y = 51
    asterisk_off = 21
}

if !keep{
    obj_mainchara.can_move = false
}

//----------------------------------------------------------------------------------------

//create string sans commands
dia_clean = variable_clone(dia) //might not be needed

//dialogue commands
cmd_iden = "&"
negator = "^"
sep_iden = ","
in_sep_iden = "|"

col_iden = "c"
grad_iden = "GRAD"
col_dw_iden = "cd"
spkr_iden = "@"
voice_iden = "v"
dual_voice_iden = "dv"
pitch_iden = "~"
portrait_iden = "p"
portrait_struct = portrait.none
dual_portrait_iden = "dp"
dual_portrait_struct = portrait.none
small_portrait_iden1 = "sp1"
small_portrait_iden2 = "sp2"
effect_iden = "e"
font_iden = "f"
default_iden = "d"
none_iden = "n"
asterisk_mod_iden = "*"
img_iden = "i"
sfx_iden = "!"
glbl_var_iden = "g"
locl_var_iden = "l"
shop_face_iden = "sf"
auto_pause_iden = "ap"
choice_iden = "o"
small_choice_iden = "so"
yes_no_iden = "yn"

//effect tracker arrays
col_vals = [[[]]]
is_grad = [[[]]]
grad_vals = [[[[]]]]
grad_col = [c_white, c_white, c_white, c_white]
voice_vals = [[[]]]
pitch_vals = [[[]]]
portrait_vals = []
do_portrait = []
portrait_index_vals = []
font_vals = [[]]
shake_vals = [[[[]]]]
wave_vals = [[[[]]]]
speed_vals = [[[]]]
cut_vals = [[[]]]
wait_vals = [[[]]]
glitch_vals = [[[[]]]]
glow_vals = [[[[]]]]
dual_portrait_vals = []
do_dual = []
dual_index_vals = []
dual_voice_vals = [[[[]]]]
small_portrait_vals = [[]]
img_vals = []
sfx_vals = [[[]]]
shop_face_vals = [[]]

//asterisk tracker arrays
ast_draw = [[]]
ast_col = [[]]

//effect vars
spd_index = 0
amp_index = 1

shake_freq = 0
shake_amp = 0
shake_x = 0
shake_y = 0
last_shake_x = 0
last_shake_y = 0
doing_shake = false

wave_spd = 0
wave_amp = 0
wave_y = 0
doing_wave = false

cus_spd = txt_spd
do_cut = false
wait = 0

glow_col = c_white
glow_amp = 0
glow_xmod = 0
glow_ymod = 0
doing_glow = false

doing_grad = false
doing_portrait = false
doing_dual = false
doing_dual_voice = false

small_portrait1 = portrait.none
small_portrait2 = portrait.none
small_portrait_index1 = 0
small_portrait_index2 = 0
small_portrait_text1 = ""
small_portrait_text2 = ""
small_portrait_off1 = 0
small_portrait_off2 = 0
doing_small = false
small_timer_val = 5
small_timer = small_timer_val

img = spr_none
img_x = 0
img_y = 0
img_anim = ac_none
img_anim_percent = []
img_anim_pos = 0
img_anim_max = 1.2
img_anim_delay = 0
img_shake = false
img_shake_x = 0
img_shake_y = 0
img_scale_x = 1
img_scale_y = 1
img_rot = 0
img_page_id = 0
img_anim_delay_vals = []
img_fps = 0
img_frame_vals = []

sfx = snd_silent

glbl_var = ""
locl_var_index = 0

shop_face = -1

auto_pause = true
auto_pause_chars = [",", ".", "!", "?"]

//asterisk vars
draw_ast = true
ast_draw_col = c_white

for(var p = 0; p < num_pages; p++){
    num_lines = array_length(dia_clean[p])
    for(var l = 0; l < num_lines; l++){
        num_chars = string_length(dia_clean[p][l])
        for(var c = 0; c < num_chars; c++){
            if string_char_at(dia_clean[p][l], c+1) = cmd_iden and string_char_at(dia_clean[p][l], c) != negator{ //there is an & and no -
                
                var cmd = ""
                
                //clean the string of cmds
                for(var i = c; i < num_chars; i++){
                    cmd += string_char_at(dia_clean[p][l], i + 1)
                    if string_char_at(cmd, string_length(cmd)) = cmd_iden and i > c{
                        var dia_clean_after = string_copy(dia_clean[p][l], i+2, string_length(dia_clean[p][l])-i+1)
                        dia_clean[p][l] = string_copy(dia_clean[p][l], 1, c)
                        dia_clean[p][l] += dia_clean_after
                        break
                    }
                }
                
                //separate each cmd for easy access
                cmd = string_copy(cmd, 2, string_length(cmd)-2)
                var indie = string_split(cmd, ",")
                
                //actual cmd code
                for(var i = 0; i < array_length(indie); i++){
                    
                    //effects ------------------------------------------------------------------------------
                    if string_starts_with(indie[i], effect_iden){
                        indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                        var split = []
                        var effect = ""
                        var params = []
                        if indie[i] != none_iden and indie[i] != string_lower("cut"){
                            indie[i] = string_delete(indie[i], string_length(indie[i]), 1)
                            split = string_split(indie[i], "(")
                            effect = split[0]
                            effect = string_lower(effect)
                            params = string_split(split[1], in_sep_iden)
                            if effect != "glow"{
                                for(var w = 0; w < array_length(params); w++){
                                    params[w] = real(params[w])
                                }
                            }
                        } else{
                        	effect = indie[i]
                        }
                        
                        switch effect{
                            
                            case "shake":
                                shake_freq = params[spd_index] * 100
                                shake_amp = params[amp_index]
                                doing_shake = true
                                if shake_freq = 0 or wave_amp = 0{
                                    doing_wave = false
                                }
                                break
                            case "wave":
                                wave_spd = params[spd_index] / 100
                                wave_amp = params[amp_index]
                                doing_wave = true
                                if wave_spd = 0 or wave_amp = 0{
                                    doing_wave = false
                                }
                                break
                            case "speed":
                                cus_spd = params[spd_index]
                                break
                            case "cut":
                                do_cut = true
                                break
                            case "wait":
                                wait = params[spd_index]
                                break
                            case "glow":
                                glow_col = col_checker(params[0])
                                for(var w = 1; w < array_length(params); w++){
                                    params[w] = real(params[w])
                                }
                                glow_amp = params[amp_index] / 100
                                glow_xmod = params[2] / 100
                                glow_ymod = params[3] / 100
                                doing_glow = true
                                if glow_amp = 0{
                                    doing_glow = false
                                }
                                break
                            case none_iden:
                                doing_shake = false
                                doing_wave = false
                                cus_spd = 0
                                doing_glitch = false
                                doing_glow = false
                                break
                            
                        }
                        
                    } else {
                        
                        //color ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], col_iden){
                            
                            indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                            
                            //gradient - light world/undertale style only
                            if string_starts_with(indie[i], grad_iden){
                                indie[i] = string_delete(indie[i], string_length(indie[i]), 1)
                                indie[i] = string_copy(indie[i], 6, string_length(indie[i])-1)
                                var gradient = string_split(indie[i], in_sep_iden)
                                doing_grad = true
                                is_grad[p][l][c] = doing_grad
                                for(var g = 0; g < 4; g++){
                                    grad_col[g] = col_checker(gradient[g])
                                }
                            } else{
                                //not gradient
                                txt_col = col_checker(indie[i])
                                doing_grad = false
                            }
                            
                        } else
                        
                        //font ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], font_iden){
                            
                            indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                            if indie[i] = default_iden{
                                font = global.fontdefault
                            } else{
                                font = asset_get_index(indie[i])
                            }
                            
                        } else
                        
                        //voice ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], voice_iden){
                            
                            indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                            if indie[i] = default_iden{
                                voice = voice_snds.sys
                            } else if indie[i] = none_iden{
                                voice = voice_snds.silent
                            } else{
                                voice = struct_get(voice_snds, indie[i])
                            }
                        } else
                        
                        //pitch ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], pitch_iden){
                            
                            indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                            if indie[i] = default_iden{
                                pitch = 1
                            } else{
                                pitch = real(indie[i])
                            }
                        } else
                        
                        //img ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], img_iden){
                            
                            indie[i] = string_copy(indie[i], 4, string_length(indie[i])-1)
                            if indie[i] = none_iden{
                                img = spr_none
                            } else{ //&i:spr|x|y|anim|delay|shake|xscale|yscale|rot|fps&
                                var vars = string_split(indie[i], "|")
                                img = asset_get_index(vars[0])
                                img_x = real(vars[1])
                                img_y = real(vars[2])
                                img_anim = asset_get_index(vars[3])
                                img_anim_delay = real(vars[4])
                                img_shake = real(vars[5])
                                img_scale_x = real(vars[6])
                                img_scale_y = real(vars[7])
                                img_rot = real(vars[8])
                                img_fps = real(vars[9])
                                img_page_id++
                                if c = 0{img_page_id = 0}
                                
                            }
                        } else
                        
                        //sfx ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], sfx_iden){
                            
                            indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                            sfx = asset_get_index(indie[i])
                            
                        } else
                        
                        //portrait ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], portrait_iden){
                            
                            indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                            if string_upper(indie[i]) = string_lower(indie[i]) { //set expression with index
                                doing_portrait = true
                                portrait_index = indie[i]
                            } else if indie[i] = none_iden{ //no portrait
                                doing_portrait = false
                            } else{ //change to sprite
                                doing_portrait = true
                                portrait_index = 0
                                portrait_struct = struct_get(portrait, indie[i])
                            }
                            
                        } else
                        
                        //speaker ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], spkr_iden){
                            
                            indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                            if indie[i] = default_iden{
                                spkr = speaker.system
                                doing_portrait = false
                                voice = voice_snds.system
                                font = global.fontdefault
                            } else{
                                spkr = struct_get(speaker, indie[i])
                                doing_portrait = spkr.do_portrait
                                portrait_index = 0
                                portrait_struct = spkr.portrait
                                voice = spkr.snd
                                font = spkr.font
                                
                            }
                            
                        } else
                        
                        //dual portrait ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], dual_portrait_iden){
                            
                            indie[i] = string_copy(indie[i], 4, string_length(indie[i]))
                            if string_upper(indie[i]) = string_lower(indie[i]) { //set expression with index
                                doing_dual = true
                                dual_portrait_index = indie[i]
                            } else if indie[i] = none_iden{ //no portrait
                                doing_dual = false
                                doing_dual_voice = false
                            } else{ //change to sprite
                                doing_dual = true
                                dual_portrait_index = 0
                                dual_portrait_struct = struct_get(portrait, indie[i])
                            }
                            
                        } else
                        
                        //dual voice ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], dual_voice_iden){
                            
                            indie[i] = string_copy(indie[i], 4, string_length(indie[i]))
                            if indie[i] = default_iden{
                                doing_dual_voice = true
                                dual_voice = voice_snds.sys
                            } else if indie[i] = none_iden{
                                doing_dual_voice = false
                            } else{
                                doing_dual_voice = true
                                dual_voice = struct_get(voice_snds, indie[i])
                            }
                        } else
                        
                        //asterisk color
                        if string_starts_with(indie[i], asterisk_mod_iden + col_iden){
                            
                            indie[i] = string_copy(indie[i], 4, string_length(indie[i]))
                            ast_draw_col = col_checker(indie[i])
                            
                        } else
                        
                        //draw asterisk
                        if string_starts_with(indie[i], asterisk_mod_iden){
                            
                            indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                            draw_ast = bool(indie[i])
                            
                        } else
                        
                        //global vars
                        if string_starts_with(indie[i], glbl_var_iden){
                            
                            indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                            
                            glbl_var = string(variable_global_get(indie[i]))
                            num_chars += string_length(glbl_var)
                            dia_clean[p][l] = string_insert(glbl_var, dia_clean[p][l], c+1)
                            
                        } else
                        
                        //local vars
                        if string_starts_with(indie[i], locl_var_iden){
                            
                            indie[i] = string_copy(indie[i], 1, string_length(indie[i]))
                            
                            dia_clean[p][l] = string_insert(locl_var[locl_var_index], dia_clean[p][l], c+1)
                            num_chars += string_length(locl_var[locl_var_index])
                            locl_var_index++
                            
                        } else
                        
                        //shop face
                        if string_starts_with(indie[i], shop_face_iden){
                            
                            indie[i] = string_copy(indie[i], 4, string_length(indie[i]))
                            if indie[i] = none_iden{
                                shop_face = -1
                            } else{
                                shop_face = indie[i]
                            }
                            
                        } else
                        
                        //autopause
                        if string_starts_with(indie[i], auto_pause_iden){
                            
                            indie[i] = string_copy(indie[i], 4, string_length(indie[i]))
                            auto_pause = bool(indie[i])
                            
                        }
                        
                    }
                    
                    //small portraits ------------------------------------------------------------------------------
                        if string_starts_with(indie[i], small_portrait_iden1){ //first small portrait
                            
                            indie[i] = string_copy(indie[i], 6, string_length(indie[i]))
                            indie[i] = string_delete(indie[i], string_length(indie[i]), 1)
                            var params = string_split(indie[i], "|") //sp1(portrait|expression_index|text|offset)
                            if struct_exists(portrait, params[0]){
                                small_portrait1 = struct_get(portrait, params[0])
                                doing_small = true
                                small_portrait_index1 = real(params[1])
                                var text = params[2]
                                for(var s = 0; s < string_length(text); s++){ //have command and special  characters in text
                                    if string_char_at(text, s) = "$" and string_char_at(text, s + 1) = string_lower("c"){ // ,
                                        var text_start = string_copy(text, 1, s - 1)
                                        var text_end = string_copy(text, s + 2, string_length(text) - s)
                                        text = $"{text_start},{text_end}"
                                    } else if string_char_at(text, s) = "$" and string_char_at(text, s + 1) = string_lower("l"){ // |
                                        var text_start = string_copy(text, 1, s - 1)
                                        var text_end = string_copy(text, s + 2, string_length(text) - s)
                                        text = $"{text_start}|{text_end}"
                                    } else if string_char_at(text, s) = "$" and string_char_at(text, s + 1) = string_lower("a"){ // &
                                        var text_start = string_copy(text, 1, s - 1)
                                        var text_end = string_copy(text, s + 2, string_length(text) - s)
                                        text = $"{text_start}&{text_end}"
                                    } else if string_char_at(text, s) = "$" and string_char_at(text, s + 1) = string_lower("q"){ // "
                                        var text_start = string_copy(text, 1, s - 1)
                                        var text_end = string_copy(text, s + 2, string_length(text) - s)
                                        text = $"{text_start}\"{text_end}"
                                    }
                                }
                                small_portrait_text1 = text
                                
                                small_portrait_off1 = real(params[3])
                            } else if params[0] = none_iden{
                                doing_small = false
                                small_portrait1 = portrait.none
                                small_portrait_index1 = 0
                                small_portrait_text1 = ""
                            }
                            
                        } else if string_starts_with(indie[i], small_portrait_iden2){ //second small portrait
                            
                            indie[i] = string_copy(indie[i], 6, string_length(indie[i]))
                            indie[i] = string_delete(indie[i], string_length(indie[i]), 1)
                            var params = string_split(indie[i], "|") //sp1(portrait|expression_index|text|offset)
                            if struct_exists(portrait, params[0]){
                                small_portrait2 = struct_get(portrait, params[0])
                                doing_small = true
                                small_portrait_index2 = real(params[1])
                                var text = params[2]
                                for(var s = 0; s < string_length(text); s++){ //have command and special characters in text
                                    if string_char_at(text, s) = "$" and string_char_at(text, s + 1) = string_lower("c"){ //,
                                        var text_start = string_copy(text, 1, s - 1)
                                        var text_end = string_copy(text, s + 2, string_length(text) - s)
                                        text = $"{text_start},{text_end}"
                                    } else if string_char_at(text, s) = "$" and string_char_at(text, s + 1) = string_lower("l"){ //|
                                        var text_start = string_copy(text, 1, s - 1)
                                        var text_end = string_copy(text, s + 2, string_length(text) - s)
                                        text = $"{text_start}|{text_end}"
                                    } else if string_char_at(text, s) = "$" and string_char_at(text, s + 1) = string_lower("a"){ // &
                                        var text_start = string_copy(text, 1, s - 1)
                                        var text_end = string_copy(text, s + 2, string_length(text) - s)
                                        text = $"{text_start}&{text_end}"
                                    } else if string_char_at(text, s) = "$" and string_char_at(text, s + 1) = string_lower("q"){ // "
                                        var text_start = string_copy(text, 1, s - 1)
                                        var text_end = string_copy(text, s + 2, string_length(text) - s)
                                        text = $"{text_start}\"{text_end}"
                                    }
                                }
                                small_portrait_text2 = text
                                small_portrait_off2 = real(params[3])
                            } else if params[0] = none_iden{
                                small_portrait2 = portrait.none
                                small_portrait_index2 = 0
                                small_portrait_text2 = ""
                            }
                            
                        }
                    
                    shake_vals[p][l][c] = [doing_shake, shake_freq, shake_amp]
                    wave_vals[p][l][c] = [doing_wave, wave_spd, wave_amp]
                    speed_vals[p][l][c] = cus_spd
                    cut_vals[p][l][c] = do_cut
                    do_cut = false
                    wait_vals[p][l][c] = wait
                    wait = 0
                    glow_vals[p][l][c] = [doing_glow, glow_col, glow_amp, glow_xmod, glow_ymod]
                    
                    col_vals[p][l][c] = txt_col
                    grad_vals[p][l][c] = grad_col
                    
                    font_vals[p][l] = font
                    
                    voice_vals[p][l][c] = voice
                    pitch_vals[p][l][c] = pitch
                    
                    do_portrait[p] = doing_portrait
                    portrait_index_vals[p] = portrait_index
                    portrait_vals[p] = portrait_struct
                    
                    do_dual[p] = doing_dual
                    dual_index_vals[p] = dual_portrait_index
                    dual_portrait_vals[p] = dual_portrait_struct
                    dual_voice_vals[p][l][c] = [doing_dual_voice, dual_voice]
                    small_portrait_vals[p] = [doing_small, small_portrait1, small_portrait_index1, small_portrait_text1, small_portrait_off1, small_portrait2, small_portrait_index2, small_portrait_text2, small_portrait_off2]
                    img_vals[p][img_page_id] = [img, img_x, img_y, img_anim, img_anim_delay, img_shake, img_scale_x, img_scale_y, img_rot, img_fps]
                    sfx_vals[p][l][c] = sfx
                    sfx = snd_silent
                    
                    ast_draw[p][l] = draw_ast
                    ast_col[p][l] = ast_draw_col
                    
                    shop_face_vals[p][l] = shop_face
                    
                    var is_char = array_contains(auto_pause_chars, string_char_at(dia_clean[p][l], c))
                    if auto_pause and is_char and wait_vals[p][l][c] = 0{
                       wait_vals[p][l][c] = 6
                        var is_char_next = array_contains(auto_pause_chars, string_char_at(dia_clean[p][l], c+1))
                        if is_char and is_char_next{
                            wait_vals[p][l][c] = 0
                        }
                    }
                }
                
            } else{ //cmd fill arrays with right vals
                shake_vals[p][l][c] = [doing_shake, shake_freq, shake_amp]
                wave_vals[p][l][c] = [doing_wave, wave_spd, wave_amp]
                speed_vals[p][l][c] = cus_spd
                cut_vals[p][l][c] = do_cut
                wait_vals[p][l][c] = wait
                glow_vals[p][l][c] = [doing_glow, glow_col, glow_amp, glow_xmod, glow_ymod]
                col_vals[p][l][c] = txt_col
                is_grad[p][l][c] = doing_grad
                grad_vals[p][l][c] = grad_col
                font_vals[p][l] = font
                voice_vals[p][l][c] = voice
                pitch_vals[p][l][c] = pitch
                do_portrait[p] = doing_portrait
                portrait_index_vals[p] = portrait_index
                portrait_vals[p] = portrait_struct
                do_dual[p] = doing_dual
                dual_index_vals[p] = dual_portrait_index
                dual_portrait_vals[p] = dual_portrait_struct
                dual_voice_vals[p][l][c] = [doing_dual_voice, dual_voice]
                small_portrait_vals[p] = [doing_small, small_portrait1, small_portrait_index1, small_portrait_text1, small_portrait_off1, small_portrait2, small_portrait_index2, small_portrait_text2, small_portrait_off2]
                img_vals[p][img_page_id] = [img, img_x, img_y, img_anim, img_anim_delay, img_shake, img_scale_x, img_scale_y, img_rot, img_fps]
                sfx_vals[p][l][c] = sfx
                ast_draw[p][l] = draw_ast
                ast_col[p][l] = ast_draw_col
                shop_face_vals[p][l] = shop_face
                var is_char = array_contains(auto_pause_chars, string_char_at(dia_clean[p][l], c))
                if auto_pause and is_char and wait_vals[p][l][c] = 0{
                wait_vals[p][l][c] = 6
                    var is_char_next = array_contains(auto_pause_chars, string_char_at(dia_clean[p][l], c+1))
                    if is_char and is_char_next{
                        wait_vals[p][l][c] = 0
                    }
                }
            }
        }
    }
    img_vals[p][15] = img_page_id
}

var len = img_vals[page][15]
for(var i = 0; i <= len; i++){
    img_anim_delay_vals[i] = img_vals[page][i][4]
    img_anim_percent[i] = 0
    img_frame_vals[i] = 0
}

voice = voice_vals[page][line][char]

//update effect indexes for draw
is_true_index = 0
spd_index = 1
amp_index = 2

//line break
linebreak_iden = "#"
linebreak_indices = [[[]]]

for(var p = 0; p < num_pages; p++){
    num_lines = array_length(dia_clean[p])
    for(var l = 0; l < num_lines; l++){
        num_chars = string_length(dia_clean[p][l])
        for(var c = 0; c < num_chars; c++){
            if string_char_at(dia_clean[p][l], c+1) = linebreak_iden and string_char_at(dia_clean[p][l], c) != negator{
                linebreak_indices[p][l][c] = true
                var dia_clean_after = string_copy(dia_clean[p][l], c+2, string_length(dia_clean[p][l])-c)
                dia_clean[p][l] = string_copy(dia_clean[p][l], 1, c)
                dia_clean[p][l] += dia_clean_after
            }else if string_char_at(dia_clean[p][l], c) = negator{
                var dia_clean_after = string_copy(dia_clean[p][l], c+1, string_length(dia_clean[p][l])-c)
                dia_clean[p][l] = string_copy(dia_clean[p][l], 1, c-1)
                dia_clean[p][l] += dia_clean_after
                linebreak_indices[p][l][c] = false
            }else{
                linebreak_indices[p][l][c] = false
            }
        }
    }
}

draw_txt = [[[]]]

for(var p = 0; p < num_pages; p++){
    num_lines = array_length(dia_clean[p])
    for(var l = 0; l < num_lines; l++){
        num_chars = string_length(dia_clean[p][l])
        char_arr[p][l] = 0
        start_timer[p][l] = 0
        for(var c = 0; c < num_chars; c++){
            draw_txt[p][l][c] = string_char_at(dia_clean[p][l], c+1)
        }
    }
}