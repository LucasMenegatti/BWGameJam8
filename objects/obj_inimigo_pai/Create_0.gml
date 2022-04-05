/// @description Insert description here
// You can write your code in this editor
vida_maxima = 9;
vida_atual = vida_maxima;

speed = random_range(1,3);
direction = irandom_range(190,260);
image_angle = direction;
distancia_detecta = 800; // Distancia em que o inimigo enxerga o player


// ============================================== MÉTODOS ==============================================
saiuDaRoom = function() {
	if(x<=sprite_width/2+30||x>=room_width-30-sprite_width/2||y<=sprite_height/2+30||y>=room_height-30-sprite_height/2) {
		direction += irandom_range(120,210);
		image_angle = direction;
	}
}

seguirPlayer = function() {
	if(instance_exists(obj_player)){
		if(point_distance(x,y,obj_player.x,obj_player.y)<distancia_detecta){
			direction = point_direction(x,y,obj_player.x,obj_player.y);
			image_angle = direction;
		}
	}
}

colisaoTiros = function() {
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
		audio_play_sound(choose(snd_d1,snd_d2,snd_d3),2,false);
		instance_destroy();	
	}
}

// Eventos de Draw
desenhaVida = function() {
	draw_healthbar(x-sprite_width/2,y-sprite_height/2-28,x+sprite_width/2,y-sprite_height/2-12,(vida_atual/vida_maxima)*100, c_black, c_black, c_black, 0, 0, 0);
}