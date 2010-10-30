% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [ image ] = RGB2rgb( image )
  %RGB2rgb Converts RGB values to normalised rgb
  I = im2double(image);
	
	R = I(:, :, 1);
	G = I(:, :, 2);
	B = I(:, :, 3);

	%% add one to sort of smooth the results
	R = R + ones(size(R, 1), size(R, 2));
	G = G + ones(size(G, 1), size(G, 2));
	B = B + ones(size(B, 1), size(B, 2));
	S = R + G + B;

	J(:, :, 1) = (R ./ S);
	J(:, :, 2) = (G ./ S);
	J(:, :, 3) = (B ./ S);
    
    image = I;
end

