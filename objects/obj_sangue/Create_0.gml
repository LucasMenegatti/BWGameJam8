/// @description Insert description here

#region ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
	direcao_sangue = 359;
	
	velocidade_minima_sangue = 5;
	velocidade_maxima_sangue = 20;
	
	tamanho_minimo_sangue = 0.1;
	tamanho_maximo_sangue = 0.5;
	
	cor_do_sangue = c_black;

#endregion
#region ================================ VARIÁVEIS DE CONTROLE (NÃO ALTERAR) ================================
	direcao			= irandom(direcao_sangue);
	velocidade		= random_range(velocidade_minima_sangue,velocidade_maxima_sangue);
	image_xscale	= random_range(tamanho_minimo_sangue,tamanho_maximo_sangue);
	image_yscale	= image_xscale;
	diminui			= random_range(image_xscale/10, image_xscale/5);
	image_blend		= cor_do_sangue;
#endregion
#region  ============================================== MÉTODOS ==============================================
mover_sumir = function()
{
	// Diminuindo
	image_xscale -= diminui;
	image_yscale = image_xscale;
	
	// Movendo
	x += lengthdir_x(velocidade,direcao);
	y += lengthdir_y(velocidade,direcao);
	
	// Mudando a transparencia	
	image_alpha -= random_range(.05,.1);
	
	// Destruindo	
	if (image_xscale <= 0) instance_destroy();
}
#endregion