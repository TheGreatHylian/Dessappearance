//global vol
global.mastervol  = 1
global.musvol = 1

//song info
songinst = noone
songass = noone
targetsongass = noone
endfade = 0
startfade = 0
startfadeinstvol = 1
pitch = 1

//fadeout
endfadeinsts = array_create(0)
endfadeinstvol = array_create(0)
endfadeinst = array_create(0)

//overlap
overlap = false

//song loop points------------------------------------

//power of spamton
audio_sound_loop_start(mus_neo, 16.57)
audio_sound_loop_end(mus_neo, 135.75)

//-----------------------------------------------------