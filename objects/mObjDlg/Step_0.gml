// STEP EVENT

var cEnabled = mControl.isControlEnabled("dialogue")
var lBut    = global.leftbuttonpressed1 && cEnabled;
var rBut    = global.rightbuttonpressed1 && cEnabled;
var uBut    = global.upbuttonpressed1 && cEnabled;
var dBut    = global.downbuttonpressed1 && cEnabled;
var selBut  = global.selectbuttonpressed && cEnabled;
var canBut  = keyboard_check_pressed(global.cancelbutton) && cEnabled;
var menBut  = keyboard_check_pressed(global.menubutton) && cEnabled;

w_padding    = (char_sprite != spr_none && char_visible) ? box_wrap_spr : box_wrap_none;
wrap_w     = box_width + w_padding;

frame_counter++;
input_advance = selBut;
if (canBut && !unskippable) skip_all = true;

char_anim_timer += delta_time/1_000_000;
if (char_anim_timer >= 1/char_sprite_fps) {
    char_anim_timer -= 1/char_sprite_fps;
    char_anim_frame = (char_anim_frame+1) mod sprite_get_number(char_sprite);
}

dialogue_anim_timer += delta_time/1_000_000;
if (dialogue_anim_timer >= 1/dialogue_sprite_fps) {
    dialogue_anim_timer -= 1/dialogue_sprite_fps;
    dialogue_anim_frame = (dialogue_anim_frame+1) mod sprite_get_number(dialogue_sprite);
}

current_whole_shake_enabled = false;
for (var i = 0; i < array_length(parsed_text); i++) {
    var e = parsed_text[i];
    if (e.type == "char" && e.shake_type == "whole") {
        current_whole_shake_enabled = true;
        current_whole_shake_offset  = e.shake_offset;
        current_whole_shake_intensity = e.shake_intensity;
        break;
    }
}

auto_advance = false;
unskippable  = false;
for (var i = 0; i < array_length(parsed_text); i++) {
    var e = parsed_text[i];
    if (e.type == "autoskip")    auto_advance = true;
    if (e.type == "unskippable") unskippable  = true;
}

function _do_token(elp) {
if (elp.type == "run") {
    var call  = elp.fn;
    var paren = string_pos("(", call);
    var name  = paren > 0 ? string_copy(call, 1, paren - 1) : call;
    var arg_s = paren > 0
              ? string_copy(call, paren + 1, string_length(call) - paren - 1)
              : "";

    function split_args(str) {
        var out = [], cur = "";
        var depthT = 0, in_str = false, len = string_length(str);

        for (var i = 1; i <= len; i++) {
            var ch = string_char_at(str, i);
            if (ch == "\"" && (i == 1 || string_char_at(str, i - 1) != "\\")) {
                in_str = !in_str;
            }
            if (!in_str) {
                if (ch == "[") depthT++;
                else if (ch == "]") depthT--;
                else if (ch == "," && depthT == 0) {
                    array_push(out, string_trim(cur));
                    cur = "";
                    continue;
                }
            }
            cur += ch;
        }
        if (string_length(cur) > 0) array_push(out, string_trim(cur));
        return out;
    }

    if (!ds_map_exists(global.run_map, name)) return;
    var fn = ds_map_find_value(global.run_map, name);
    var raw_args = (paren > 0 && string_length(arg_s)) ? split_args(arg_s) : [];

	function _is_number(str) {
	    if (!is_string(str)) return is_real(str);

	    var s = string_trim(str);
	    for (var i = 1; i <= string_length(s); i++) {
	        var c = string_char_at(s, i);
	        if (!((c >= "0" && c <= "9") || c == "." || c == "-")) {
	            return false;
	        }
	    }
	    return !is_nan(real(s));
	}

    var call_args = [];

    for (var i = 0; i < array_length(raw_args); i++) {
        var a = string_trim(raw_args[i]);
        var len = string_length(a);

        if (len >= 2 && string_char_at(a, 1) == "\"" && string_char_at(a, len) == "\"") {
            array_push(call_args, string_copy(a, 2, len - 2));
            continue;
        }

        if (len >= 2 && string_char_at(a, 1) == "[" && string_char_at(a, len) == "]") {
            var contents = string_copy(a, 2, len - 2);
            var parts = split_args(contents);
            var arr = [];
            for (var j = 0; j < array_length(parts); j++) {
                var sub = string_trim(parts[j]);
                if (_is_number(sub)) {
                    array_push(arr, real(sub));
                } else if (string_char_at(sub, 1) == "\"" && string_char_at(sub, string_length(sub)) == "\"") {
                    array_push(arr, string_copy(sub, 2, string_length(sub) - 2));
                } else if (variable_global_exists(sub)) {
                    array_push(arr, variable_global_get(sub));
                } else {
                    var idx = asset_get_index(sub);
                    array_push(arr, idx != -1 ? idx : sub);
                }
            }
            array_push(call_args, arr);
            continue;
        }

        if (_is_number(a)) {
            array_push(call_args, real(a));
            continue;
        }

        var idx = asset_get_index(a);
        if (idx != -1) {
            array_push(call_args, idx);
            continue;
        }

        if (variable_global_exists(a)) {
            array_push(call_args, variable_global_get(a));
            continue;
        }

        array_push(call_args, a);
    }

    //switch (array_length(call_args)) {
    //    case 0: script_execute(fn); break;
    //    case 1: script_execute(fn, call_args[0]); break;
    //    case 2: script_execute(fn, call_args[0], call_args[1]); break;
    //    case 3: script_execute(fn, call_args[0], call_args[1], call_args[2]); break;
	//	case 4: script_execute(fn, call_args[0], call_args[1], call_args[2], call_args[3]); break;
	//	case 5: script_execute(fn, call_args[0], call_args[1], call_args[2], call_args[3], call_args[4]); break;
    //    default:
    //        script_execute(fn, call_args[0], call_args[1], call_args[2], call_args[3], call_args[4], call_args[5]);
    //        break;
    //}
	script_execute_ext(fn, call_args)
}
    else if (elp.type == "s_enabled") {
		voice_enabled = elp.val;
    }
    else if (elp.type == "voice") {
		default_sound = elp.sound;
    }
    else if (elp.type == "s_volume") {
		sound_vol = elp.val;
    }
    else if (elp.type == "s_pitch") {
		sound_pitch = elp.val;
    }
    else if (elp.type == "s_loop") {
		sound_loop = elp.val;
    }
    else if (elp.type == "s_interrupt") {
		sound_interrupt = elp.val;
    }
	else if (elp.type == "face") {
    changeSpr(elp.sprite);
}
}

if (menu_active) {
    var n = array_length(menu_options);

    if (menu_selection < 0) {
        switch (n) {
            case 1:
                menu_selection = 0;
                break;

            case 2:
                if (lBut) menu_selection = 0;
                else if (rBut) menu_selection = 1;
                break;

            case 3:
                if (uBut) menu_selection = 1;
                else if (lBut || rBut) {
                    menu_selection = lBut ? 0 : 2;
                }
                break;

            case 4:
                if (lBut) menu_selection = 0;
                else if (uBut) menu_selection = 1;
                else if (rBut) menu_selection = 2;
                else if (dBut) menu_selection = 3;
                break;
        }
        if (menu_selection >= 0) return;
    }

    if (menu_selection >= 0) {
        switch (n) {
            case 2:
                if (lBut && menu_selection > 0) {
                    menu_selection--;
                }
                else if (rBut && menu_selection < 1) {
                    menu_selection++;
                }
                break;

            case 3:
                if (uBut && (menu_selection == 0 || menu_selection == 2)) {
                    menu_selection = 1;
                }
                else if (lBut && (menu_selection == 1 || menu_selection == 2)) {
                    menu_selection = 0;
                }
                else if (rBut && (menu_selection == 0 || menu_selection == 1)) {
                    menu_selection = 2;
                }
                break;

            case 4:
                if (lBut) {
                    if      (menu_selection == 1) menu_selection = 0;
                    else if (menu_selection == 2) menu_selection = 0;
                    else if (menu_selection == 3) menu_selection = 0;
                }
                else if (uBut) {
                    if      (menu_selection == 0) menu_selection = 1;
                    else if (menu_selection == 2) menu_selection = 1;
                    else if (menu_selection == 3) menu_selection = 1;
                }
                else if (rBut) {
                    if      (menu_selection == 0) menu_selection = 2;
                    else if (menu_selection == 1) menu_selection = 2;
                    else if (menu_selection == 3) menu_selection = 2;
                }
                else if (dBut) {
                    if      (menu_selection == 0) menu_selection = 3;
                    else if (menu_selection == 1) menu_selection = 3;
                    else if (menu_selection == 2) menu_selection = 3;
                }
                break;
        }

        if (selBut) {
			var chosen = menu_selection;
    
			    if (chosen >= 0 && chosen < array_length(menu_fns)) {
			        var fn_name = menu_fns[chosen];
			        if (string_length(fn_name) > 0 && ds_map_exists(global.menu_fn_map, fn_name)) {
			            var fn = ds_map_find_value(global.menu_fn_map, fn_name);
			            script_execute(fn);
			        }
			    }
            menu_choice    = menu_selection;
            menu_active    = false;
            text_index++;
            if (text_index >= array_length(text_lines)) {
				if (is_callable(d_onEnd)) {
				    d_onEnd();
				}
                instance_destroy();
            } else {
                text_char_index = 0; text_timer = 0; displayed_text = "";
                letter_colors   = []; skip_all = false;
                auto_advance    = false; unskippable = false;
				text_done = false;
                reveal_frames   = [];
                parsed_text     = parse_text_line(text_lines[text_index]);
                line_start_frame= frame_counter;
            }
        }

        return;
    }
}

if (!text_done) {
if (skip_all) {
    var rf = frame_counter;
    var offset = 1;
    var visual_index = 0;

    while (text_char_index < array_length(parsed_text)) {
        var elp = parsed_text[text_char_index];
        _do_token(elp);

        if (elp.type == "char" || elp.type == "image") {
            array_push(reveal_frames, rf - (offset * (array_length(parsed_text) - visual_index)));
            visual_index++;
        }

        if (elp.type == "char") {
            displayed_text += elp.char;
            array_push(letter_colors, elp.color);
        }

        text_char_index++;
    }

    text_done = true;
}
    else if (menBut && !unskippable) {
        input_advance = true;
        auto_advance  = true;
        for (var b = 0; b < fast_batch && text_char_index < array_length(parsed_text); b++) {
            var elp = parsed_text[text_char_index];
            _do_token(elp);
            if (elp.type=="char"|| elp.type=="image") array_push(reveal_frames,frame_counter);
            if (elp.type=="char") {
                displayed_text += elp.char;
                array_push(letter_colors, elp.color);
            }
            text_char_index++;
        }
        if (text_char_index >= array_length(parsed_text)) text_done = true;
    }
else {
    if (waiting_on_timer) {
        timer_wait--;
        if (timer_wait <= 0) {
            waiting_on_timer = false;
            text_char_index++;
        } else {
            return;
        }
    }

    var total        = array_length(parsed_text);
    if (text_char_index >= total) return;

    var elp          = parsed_text[text_char_index];
    var baseDelay    = (elp.type == "char" && elp.char_speed > 0)
                     ? elp.char_speed
                     : 1;
    var delay        = baseDelay * speed_multiplier;
    text_timer++;

    var has_insta    = variable_struct_exists(elp, "insta");
    var is_instant   = has_insta && elp.insta;

    if (!is_instant && text_timer < delay) {
        return;
    }
    if (!is_instant) {
        text_timer = 0;
    }

    if (elp.type == "timer" && !waiting_on_timer) {
        timer_wait       = elp.duration;
        waiting_on_timer = true;
        return;
    }

    if (is_instant) {
        var look = text_char_index;
        while (look < total) {
            var nxt = parsed_text[look];
            if (variable_struct_exists(nxt, "insta") && nxt.insta) {
                _do_token(nxt);
                if (nxt.type == "image" || nxt.type == "char") {
                    array_push(reveal_frames, frame_counter);
                }
                if (nxt.type == "char") {
                    displayed_text += nxt.char;
                    array_push(letter_colors, nxt.color);
                    if (nxt.char != " " && voice_enabled) {
					    var has_fuck    = variable_struct_exists(elp, "fucksound");
					    var is_fuck   = has_fuck && elp.fucksound;
						if (!is_fuck) mSfx.sfx_play(default_sound, sound_vol, sound_pitch, sound_loop, sound_interrupt);
                    }
                }
                look++;
            } else {
                break;
            }
        }
        text_char_index = look;
    }
    else {
        _do_token(elp);

        if (elp.type == "image") {
            array_push(reveal_frames, frame_counter);
        }
        else if (elp.type == "char") {
            displayed_text += elp.char;
            array_push(letter_colors, elp.color);
            array_push(reveal_frames, frame_counter);
            if (elp.char != " " && voice_enabled) {
				var has_fuck    = variable_struct_exists(elp, "fucksound");
				var is_fuck   = has_fuck && elp.fucksound;
				if (!is_fuck) mSfx.sfx_play(default_sound, sound_vol, sound_pitch, sound_loop, sound_interrupt);
            }
        }

        text_char_index++;
    }

    text_done = (text_char_index >= total);
}
}

if((input_advance&&text_done)||(auto_advance&&text_done)) && !menu_active{
    text_index++;
    if(text_index>=array_length(text_lines)) {
		if (is_callable(d_onEnd)) {
		    d_onEnd();
		}
		instance_destroy();
	} else {
        text_char_index=0; text_timer=0; displayed_text=""; text_done=false;
        letter_colors=[]; skip_all=false; input_advance=false;
        auto_advance=false; unskippable=false; reveal_frames=[];
        parsed_text=parse_text_line(text_lines[text_index]);
        line_start_frame=frame_counter;
		waiting_on_timer = false; timer_wait = 0;
    }
    input_advance=false;
}

else if (text_done && !menu_active) {
    for (var i = 0; i < array_length(parsed_text); i++) {
        if (parsed_text[i].type == "menu") {
			menu_active    = true;
			menu_options   = parsed_text[i].options;
			menu_fns        = parsed_text[i].fns;
			menu_selection = -1;
			auto_advance   = false;
            break;
        }
    }
}