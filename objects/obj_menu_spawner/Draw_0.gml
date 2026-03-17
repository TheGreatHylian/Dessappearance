if keyboard_check_pressed(global.menubutton) and instance_exists(obj_mainchara) and obj_mainchara.can_move{
    instance_create_depth(0, 0, -1000, obj_menu)
    obj_mainchara.can_move = false
}