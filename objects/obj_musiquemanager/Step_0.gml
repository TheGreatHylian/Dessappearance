//adjust vol for settings
var final_vol = global.musvol * global.mastervol

//play target song
if songass != targetsongass{
	
	if audio_is_playing(songinst){
		array_push(endfadeinsts, songinst)
		array_push(endfadeinstvol, startfadeinstvol)
		array_push(endfadeinst, endfade)
		
		songinst = noone
		songass = noone
	}
	
	if array_length(endfadeinsts) = 0 or overlap{
		if audio_exists(targetsongass){
			songinst = audio_play_sound(targetsongass, 4, true, 1, 0, pitch)
	
			audio_sound_gain(songinst, 0, 0)
			startfadeinstvol = 0
		}
		songass = targetsongass
		overlap = false
	}
}
//vol control
if audio_is_playing(songinst){
	
	if startfade > 0{
		if startfadeinstvol < 1{
			startfadeinstvol += 1/startfade
		} else{
			startfadeinstvol = 1
		}
	} else{
		startfadeinstvol = 1
	}
	
	audio_sound_gain(songinst, startfadeinstvol * final_vol, 0)
	
}

//fadeout
for(var i = 0; i < array_length(endfadeinsts); i++){
	if endfadeinst[i] > 0{
		if endfadeinstvol[i] > 0{
			endfadeinstvol[i] -= 1/endfadeinst[i]
		}
	} else{
		endfadeinstvol[i] = 0
	}
	audio_sound_gain(endfadeinsts[i], endfadeinstvol[i] * final_vol, 0)
	if endfadeinstvol[i] <= 0{
		if audio_is_playing(endfadeinsts[i]){
			audio_stop_sound(endfadeinsts[i])
			
			array_delete(endfadeinsts, i, 1)
			array_delete(endfadeinstvol, i, 1)
			array_delete(endfadeinst, i, 1)
			i--
		}
	}
}