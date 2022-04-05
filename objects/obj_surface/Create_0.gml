/// @description Insert description here
// You can write your code in this editor
surf = surface_create(room_width,room_height);

desenha_surface = function() {
	if !surface_exists(surf)
	{
	    surf = surface_create(room_width,room_height);
	    surface_set_target(surf);
	    draw_clear_alpha(c_black, 0);
	    surface_reset_target();
	} else {
		draw_surface(surf, 0,0);
	}
}

desenha_sangue = function() {
	if(instance_exists(obj_sangue)){
		if(surface_exists(surf)){
			surface_set_target(surf);
			with(obj_sangue){
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);	
			}			
			surface_reset_target();
		}
	}
}