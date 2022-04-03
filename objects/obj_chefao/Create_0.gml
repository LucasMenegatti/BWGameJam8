/// @description Insert description here
// You can write your code in this editor

// ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
vida_atual = 1000;
vida_max = 1000;
speed = 1;
direction = irandom_range(0,359);


// ================================ VARIÁVEIS DAS FUNÇÕES (NÃO ALTERAR) ================================


// ============================================== MÉTODOS ==============================================
saiuDaRoom = function() {
	if(x<=sprite_width/2||x>=room_width-sprite_width/2||y<=sprite_height/2||y>=room_height-sprite_height/2) {
		direction += irandom_range(90,180);
		image_angle = direction;
	}
}

sempreOlharPlayer = function() {
	if(instance_exists(obj_player)) {
		image_angle = point_direction(x,y,obj_player.x,obj_player.y);
	}
}