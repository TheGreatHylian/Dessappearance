function scr_debug_dist(obj, x, y){
    if obj = noone{
        return -1
    }
    with obj{
        return distance_to_point(x, y)
    }
}