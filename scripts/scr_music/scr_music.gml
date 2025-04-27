function scr_music(song, fadeout = 0, fadein = 0, songoverlap = false, songpitch = 1){

//"noone" to fade to nothing
//fadein = # of frames to fade in
//fadeout = # of frames to fadeout

with obj_musiquemanager{
	targetsongass = song
	endfade = fadeout
	startfade = fadein
	overlap = songoverlap
	pitch = songpitch
}

}