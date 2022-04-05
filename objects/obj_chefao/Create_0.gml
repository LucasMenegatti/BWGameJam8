/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

vida_maxima = 60;
vida_atual = vida_maxima;

speed = 0.5;

sempreOlharPlayer = function() {
	if(instance_exists(obj_player)){
		image_angle = point_direction(x,y, obj_player.x, obj_player.y);
	}
}

desenhaVidaChefao = function() {
	if(instance_exists(obj_chefao)){
		draw_healthbar(x-sprite_width/2-64,y-sprite_height/2-28,x+sprite_width/2+64,y-sprite_height/2-12,(vida_atual/vida_maxima)*100, c_black, c_black, c_black, 0, 0, 0);
	}
}

colisaoTirosChefao = function() {
	var _idTiro = instance_place(x,y,obj_tiro);
	if(_idTiro){
		instance_destroy(_idTiro);
		_idTiro = noone;
		vida_atual--;
		audio_play_sound(snd_hit,2,false);
	}
	if(vida_atual <=0){
		if(instance_exists(obj_surface)){
			repeat(irandom_range(5,25))
			{
				instance_create_layer(x, y, layer,obj_sangue);
			}
		}
		instance_create_layer(x,y,"cranios",obj_cranio);
		global.chefao = false;
		audio_play_sound(snd_boss_death,3,false);
		instance_destroy();	
	}
}