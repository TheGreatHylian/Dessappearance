if image_alpha < 1{
	image_alpha += increment
} else{
	if timer > 0{
		timer--
	} else{
		instance_destroy()
	}
}