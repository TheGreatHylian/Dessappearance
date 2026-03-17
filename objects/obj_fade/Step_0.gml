if room = target_room and image_alpha = 0{

	instance_destroy()

} else if room = target_room{
    image_alpha -= increment
} else if image_alpha < 1{
	image_alpha += increment
}