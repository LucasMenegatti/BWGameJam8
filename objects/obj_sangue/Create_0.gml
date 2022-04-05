/// @description Insert description here
// You can write your code in this editor

#region ============ VARIÁVEIS DO OBJETO ============
direcao			= irandom(359);
velocidade		= random_range(5,20);
image_xscale	= random_range(0.1,0.5);
image_yscale	= image_xscale;
diminui			= random_range(image_xscale/10, image_xscale/5);
image_blend		= c_black;


#endregion

#region ============ MÉTODOS ============
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