/// @description Programação do Player

// ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
vida = 10;
velocidade = 10; // Velocidade de movimento


// ================================ VARIÁVEIS DAS FUNÇÕES (NÃO ALTERAR) ================================
// movimentos() - Variáveis de Controle
movimentoHorizontal = 0;
movimentoVertical	= 0;

invulneravel = false;
tempo_invulneravel = room_speed*1;
contador_invulneravel = tempo_invulneravel;


// ============================================== MÉTODOS ==============================================
movimentos = function() {
	
	// Captura as teclas de movimento do teclado
	var _up		= keyboard_check(ord("W"));
	var _down	= keyboard_check(ord("S"));
	var _left	= keyboard_check(ord("A"));
	var _right	= keyboard_check(ord("D"));

	// Retorna a direção de movimento em cada eixo (1, 0 ou -1)
	movimentoHorizontal = _right - _left;
	movimentoVertical	= _down - _up;
	
	// Adiciona nos eixos a direção vezes a velocidade definida
	x += movimentoHorizontal * velocidade;
	y += movimentoVertical * velocidade;
	
	// Limitando o personagem à tela
	x = clamp(x,sprite_width/2,room_width-sprite_width/2);
	y = clamp(y,sprite_height/2,room_height-sprite_height/2);
}

ohar_mouse = function() {
	image_angle = point_direction(x,y,mouse_x,mouse_y);
}

atirar = function() {
	var _click = mouse_check_button_pressed(mb_left)
	if(_click) {
		var _id_tiro = instance_create_layer(x,y,"tiros",obj_tiro);
		_id_tiro.direction = point_direction(x,y,mouse_x,mouse_y);
		_id_tiro.image_angle = _id_tiro.direction;
	}
}

passarPorta = function() {
	if(instance_exists(obj_porta)){
		var _id_porta = instance_place(x,y,obj_porta)
		if(_id_porta) {
			if(_id_porta.image_index==1){
				y = room_height;
				x = room_width/2;
			}
		}
	}
}

perdeVida = function() {
	if(vida <= 0) {
		instance_destroy();
	}
	if(place_meeting(x,y,obj_inimigo_pai)&&!invulneravel) {
		vida--;
		invulneravel = true;
	}
	if(invulneravel){
		contador_invulneravel--;
		if(contador_invulneravel <= 0) {
			invulneravel = false;
			contador_invulneravel = tempo_invulneravel;
		}
	}
}