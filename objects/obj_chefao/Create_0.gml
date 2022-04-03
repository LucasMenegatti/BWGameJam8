/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

vida_maxima = 5000;
vida_atual = vida_maxima;

speed = 0.5;

sempreOlharPlayer = function() {
	if(instance_exists(obj_player)){
		image_angle = point_direction(x,y, obj_player.x, obj_player.y);
	}
}