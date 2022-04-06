/// @description Insert description here
// You can write your code in this editor
// ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
tempo_renascer = room_speed*3;

// ================================ VARIÁVEIS DAS FUNÇÕES (NÃO ALTERAR) ================================
// criar_portas()
portasIDs = [];
portaPlayerID = noone;

// abrePorta()
tempo_porta = room_speed*irandom_range(2,8);
contador_porta = tempo_porta;

contador_renascer = tempo_renascer;

global.chefao = true;
global.cranios = 0;
global.vitorias = 0;
global.derrotas = 0;

// ============================================== MÉTODOS ==============================================

criar_portas = function() {
	for(var _i = 0; _i < 3; _i++) {
		portasIDs[_i] = instance_create_layer(384+384*_i, 0, "portas", obj_porta);
	}
	portaPlayerID = instance_create_layer(896,1280,"portas",obj_porta);
	portaPlayerID.image_angle += 180;
	portaPlayerID.portaDoPlayer = true;
	alcapaoID = instance_create_layer(1408,512,"portas",obj_alcapao);
}
criar_portas();

criar_arco = function() {
	instance_create_layer(random_range(128,room_width-128),random_range(128,room_height-128),"Instances",obj_arco_chao);
}

criar_arco();

tempo_chefao = room_speed*35;
contador_chefao = tempo_chefao;

abrePorta = function() {
	contador_porta--;
	contador_chefao--;
	if(contador_porta <= 0){
		var _idDaPorta = portasIDs[irandom(2)];
		if(_idDaPorta.image_index = 0){
			_idDaPorta.image_index = 1;
			gerarInimigos(_idDaPorta);
		}
		if(!global.chefao){
			contador_porta = room_speed/2;
		} else {
			contador_porta = room_speed*irandom_range(2,8);
			contador_chefao = tempo_chefao;
		}	
	}
}

gerarInimigos = function(_idPorta) {
	if(!global.chefao){
		chance_de_criar_inimigo = 100;
	} else {
		chance_de_criar_inimigo = 60;
	}
	if(irandom(100)<chance_de_criar_inimigo) {
		if(contador_chefao>0){
			instance_create_layer(_idPorta.x, _idPorta.y+100,"inimigos",obj_inimigo_pai);
		} else {
			instance_create_layer(_idPorta.x, _idPorta.y+150,"inimigos",obj_chefao);
			global.chefao = true;
			contador_chefao = tempo_chefao;
			if(instance_exists(obj_player)) obj_player.perder_cranios();
			global.cranios = 0;
		}			
	}
}

tocou_som_alcapao = false;

abreAlcapao = function(){
	if(global.cranios>=8){
		alcapaoID.image_index = 1;
		if(!tocou_som_alcapao) audio_play_sound(snd_porta_abrindo,10,false)
		tocou_som_alcapao = true;
	} else {
		alcapaoID.image_index = 0;
		tocou_som_alcapao = false;
	}
}


// GUI
desenhaVidaPlayer = function() {
	if(instance_exists(obj_player)){
		for(var i = 0; i < obj_player.vida; i++){
			draw_sprite(spr_coracao,0,50+70*i,50);
		}
		for(var j = 0; j < global.cranios; j++) {
			draw_sprite(spr_cranio,0,display_get_gui_width()-50-70*j,display_get_gui_height()-50);
		}
	}
	draw_set_halign(fa_center);
	draw_set_font(Font1);
	draw_set_color(c_black);
    draw_text(display_get_gui_width()/2,50,"Won: "+string(global.vitorias)+" Lost: "+string(global.derrotas));
    draw_set_color(c_white);
    draw_text(display_get_gui_width()/2-1, 49,"Won: "+string(global.vitorias)+" Lost: "+string(global.derrotas));
	draw_set_font(0);
	draw_set_color(0);
	draw_set_halign(0);
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

// sons
audio_play_sound(snd_background,1,true);