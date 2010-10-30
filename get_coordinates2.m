% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [ coords ] = get_coordinates2( x_center, y_center, width, height)
    start_x = x_center - (width / 2);
    start_y = y_center - (height / 2);
    end_x = x_center + (width / 2);
    end_y = y_center + (height / 2);
    
    x_coord = repmat(start_x : end_x, height+1,1);
    y_coord = repmat((start_y : end_y)',1, width+1);
    
    coords = zeros(size(x_coord,1), size(x_coord,2), 2);
    coords(:,:,1) = y_coord;
    coords(:,:,2) = x_coord;
end

