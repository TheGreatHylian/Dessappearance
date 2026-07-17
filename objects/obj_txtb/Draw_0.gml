//box
draw_sprite_stretched(txtb_spr, txtb_frame, center.x + txtb_xpos - 144, center.y + txtb_ypos, txtb_w, txtb_h)

//portrait
if mouth and !txt_finished{
    if struct_exists(portrait_vals[page], $"p{portrait_index_vals[page]}"){
        draw_portrait_index = struct_get(portrait_vals[page], $"p{portrait_index_vals[page]}")
    }
    if struct_exists(dual_portrait_vals[page], $"p{dual_index_vals[page]}"){
        dual_portrait_index = struct_get(dual_portrait_vals[page], $"p{dual_index_vals[page]}")
    }
} else{
    draw_portrait_index = portrait_index_vals[page]
    dual_portrait_index = dual_index_vals[page]
}
portrait_off = 0
var drawing_portrait = ((page = 0 and start_timer[page][0] > 0) or (page > 0 and portrait_vals[page] = portrait_vals[page-1]) or (page > 0 and start_timer[page][0] > 0)) and do_portrait[page] and !do_destroy and portrait_switch_timer <= 1
if drawing_portrait{
    portrait_off = portrait_off_val
    
    var xoff = portrait_vals[page].x_off
    var yoff = portrait_vals[page].y_off
    if variable_struct_exists(portrait_vals[page], "x_off_" + txt_type){
        xoff = variable_struct_get(portrait_vals[page], "x_off_" + txt_type)
    }
    if variable_struct_exists(portrait_vals[page], "y_off_" + txt_type){
        yoff = variable_struct_get(portrait_vals[page], "y_off_" + txt_type)
    }
    
    draw_sprite(portrait_vals[page].spr, draw_portrait_index, center.x + txtb_xpos + xoff - 106, center.y + txtb_ypos + yoff + 40)
    
    if do_dual[page]{
        var xoff_dual = dual_portrait_vals[page].x_off
        var yoff_dual = dual_portrait_vals[page].y_off
        if variable_struct_exists(dual_portrait_vals[page], "x_off_" + txt_type){
            xoff_dual = variable_struct_get(dual_portrait_vals[page], "x_off_" + txt_type)
        }
        if variable_struct_exists(dual_portrait_vals[page], "y_off_" + txt_type){
            yoff_dual = variable_struct_get(dual_portrait_vals[page], "y_off_" + txt_type)
        }
        
        draw_sprite(dual_portrait_vals[page].spr, dual_portrait_index, center.x + txtb_xpos + xoff_dual + 110, center.y + txtb_ypos + yoff_dual + 40)
    }
}

//small portraits
if txt_finished and small_portrait_vals[page][is_true_index] and !do_destroy and portrait_switch_timer <= 1{
    var small_off = lerp(0, 8 * small_timer, 0.5)
    var small_alpha = 1 / small_timer
    if small_timer = 0{small_alpha = 1}
    var dw_small_off = 0
    if txt_type = "dark"{dw_small_off = 3}
    draw_sprite_ext(small_portrait_vals[page][1].spr, small_portrait_vals[page][2], center.x + txtb_xpos+ small_portrait_vals[page][4] + small_off, center.y + txtb_ypos + 56 + dw_small_off, 0.5, 0.5, 0, c_white, small_alpha)
    draw_text_ext_transformed_color(center.x + txtb_xpos + small_portrait_vals[page][4] + 20 + small_off, center.y + txtb_ypos + 49, string_clean(small_portrait_vals[page][3]), linebreak_dist_val, 10000, txt_scale / 2, txt_scale / 2, 0, c_white, c_white, c_white, c_white, small_alpha)
    draw_sprite_ext(small_portrait_vals[page][5].spr, small_portrait_vals[page][6], center.x + txtb_xpos+ small_portrait_vals[page][8] + small_off, center.y + txtb_ypos + 56 + dw_small_off, 0.5, 0.5, 0, c_white, small_alpha)
    draw_text_ext_transformed_color(center.x + txtb_xpos + small_portrait_vals[page][8] + 20 + small_off, center.y + txtb_ypos + 49, string_clean(small_portrait_vals[page][7]), linebreak_dist_val, 10000, txt_scale / 2, txt_scale / 2, 0, c_white, c_white, c_white, c_white, small_alpha)
}

//text
linebreak = 0
num_linebreak = 0
newline_off = 0
linebreak_dist_val = string_height("|") * txt_scale //from deltarune's code
if big_linebreak or (font = global.fontdefault and lang = "jp"){
    linebreak_dist_val = 18
}
if !do_destroy and portrait_switch_timer = 0{
    for(var l = 0; l <= line; l++){
        //draw asterisk true/false
        var star = true
        if !ast_draw[page][l]{
            star = false
        }
        ast_draw_col = ast_col[page][l]
        
        //font
        font = font_vals[page][l]
        draw_set_font(font)
        
        //linebreak stuffs
        var first_len = 0
        var is_break_line = false
        
        //chars
        for(var c = 0; c < char_arr[page][l]; c++){
            
            var font_info = font_get_info(font)
            var shift = 0
            var space = 0
            var char_info = font_info.glyphs[$ draw_txt[page][l][c]]
            var not_mono_off = 0
            var is_mono = true
            if !array_contains(mono_fonts, font) and !battle{ //normal non mono fonts
                for(var b = c; b > 0; b--){
                    char_info = font_info.glyphs[$ draw_txt[page][l][b]]
                    shift += char_info.shift - 1
                }
                char_info = font_info.glyphs[$ draw_txt[page][l][c]]
                shift -= char_info.shift - 1
                not_mono_off = 8
                if shop{not_mono_off = 6}
                space = c + shift + not_mono_off
                is_mono = false
            } else if !array_contains(mono_fonts, font) and battle{ //battle non mono fonts
                for(var b = c; b > 0; b--){
                    char_info = font_info.glyphs[$ draw_txt[page][l][b]]
                    shift += char_info.shift
                }
                char_info = font_info.glyphs[$ draw_txt[page][l][c]]
                shift -= char_info.shift
                not_mono_off = 8
                is_mono = false
                space = c + shift + not_mono_off
            } else{ //mono fonts
                shift = char_info.shift
                space = c * shift
                if font = global.font_comic_sans and lang = "jp"{
                    txt_scale = 0.25
                }
            }
            shift *= txt_scale
            space *= txt_scale
            
            //linebreak code
            if linebreak_indices[page][l][c]{
                linebreak += linebreak_dist_val
                num_linebreak++
                newline_off = c * shift
                if !is_mono{
                    newline_off = c + shift + not_mono_off
                }
                star = false
                first_len = c
                is_break_line = true
            }
            linebreak_dist = linebreak_dist_val * l + linebreak
            
            if !is_break_line{
                newline_off = 0
            }
            
            //cmd code -----------------------
            var real_c = c + num_linebreak
            if l > 0 and num_linebreak > 0{
                real_c -= num_linebreak
            }
            
            //shake
            if shake_vals[page][l][real_c][is_true_index] and last_shake_x = 0 and last_shake_y = 0{
                var freq_shake = shake_vals[page][l][real_c][spd_index]
                var amp_shake = shake_vals[page][l][real_c][amp_index]
                
                if irandom(freq_shake) = freq_shake{
                    shake_x = scr_shakeval(amp_shake)
                } else if irandom(freq_shake) = freq_shake{
                    shake_y = scr_shakeval(amp_shake)
                }
            } else{
                shake_x = 0
                shake_y = 0
            }
            
            last_shake_x = shake_x
            last_shake_y = shake_y
            
            //wave
            if wave_vals[page][l][real_c][is_true_index]{
                var spd_wave = wave_vals[page][l][real_c][spd_index]
                var amp_wave = wave_vals[page][l][real_c][amp_index]
                wave_y = sin((current_time * spd_wave) + real_c) * amp_wave
            } else{
                wave_y = 0
            }
            
            var effect_x_off = shake_x
            var effect_y_off = shake_y + wave_y
            
            //color
            txt_col = col_vals[page][l][real_c]
            grad_col = grad_vals[page][l][real_c]
            var char_grad = []
            for(var g = 0; g < 4; g++){
                char_grad[g] = txt_col
            }
            if is_grad[page][l][real_c]{
                char_grad = grad_col
            }
            
            //--------------------------------
            
            if portrait_vals[page] = portrait.papyrus{
                portrait_off = 46
                star = false
            }
            
            //asterisk
            if star{
                if txt_type = "light"{
                    draw_text_transformed_color(center.x - (txt_start_x + asterisk_off) + portrait_off, center.y + txt_start_y + linebreak_dist, asterisk, txt_scale, txt_scale, 0, ast_draw_col, ast_draw_col, ast_draw_col, ast_draw_col, 1)
                } else if txt_type = "dark" and ast_draw_col = c_white{
                    draw_text_transformed_color(center.x - (txt_start_x + asterisk_off - 0.5) + portrait_off, center.y + (txt_start_y + 0.5) + linebreak_dist, asterisk, txt_scale, txt_scale, txt_rot, c_dkgray, c_dkgray, c_navy, c_navy, txt_alpha)
                    draw_text_transformed_color(center.x - (txt_start_x + asterisk_off) + portrait_off, center.y + txt_start_y + linebreak_dist, asterisk, txt_scale, txt_scale, txt_rot, ast_draw_col, ast_draw_col, ast_draw_col, ast_draw_col, txt_alpha)
                } else if txt_type = "dark" and ast_draw_col != c_white{
                    draw_text_transformed_color(center.x - (txt_start_x + asterisk_off - 0.5) + portrait_off, center.y + (txt_start_y + 0.5) + linebreak_dist, asterisk, txt_scale, txt_scale, txt_rot, ast_draw_col, ast_draw_col, ast_draw_col, ast_draw_col, 0.3)
                    draw_text_transformed_color(center.x - (txt_start_x + asterisk_off) + portrait_off, center.y + txt_start_y + linebreak_dist, asterisk, txt_scale, txt_scale, txt_rot, c_white, c_white, ast_draw_col, ast_draw_col, txt_alpha)
                }
            }
            
            //the text
            if start_timer[page][l] > 1{
                if txt_type = "light"{
                    draw_text_transformed_color(center.x - txt_start_x + space - newline_off + portrait_off + effect_x_off, center.y + txt_start_y + linebreak_dist + effect_y_off, draw_txt[page][l][c], txt_scale, txt_scale, txt_rot, char_grad[0], char_grad[1], char_grad[2], char_grad[3], txt_alpha)
                } else if txt_type = "dark" and txt_col = c_white{
                    draw_text_transformed_color(center.x - (txt_start_x - 0.5) + space - newline_off + portrait_off + effect_x_off, center.y + (txt_start_y + 0.5) + linebreak_dist + effect_y_off, draw_txt[page][l][c], txt_scale, txt_scale, txt_rot, c_dkgray, c_dkgray, c_navy, c_navy, txt_alpha)
                    draw_text_transformed_color(center.x - txt_start_x + space - newline_off + portrait_off + effect_x_off, center.y + txt_start_y + linebreak_dist + effect_y_off, draw_txt[page][l][c], txt_scale, txt_scale, txt_rot, txt_col, txt_col, txt_col, txt_col, txt_alpha)
                } else if txt_type = "dark" and txt_col != c_white{
                    draw_text_transformed_color(center.x -(txt_start_x - 0.5) + space - newline_off + portrait_off + effect_x_off, center.y + (txt_start_y + 0.5) + linebreak_dist + effect_y_off, draw_txt[page][l][c], txt_scale, txt_scale, txt_rot, txt_col, txt_col, txt_col, txt_col, 0.3)
                    draw_text_transformed_color(center.x - txt_start_x + space - newline_off + portrait_off + effect_x_off, center.y + txt_start_y + linebreak_dist + effect_y_off, draw_txt[page][l][c], txt_scale, txt_scale, txt_rot, c_white, c_white, txt_col, txt_col, txt_alpha)
                }
                //glow
                if glow_vals[page][l][real_c][is_true_index]{
                    var glow = glow_vals[page][l][real_c]
                    draw_sprite_ext(spr_txtglow, -1, center.x - (txt_start_x - 4) + space - newline_off + portrait_off + effect_x_off, center.y + (txt_start_y + 10) + linebreak_dist + effect_y_off, 0.15 + glow[3], 0.08 + glow[4], 0, glow[1], glow[amp_index])
                    if (c < char-1 and c+1 < array_length(linebreak_indices[page][l]) and linebreak_indices[page][l][c+1]) or c+1 = array_length(linebreak_indices[page][l]) or c = char-1{
                        draw_sprite_ext(spr_txtglow, -1, center.x - (txt_start_x - 4) + space - newline_off + portrait_off + effect_x_off, center.y + (txt_start_y + 10) + linebreak_dist + effect_y_off, 0.15 + glow[3], 0.08 + glow[4], 0, glow[1], glow[amp_index])
                    }
                }
            }
            
        }
        
    }
    
    //text images
    var len = img_vals[page][15]
    for(var i = 0; i <= len; i++){
        img = img_vals[page][i][0]
        img_x = img_vals[page][i][1]
        img_y = img_vals[page][i][2]
        img_anim = img_vals[page][i][3]
        img_shake = img_vals[page][i][5]
        img_scale_x = img_vals[page][i][6]
        img_scale_y = img_vals[page][i][7]
        img_rot = img_vals[page][i][8]
        img_fps = img_frame_vals[i]
        
        if img_anim_delay_vals[i] <= 0{
            
            //anim
            var scale_anim = 1
            if img_anim != ac_none{
                img_anim = animcurve_get_channel(img_anim, "curve1")
                if img_anim_percent[i] < 0.55{
                    img_anim_percent[i] += 1/30
                } else{
                    img_anim_percent[i] = 1
                }
                img_anim_pos = animcurve_channel_evaluate(img_anim, img_anim_percent[i])
                scale_anim = img_anim_pos
            }
            
            //shake
            if img_shake and img_anim_percent[i] = 1{
                img_shake_x = scr_shakeval(1) / 2
                img_shake_y = scr_shakeval(1) / 2
            }
            
            //draw img
            draw_sprite_ext(img, img_fps, center.x - txt_start_x + img_x + img_shake_x, center.y + txt_start_y + img_y + img_shake_y, img_scale_x / scale_anim, img_scale_y / scale_anim, img_rot, c_white, 1)
            
        }
    }
    
}