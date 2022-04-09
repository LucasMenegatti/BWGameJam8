/// @description Insert description here
// You can write your code in this editor
#region ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
	tempo_minimo_abrir_porta = 2 // Tempo em segundos mínimo para abrir uma porta aleatória 
	tempo_maximo_abrir_porta = 8 // Tempo em segundos máximo para abrir uma porta aleatória
	
	chance_inimigo_normal		= 60;  //Chance (em %) de que uma porta, ao abrir, contenha um inimigo
	chance_inimigo_boss_morto	= 100; //Chance (em %) de que uma porta, ao abrir, contenha um inimigo, enquanto o boss estiver morto
	
	cranios_alcapao = 8; // Quantidade de cranios necessária para abrir o alcapao
	
	voltaDoChefaoSegundos	= 35; // Tempo em segundos para a volta do chefão depois que esse é abatido
	voltaDoPlayerSegundos	= 3;  // Tempo em segundos para que o player volte depois de ganhar o jogo
	
	som_abre_alcapao = snd_porta_abrindo;
	
	musica_fundo = snd_background;
#endregion
#region ================================ VARIÁVEIS DE CONTROLE (NÃO ALTERAR) ================================
	// criar_portas()
	portasIDs = [];
	portaPlayerID = noone;

	// abrePorta()
	tempo_porta = room_speed*irandom_range(tempo_minimo_abrir_porta,tempo_maximo_abrir_porta);
	contador_porta = tempo_porta;
	
	tempo_chefao = room_speed*voltaDoChefaoSegundos;
	contador_chefao = tempo_chefao;

	tempo_renascer = room_speed*voltaDoPlayerSegundos;
	contador_renascer = tempo_renascer;
	
	tocou_som_alcapao = false;

	global.chefao = true; // O chefão está na tela no início do jogo
	global.cranios = 0; // Os crânicos coletados começam de zero
	global.vitorias = 0; // Número de vitórias (contador)
	global.derrotas = 0; // N[umero de derrotas (contador)
#endregion
#region  ============================================== MÉTODOS ==============================================
	criar_portas = function() {
		for(var _i = 0; _i < 3; _i++) {
			portasIDs[_i] = instance_create_layer(384+384*_i, 0, "portas", obj_porta);
		}
		portaPlayerID = instance_create_layer(896,1280,"portas",obj_porta);
		portaPlayerID.image_angle += 180;
		portaPlayerID.portaDoPlayer = true;
		alcapaoID = instance_create_layer(1408,512,"portas",obj_alcapao);
	}

	criar_arco = function() {
		instance_create_layer(random_range(128,room_width-128),random_range(128,room_height-128),"Instances",obj_arco_chao);
	}

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
			chance_conter_inimigo = chance_inimigo_boss_morto;
		} else {
			chance_conter_inimigo = chance_inimigo_normal;
		}
		if(irandom(100)<chance_conter_inimigo) {
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

	abreAlcapao = function(){
		if(global.cranios>=cranios_alcapao){
			alcapaoID.image_index = 1;
			if(!tocou_som_alcapao) audio_play_sound(som_abre_alcapao,10,false)
			tocou_som_alcapao = true;
		} else {
			alcapaoID.image_index = 0;
			tocou_som_alcapao = false;
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

	#region =============== GUI ===============
		desenha_visao = function() {
			if(instance_exists(obj_player)) {
				switch(obj_player.vida){
					case(3):
						draw_sprite_ext(spr_tela,0,view_get_xport(0)-10,view_get_yport(0)-10,1,1,0,c_black,1);
						break;
					case(2):
						draw_sprite_ext(spr_tela,1,view_get_xport(0)-10,view_get_yport(0)-10,1,1,0,c_black,1);
						break;
					case(1):
						draw_sprite_ext(spr_tela,2,view_get_xport(0)-10,view_get_yport(0)-10,1,1,0,c_black,1);
						break;
				}
			}
		}
	
		desenhaVidaPlayer = function() {
			if(instance_exists(obj_player)){
				for(var i = 0; i < obj_player.vida; i++){
					draw_sprite(spr_coracao,0,50+70*i,50);
				}
			}
		}
	
		desenhaVitoriasEDerrotas = function() {
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
	
		desenhaCranios = function() {
			for(var j = 0; j < global.cranios; j++) {
				draw_sprite(spr_cranio,0,display_get_gui_width()-50-70*j,display_get_gui_height()-50);
			}
		}
	#endregion
#endregion
	criar_portas(); // Chama o método para criar as portas
	criar_arco(); // Chama o método para criar um arco em um ponto aleatório do mapa
	audio_play_sound(musica_fundo,1,true); // tocar musica de fundo