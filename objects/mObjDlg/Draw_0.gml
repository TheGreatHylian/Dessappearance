/// DRAW EVENT

if (box_visible) {
    draw_sprite_stretched(dialogue_sprite, dialogue_anim_frame, box_x, box_y, box_width, box_height);
}

draw_set_halign(fa_left);

w_padding    = (char_sprite != spr_none && char_visible) ? box_wrap_spr : box_wrap_none;
if (char_sprite != spr_none && char_visible) {
    var char_w_add = boff_char_w;
    var char_h_add = boff_char_h;
    var char_x_add = boff_char_x;
    var char_y_add = boff_char_y;

    for (var i = 0; i < array_length(parsed_text) && i < text_char_index; i++) {
        var el = parsed_text[i];
        if (el.type == "face_dim") {
            switch (el.dim) {
                case "w": char_w_add += el.add; break;
                case "h": char_h_add += el.add; break;
                case "x": char_x_add += el.add; break;
                case "y": char_y_add += el.add; break;
            }
        }
    }
	

    var char_w = base_char_w + char_w_add;
    var char_h = base_char_h + char_h_add;
    var char_x = box_x + base_char_xoff + char_x_add + base_char_w / 2;
    var char_y = box_y + box_height / 2 + char_y_add;

    draw_sprite_ext(char_sprite, char_anim_frame, char_x, char_y,
                    char_w / sprite_get_width(char_sprite),
                    char_h / sprite_get_height(char_sprite),
                    0, c_white, 1);

	w_padding = box_wrap_spr;
    text_x = box_x + text_x_spr_off + base_char_w
} else {
	w_padding = box_wrap_none;
    text_x = box_x + text_x_no_off;
}

wrap_w     = box_width + w_padding;

var dx = text_x, dy = text_y;
if (menu_active && dx != text_x) dx = text_x;
var whole_x=0, whole_y=0;
if(current_whole_shake_enabled) {
    if(last_whole_shake_frame != frame_counter) {
        whole_x = random_range(-current_whole_shake_offset, current_whole_shake_offset) * current_whole_shake_intensity;
        whole_y = random_range(-current_whole_shake_offset, current_whole_shake_offset) * current_whole_shake_intensity;
        last_whole_shake_frame = frame_counter;
    } else {
        whole_x = whole_shake_x;
        whole_y = whole_shake_y;
    }
}
whole_shake_x = whole_x;
whole_shake_y = whole_y;

var current_line_height = 12;
var reveal_i = 0, shown_visuals = 0;

for(var i=0; i<array_length(parsed_text) && i<text_char_index; i++){
    if(shown_visuals >= text_char_index) break;
    var el = parsed_text[i];

    if(el.type=="indent") {
        dx = text_x + el.width;
    }
    else if(el.type=="break") {
        dx = text_x;
        dy += current_line_height + 2;
    }
    else if(el.type=="char") {
        if(reveal_i >= array_length(reveal_frames)) break;
        draw_set_font(el.font);
        var scale = el.font_size/8;
        current_line_height = 8*2;
		
		var char_h = string_height(el.char) * scale;
		var center_off = (current_line_height - char_h) *0.5

        var shake_x=0, shake_y=0;
		if(el.shake_type=="letters") {
		    shake_x = random_range(-el.shake_offset, el.shake_offset) * el.shake_intensity;
		    shake_y = random_range(-el.shake_offset, el.shake_offset) * el.shake_intensity;
		} else if(el.shake_type=="whole") {
		    shake_x = whole_shake_x;
		    shake_y = whole_shake_y;
		}

        var eff_x=0, eff_y=0, eff_scale=1, eff_alpha=1;
        var local_t = frame_counter - reveal_frames[reveal_i];
        switch(el.effect){
            case "bounce": eff_y = sin(local_t*el.effect_speed)*el.effect_radius; break;
            case "orbit" : eff_x = cos(local_t*el.effect_speed)*el.effect_radius;
                            eff_y = sin(local_t*el.effect_speed)*el.effect_radius; break;
            case "explode": eff_scale = 1 + (1/max(1,local_t*el.effect_speed))*el.effect_radius; break;
            case "fadein": eff_alpha = clamp(local_t/el.effect_speed,0,1); break;
        }
		
        var fx = dx+el.xoff+shake_x+eff_x;
        var fy = dy+el.yoff+shake_y+eff_y+center_off;
		
		draw_set_alpha(eff_alpha)

		if el.hasshad == true {
	        // shadow mantle
	        draw_set_alpha(eff_alpha);
			if el.hshadow.enabled {
				draw_text_transformed_color(fx+0.5, fy+0.5, el.char, scale*eff_scale, scale*eff_scale, 0, el.hshadow.s1, el.hshadow.s1, el.hshadow.s2, el.hshadow.s2, eff_alpha)
			} else {
		        draw_set_color(el.shad_color);
		        draw_text_transformed(fx+0.5,fy+0.5,el.char,scale*eff_scale,scale*eff_scale,0);
			}
		}
		if el.hlight.enabled {
			// Thank you so much noelle for this
			draw_text_transformed_color(fx, fy, el.char, scale*eff_scale, scale*eff_scale, 0, el.hlight.h1, el.hlight.h1, el.hlight.h2, el.hlight.h2, eff_alpha)
		} else {
		    draw_set_color(el.color);
		    draw_text_transformed(fx,fy,el.char,scale*eff_scale,scale*eff_scale,0);
		}
		draw_set_alpha(1);

        reveal_i++; shown_visuals++;
        dx += string_width(el.char)*scale;
    }
    else if(el.type=="image"){
        if(reveal_i >= array_length(reveal_frames)) break;
        var shake_x=0, shake_y=0;
		if(el.shake_type=="letters") {
		    shake_x = random_range(-el.shake_offset, el.shake_offset) * el.shake_intensity;
		    shake_y = random_range(-el.shake_offset, el.shake_offset) * el.shake_intensity;
		} else if(el.shake_type=="whole") {
		    shake_x = whole_x;
		    shake_y = whole_y;
		}
        var eff_x=0, eff_y=0, eff_scale=1, eff_alpha=1;
        var local_t = frame_counter - reveal_frames[reveal_i];
        switch(el.effect){
            case "bounce": eff_y = sin(local_t*el.effect_speed)*el.effect_radius; break;
            case "orbit" : eff_x = cos(local_t*el.effect_speed)*el.effect_radius;
                            eff_y = sin(local_t*el.effect_speed)*el.effect_radius; break;
            case "explode": eff_scale = 1 + (1/max(1,local_t*el.effect_speed))*el.effect_radius; break;
            case "fadein": eff_alpha = clamp(local_t/el.effect_speed,0,1); break;
        }
        draw_set_alpha(eff_alpha);
        var dw = el.w * eff_scale, dh = el.h * eff_scale;
        var ix = dx + shake_x + eff_x;
        var iy = dy + shake_y + eff_y + (current_line_height - el.h)/2;
        if(el.sprite >= 0) {
            draw_sprite_stretched(el.sprite,0,ix+el.x,iy+el.y,dw,dh);
        }
        draw_set_alpha(1);
        reveal_i++; shown_visuals++;
        dx += 16 + 2;
    }
}


draw_set_alpha(1);
draw_set_color(c_white);

if (menu_active) {
    var region_left  = text_x;
    var region_right = box_x + box_width;
    var region_w     = region_right - region_left;
	
    draw_set_font(menu_font);
    draw_set_halign(fa_left);

    var n    = array_length(menu_options);
    var tws  = array_create(n, 0);
    var sumW = 0;
    for (var i = 0; i < n; i++) {
        var w = string_width(menu_options[i])
		if w > 80  {
			tws[i] = menu_wrap_width
		} else {
			tws[i] = w
		}
        sumW  += w;
    }

    var heart_scale = 1;
    var padding     = 2;
    var _heart_w    = sprite_get_width(spr_menu_heart) * heart_scale;

    var base_y = dy;
	if global.lang != "jp"{
		var V      = string_height("W")+8;
	} else{
		var V      = string_height("W")-46;
	}

	var step     = region_w / (n);
	if global.lang != "jp"{
		var center_x = region_left + region_w/2 - _heart_w
	} else{
		var center_x = region_left + region_w/2 - _heart_w + 8
	}

	var V_sep = string_height("W");

if (menu_selection < 0) {
    switch (n) {
        case 2: {
            var p2 = region_left + region_w/2 - _heart_w;
            draw_sprite_ext(spr_menu_heart, 0,
                            p2 - _heart_w/2, base_y+2,
                            heart_scale, heart_scale, 0, c_white, 1);
        } break;

        case 3: {
            var dx2 = center_x;
            draw_sprite_ext(spr_menu_heart, 0,
                            dx2-(_heart_w/2),
                            base_y+2,
                            heart_scale, heart_scale, 0, c_white, 1);
        } break;

        case 4: {
            var dx_t = center_x;
            draw_sprite_ext(spr_menu_heart, 0,
                            dx_t-(_heart_w/2),
                            base_y+2,
                            heart_scale, heart_scale, 0, c_white, 1);
        } break;

        default: {
			menu_selection = 0;
        } break;
    }


    draw_set_color(c_white);

    switch (n) {
        case 1: {
            var dx1 = center_x - tws[0]/2;
			draw_set_color(c_yellow)
			if global.lang != "jp"{
				draw_text_ext(dx1, base_y, menu_options[0], V_sep, menu_wrap_width)
			} else{
				draw_text_ext_transformed(dx1, base_y, menu_options[0], V_sep, menu_wrap_width, 25, 0.25, 0)
			}
        } break;
        case 2: {
            for (var i = 0; i < 2; i++) {
				var stepFix = i;
				if i == 0 {
					stepFix = -1;
				} else if i == 1 {
					stepFix = 1;
				}
                var dx2 = center_x + ((step/2)-_heart_w)*(stepFix) - tws[i]/2;
				if global.lang != "jp"{
					draw_text_ext(dx2, base_y, menu_options[i], V_sep, menu_wrap_width)
				} else{
					draw_text_ext_transformed(dx2, base_y, menu_options[i], V_sep, menu_wrap_width, 0.25, 0.25, 0)
				}
            }
        } break;
        case 3: {
            var dx_top = center_x - tws[1]/2;
			if global.lang != "jp"{
				draw_text_ext(dx_top, base_y - (V/2) - 2, menu_options[1], V_sep, menu_wrap_width)
	            var dx_bl  = center_x - step - tws[0]/2;
				draw_text_ext(dx_bl, base_y, menu_options[0], V_sep, menu_wrap_width)
	            var dx_br  = center_x + step - tws[2]/2;
				draw_text_ext(dx_br, base_y, menu_options[2], V_sep, menu_wrap_width)
			} else{
				draw_text_ext_transformed(dx_top, base_y - (V/2) - 2, menu_options[1], V_sep, menu_wrap_width, 0.25, 0.25, 0)
	            var dx_bl  = center_x - step - tws[0]/2;
				draw_text_ext_transformed(dx_bl, base_y, menu_options[0], V_sep, menu_wrap_width, 0.25, 0.25, 0)
	            var dx_br  = center_x + step - tws[2]/2;
				draw_text_ext_transformed(dx_br, base_y, menu_options[2], V_sep, menu_wrap_width, 0.25, 0.25, 0)
			}
        } break;
        case 4: {
			if global.lang != "jp"{
	            var dx_t = center_x - tws[1]/2;
				draw_text_ext(dx_t, base_y - V, menu_options[1], V_sep, menu_wrap_width)
	            var dx_l = center_x - step - tws[0]/2;
				draw_text_ext(dx_l, base_y, menu_options[0], V_sep, menu_wrap_width)
	            var dx_r = center_x + step - tws[2]/2;
				draw_text_ext(dx_r, base_y, menu_options[2], V_sep, menu_wrap_width)
	            var dx_b = center_x - tws[3]/2;
				draw_text_ext(dx_b, base_y + V, menu_options[3], V_sep, menu_wrap_width)
			} else{
				var dx_t = center_x - tws[1]/2;
				draw_text_ext_transformed(dx_t, base_y - V, menu_options[1], V_sep, menu_wrap_width, 0.25, 0.25, 0)
	            var dx_l = center_x - step - tws[0]/2;
				draw_text_ext_transformed(dx_l, base_y, menu_options[0], V_sep, menu_wrap_width, 0.25, 0.25, 0)
	            var dx_r = center_x + step - tws[2]/2;
				draw_text_ext_transformed(dx_r, base_y, menu_options[2], V_sep, menu_wrap_width, 0.25, 0.25, 0)
	            var dx_b = center_x - tws[3]/2;
				draw_text_ext_transformed(dx_b, base_y + V, menu_options[3], V_sep, menu_wrap_width, 0.25, 0.25, 0)
			}
        } break;
        default: {
            for (var i = 0; i < n; i++) {
                var dxn = region_left + step*(i+1) - tws[i]/2;
				if global.lang != "jp"{
					draw_text_ext(dxn, base_y, menu_options[i], V_sep, menu_wrap_width)
				} else{
					draw_text_ext_transformed(dxn, base_y, menu_options[i], V_sep, menu_wrap_width, 0.25, 0.25, 0)
				}
            }
        } break;
    }

} else {
    switch (n) {
        case 1: {
            var dx1 = center_x - tws[0]/2;
            if (0 == menu_selection) {
                var hx = dx1 - _heart_w - padding;
                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y+2) + heart_yoff,
                                heart_scale, heart_scale, 0, c_white, 1);
                draw_set_color(c_yellow);
            } else draw_set_color(c_white);
			if global.lang != "jp"{
				draw_text_ext(dx1, base_y, menu_options[0], V_sep, menu_wrap_width)
			} else{
				draw_text_ext_transformed(dx1, base_y, menu_options[0], V_sep, menu_wrap_width, 0.25, 0.25, 0)
			}
        } break;

        case 2: for (var i = 0; i < 2; i++) {
				var stepFix = i;
				if i == 0 {
					stepFix = -1;
				} else if i == 1 {
					stepFix = 1;
				}
                var dx2 = center_x + ((step/2)-_heart_w)*(stepFix) - tws[i]/2;
            if (i == menu_selection) {
                var hx = dx2 - _heart_w - padding;
                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y+2) + heart_yoff,
                                heart_scale, heart_scale, 0, c_white, 1);
                draw_set_color(c_yellow);
            } else draw_set_color(c_white);
			if global.lang != "jp"{
				draw_text_ext(dx2, base_y, menu_options[i], V_sep, menu_wrap_width)
			} else{
				draw_text_ext_transformed(dx2, base_y, menu_options[i], V_sep, menu_wrap_width, 0.25, 0.25, 0)
			}
        } break;

        case 3: {
			if global.lang != "jp"{
	            var dx_top = center_x - tws[1]/2;
	            if (1 == menu_selection) {
	                var hx = dx_top - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y - (V/2)) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext(dx_top, base_y - (V/2) - 2, menu_options[1], V_sep, menu_wrap_width)

	            var dx_bl = center_x - step - tws[0]/2;
	            if (0 == menu_selection) {
	                var hx = dx_bl - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y +2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext(dx_bl, base_y, menu_options[0], V_sep, menu_wrap_width)

	            var dx_br = center_x + step - tws[2]/2;
	            if (2 == menu_selection) {
	                var hx = dx_br - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y +2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext(dx_br, base_y, menu_options[2], V_sep, menu_wrap_width)
			} else{
				var dx_top = center_x - tws[1]/2;
	            if (1 == menu_selection) {
	                var hx = dx_top - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y - (V/2)) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext_transformed(dx_top, base_y - (V/2) - 2, menu_options[1], V_sep, menu_wrap_width, 0.25, 0.25, 0)

	            var dx_bl = center_x - step - tws[0]/2;
	            if (0 == menu_selection) {
	                var hx = dx_bl - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y +2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext_transformed(dx_bl, base_y, menu_options[0], V_sep, menu_wrap_width, 0.25, 0.25, 0)

	            var dx_br = center_x + step - tws[2]/2;
	            if (2 == menu_selection) {
	                var hx = dx_br - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y +2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext_transformed(dx_br, base_y, menu_options[2], V_sep, menu_wrap_width, 0.25, 0.25, 0)
			}
        } break;

        case 4: {
			if global.lang != "jp"{
	            var dx_t = center_x - tws[1]/2;
	            if (1 == menu_selection) {
	                var hx = dx_t - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y - V+2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext(dx_t, base_y - V, menu_options[1], V_sep, menu_wrap_width)

	            var dx_l = center_x - step - tws[0]/2;
	            if (0 == menu_selection) {
	                var hx = dx_l - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y+2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext(dx_l, base_y, menu_options[0], V_sep, menu_wrap_width)

	            var dx_r = center_x + step - tws[2]/2;
	            if (2 == menu_selection) {
	                var hx = dx_r - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y+2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext(dx_r, base_y, menu_options[2], V_sep, menu_wrap_width)

	            var dx_b = center_x - tws[3]/2;
	            if (3 == menu_selection) {
	                var hx = dx_b - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y + V+2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext(dx_b, base_y + V, menu_options[3], V_sep, menu_wrap_width)
			} else{
				var dx_t = center_x - tws[1]/2;
	            if (1 == menu_selection) {
	                var hx = dx_t - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y - V+2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext_transformed(dx_t, base_y - V, menu_options[1], V_sep, menu_wrap_width, 0.25, 0.25, 0)

	            var dx_l = center_x - step - tws[0]/2;
	            if (0 == menu_selection) {
	                var hx = dx_l - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y+2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext_transformed(dx_l, base_y, menu_options[0], V_sep, menu_wrap_width, 0.25, 0.25, 0)

	            var dx_r = center_x + step - tws[2]/2;
	            if (2 == menu_selection) {
	                var hx = dx_r - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y+2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext_transformed(dx_r, base_y, menu_options[2], V_sep, menu_wrap_width, 0.25, 0.25, 0)

	            var dx_b = center_x - tws[3]/2;
	            if (3 == menu_selection) {
	                var hx = dx_b - _heart_w - padding;
	                draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y + V+2) + heart_yoff,
	                                heart_scale, heart_scale, 0, c_white, 1);
	                draw_set_color(c_yellow);
	            } else draw_set_color(c_white);
				draw_text_ext_transformed(dx_b, base_y + V, menu_options[3], V_sep, menu_wrap_width, 0.25, 0.25, 0)
			}
        } break;

        default: {
            for (var i = 0; i < n; i++) {
                var dxn = region_left + step*(i + 1) - tws[i]/2;
                if (i == menu_selection) {
                    var hx = dxn - _heart_w - padding;
                    draw_sprite_ext(spr_menu_heart, 0, hx + heart_xoff, (base_y+2) + heart_yoff,
                                    heart_scale, heart_scale, 0, c_white, 1);
                    draw_set_color(c_yellow);
                } else draw_set_color(c_white);
				if global.lang != "jp"{
					draw_text_transformed(dxn, base_y, menu_options[i], 0.25, 0.25, 0);
				}
            }
        } break;
    }
}

draw_set_halign(fa_left);
draw_set_color(c_white);

}