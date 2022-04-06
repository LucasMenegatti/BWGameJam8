/// @description Insert description here

// Essa surface é persistente, assim independente se o player ganhar ou morrer, os espirros de sangue continuarão a aparecer 

// Criando a surface para desenhar o sangue, do tamanho da room
surf = surface_create(room_width,room_height);

#region  ============================================== MÉTODOS ==============================================
//Função que prepara a surface e a desenha caso não esteja desenhada.
	desenha_surface = function() {
		if !surface_exists(surf)
		{
		    surf = surface_create(room_width,room_height);
		    surface_set_target(surf);
		    draw_clear_alpha(c_black, 0);
		    surface_reset_target();
		} else {
			draw_surface(surf, 0,0);
		}
	}

//Função que desenha o sangue quando for criado o objeto sangue
	desenha_sangue = function() {
		if(instance_exists(obj_sangue)){
			if(surface_exists(surf)){
				surface_set_target(surf);
				with(obj_sangue){
					draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);	
				}			
				surface_reset_target();
			}
		}
	}
#endregion