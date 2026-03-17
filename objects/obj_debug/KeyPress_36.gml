if activated{
    
if !instance_exists(mainchara_obj){
    instance_create_layer(x, y, mainchara_layer, mainchara_obj)
}
mainchara_obj.x = center.x
mainchara_obj.y = center.y
    
}