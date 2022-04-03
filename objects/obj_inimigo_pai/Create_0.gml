/// @description Insert description here
// You can write your code in this editor
vida_maxima = 100;
vida_atual = vida_maxima;

speed = random_range(1,3);
direction = irandom_range(0,359);
image_angle = direction;
distancia_detecta = 300; // Distancia em que o inimigo enxerga o player


// ============================================== MÉTODOS ==============================================
saiuDaRoom = function() {
	if(x<=sprite_width/2||x>=room_width-sprite_width/2||y<=sprite_height/2||y>=room_height-sprite_height/2) {
		direction += irandom_range(90,180);
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
	}
	if(vida_atual <=0){
		instance_destroy();	
	}
}

// Eventos de Draw
desenhaVida = function() {
	draw_healthbar(x-40,y-60,x+40,y-50,(vida_atual/vida_maxima)*100, c_black, c_black, c_black, 0, 0, 0);
}