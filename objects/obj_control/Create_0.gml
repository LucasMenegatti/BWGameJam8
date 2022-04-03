/// @description Insert description here
// You can write your code in this editor
// ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
tempo_porta = room_speed*irandom_range(3,10);

// ================================ VARIÁVEIS DAS FUNÇÕES (NÃO ALTERAR) ================================
// criar_portas()
portasIDs = [];

// abrePorta()
contador_porta = tempo_porta;

// ============================================== MÉTODOS ==============================================

criar_portas = function() {
	for(var _i = 0; _i < 3; _i++) {
		portasIDs[_i] = instance_create_layer(200+200*_i, 0, "portas", obj_porta);
	}
}
criar_portas();


abrePorta = function() {
	contador_porta--;
	if(contador_porta <= 0){
		var _idDaPorta = portasIDs[irandom(2)];
		if(_idDaPorta.image_index = 0){
			_idDaPorta.image_index = 1;
			gerarInimigos(_idDaPorta);
		}
		contador_porta = room_speed*irandom_range(5,15);
	}
}

gerarInimigos = function(_idPorta) {
	if(irandom(1)){
		instance_create_layer(_idPorta.x, _idPorta.y+64,"inimigos",obj_inimigo_pai);
	}
}

// GUI
desenhaVidaChefao = function() {
	if(instance_exists(obj_chefao)){
		draw_healthbar(50,room_height-50,room_width-50,room_height-30,(obj_chefao.vida_atual/obj_chefao.vida_maxima)*100, c_black, c_black, c_white, 0, 0, 0);
	}
}

desenhaVidaPlayer = function() {
	if(instance_exists(obj_player)){
		draw_text(30,30,obj_player.vida);
	}
}