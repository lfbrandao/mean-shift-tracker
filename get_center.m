% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [y_center, x_center] = get_center(target_rect)
    target_x = round(target_rect(1));   
    target_y = round(target_rect(2));
    target_width = round(target_rect(3));
    target_height = round(target_rect(4));

    y_center = round(target_y - (target_height / 2));
    x_center = round(target_x - (target_width / 2));
end