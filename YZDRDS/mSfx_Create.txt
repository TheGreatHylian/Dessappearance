sfx_instances = ds_map_create();
sfx_categories = ds_map_create();
sfx_interrupt_flags = ds_map_create();
sfx_category_interrupts = ds_map_create();


// === Function: sfx_play ===
/// @function sfx_play(_sound, _volume, _pitch, _loop, _interrupt_duplicates, _category)
sfx_play = function(_sound, _volume = 1, _pitch = 1, _loop = false, _interrupt_duplicates = false, _category = "") {
    var name = string(_sound);

    if (_interrupt_duplicates && ds_map_exists(sfx_instances, name)) {
        var sndid_old = sfx_instances[? name];
        if (audio_is_playing(sndid_old)) audio_stop_sound(sndid_old);
    }

    if (_category != "" && ds_map_exists(sfx_category_interrupts, _category) && sfx_category_interrupts[? _category]) {
        var keys = ds_map_keys(sfx_instances);
        for (var i = 0; i < array_length(keys); i++) {
            var k = keys[i];
            if (ds_map_exists(sfx_categories, k) && sfx_categories[? k] == _category) {
                var sndid_cat = sfx_instances[? k];
                if (audio_is_playing(sndid_cat)) audio_stop_sound(sndid_cat);
                ds_map_delete(sfx_instances, k);
            }
        }
    }

    var sndid = audio_play_sound(_sound, false, _loop);
    audio_sound_gain(sndid, _volume, 0);
    audio_sound_pitch(sndid, _pitch);

    sfx_instances[? name] = sndid;
    sfx_categories[? name] = _category;
    sfx_interrupt_flags[? name] = _interrupt_duplicates;

    return sndid;
};

sfx_pause = function(_sound) {
    var name = string(_sound);
    if (ds_map_exists(sfx_instances, name)) {
        var sndid = sfx_instances[? name];
        if (audio_is_playing(sndid)) {
            audio_pause_sound(sndid);
        }
    }
};

sfx_resume = function(_sound) {
    var name = string(_sound);
    if (ds_map_exists(sfx_instances, name)) {
        var sndid = sfx_instances[? name];
        audio_resume_sound(sndid);
    }
};

sfx_stop = function(_sound) {
    var name = string(_sound);
    if (ds_map_exists(sfx_instances, name)) {
        var sndid = sfx_instances[? name];
        if (audio_is_playing(sndid)) audio_stop_sound(sndid);

        ds_map_delete(sfx_instances, name);
        ds_map_delete(sfx_categories, name);
        ds_map_delete(sfx_interrupt_flags, name);
    }
};

sfx_set_category_interrupt = function(_category, _should_interrupt) {
    sfx_category_interrupts[? _category] = _should_interrupt;
};