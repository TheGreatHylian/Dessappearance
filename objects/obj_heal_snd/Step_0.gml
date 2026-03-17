if !audio_is_playing(snd_swallow) and timer <= 0{
    scr_snd(snd_heal)
    instance_destroy()
}

timer--