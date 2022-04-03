/// @description Insert description here
// You can write your code in this editor
// ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
tempo_porta = room_speed*irandom_range(3,10);
tempo_renascer = room_speed*3;

// ================================ VARIÁVEIS DAS FUNÇÕES (NÃO ALTERAR) ================================
// criar_portas()
portasIDs = [];
portaPlayerID = noone;

// abrePorta()
contador_porta = tempo_porta;

contador_renascer = tempo_renascer;

// ============================================== MÉTODOS ==============================================

criar_portas = function() {
	for(var _i = 0; _i < 3; _i++) {
		portasIDs[_i] = instance_create_layer(128+256*_i, 0, "portas", obj_porta);
	}
	portaPlayerID = instance_create_layer(512,640,"portas",obj_porta);
	portaPlayerID.image_angle += 180;
	portaPlayerID.portaDoPlayer = true;
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
		draw_healthbar(70,room_height-50,room_width-70,room_height-70,(obj_chefao.vida_atual/obj_chefao.vida_maxima)*100, c_black, c_black, c_black, 0, 0, 0);
	}
}

desenhaVidaPlayer = function() {
	if(instance_exists(obj_player)){
		for(var i = 0; i < obj_player.vida; i++){
			draw_sprite(spr_coracao,0,50+70*i,50);
		}
	}
}

renascer = function() {
	if(!instance_exists(obj_player)){
		contador_renascer--;
		if(contador_renascer <= 0){	
			instance_create_layer(room_width/2,room_height-46-sprite_height/2,"Instances",obj_player);
			portaPlayerID.image_index = 1;
			contador_renascer = tempo_renascer;
		}
	}
}