txt_advance = false

//typewritter effect
num_lines = array_length(draw_txt[page])
num_chars = array_length(draw_txt[page][line])

if portrait_switch_timer = 0{
    if start_timer[page][line] > 1{
        if char < num_chars and speed_vals[page][line][char] <= 0 and wait_vals[page][line][char] <= 0{
            char += txt_spd
            
            if char > num_chars{
                char = num_chars
            }
            char_arr[page][line] = char
            
            if char = num_chars and line != num_lines-1{
                line++
                char = 0
            } else if char = num_chars and line = num_lines-1{
                txt_finished = true
            }
            
            if char > 0 and char != num_chars and voice_vals[page][line][char-1] != voice_vals[page][line][char]{
                snd_timer = 0
            }
            if snd_timer <= 0 and (char > 0 and !array_contains(no_snd, draw_txt[page][line][char-1])){
                if char > 0{
                    voice = voice_vals[page][line][char-1]
                    pitch = pitch_vals[page][line][char-1]
                    dual_voice = dual_voice_vals[page][line][char-1][1]
                    if dual_voice_vals[page][line][char-1][is_true_index]{scr_txtsnd(dual_voice.snd)}
                } else{
                    voice = voice_vals[page][line][0]
                    pitch = pitch_vals[page][line][0]
                    dual_voice = dual_voice_vals[page][line][0][1]
                    if dual_voice_vals[page][line][0][is_true_index]{scr_txtsnd(dual_voice.snd)}
                }
                scr_txtsnd(voice.snd, pitch)
                snd_timer = voice.wait
            }
            if char > 0{
                scr_snd(sfx_vals[page][line][char-1])
            } else{
                scr_snd(sfx_vals[page][line][char])
            }
            
        }
        if char < num_chars{
            speed_vals[page][line][char]--
            wait_vals[page][line][char]--
        }
    }
    start_timer[page][line]++
    snd_timer--
}

if destroy_timer = 0{
    if restore_move{
        obj_mainchara.can_move = true
    }
    instance_destroy()
}

if do_destroy{
    destroy_timer--
    txt_advance = true
}

//controls
var len = img_vals[page][15]
if !txt_finished and (global.cancelbuttonpressed or keyboard_check(global.menubutton)) and can_control{
    do_skip = true
    skip_timer = skip_timer_val
    for(var i = 0; i <= len; i++){
        img_anim_delay_vals[i] = 0
        img_anim_percent[i] = 1
    }
}

if do_skip{
    char = num_chars - 1
}
if txt_finished{
	do_skip = false
}
skip_timer--

//img delay timer + animate
for(var i = 0; i <= len; i++){
    img_anim_delay_vals[i]--
    if img_anim_delay_vals[i] <= 0{
        if img_vals[page][i][9] < fps{
            img_frame_vals[i] += (1 / img_vals[page][i][9]) / img_vals[page][i][9]
        } else{
            img_frame_vals[i] += img_vals[page][i][9] / 30
        }
    }
}

var arrfix = true
if char >= array_length(wait_vals[page][line]){
    arrfix = false
}

if (txt_finished and page != num_pages-1 and (global.selectbuttonpressed or (keyboard_check(global.menubutton)) and skip_timer <= 0)) or (arrfix and cut_vals[page][line][char]) and can_control{
    page++
    line = 0
    char = 0
    txt_finished = false
    mouth_timer = mouth_timer_max
    small_timer = small_timer_val
    len = img_vals[page][15] + 1
    for(var i = 0; i < len; i++){
        img_anim_delay_vals[i] = img_vals[page][i][4]
        img_anim_percent[i] = 0
        img_frame_vals[i] = 0
    }
    txt_advance = true
} else if txt_finished and page = num_pages-1 and (global.selectbuttonpressed or (keyboard_check(global.menubutton)) and skip_timer <= 0) and can_control{
    do_destroy = true
}

//portrait switch timer
if page > 0 and portrait_vals[page] != portrait_vals[page-1] and start_timer[page][line] = 0{
    portrait_switch_timer++
}
if portrait_switch_timer = 10{
    portrait_switch_timer = -1
}

//mouth move timer code
if !txt_finished and mouth_timer = 0 and arrfix and wait_vals[page][line][char] <= 0{
    mouth = flip(mouth)
    mouth_timer = mouth_timer_max
} else if !txt_finished and arrfix and wait_vals[page][line][char] <= 0{
    mouth_timer--
}
if !txt_finished and arrfix and wait_vals[page][line][char] >= 0{
    mouth = false
    mouth_timer = 1
}
if txt_finished and mouth_timer != 0{
    mouth_timer--
}
if txt_finished and mouth_timer = 0{
    mouth = false
}

//small portraits timer
if txt_finished and small_timer != 0{
    small_timer--
} else if small_timer != 0{
    small_timer = small_timer_val
}

//txtb animate
txtb_frame += txtb_fps

//shop face
shop_face = shop_face_vals[page][line]