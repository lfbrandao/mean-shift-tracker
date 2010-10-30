% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [ y ] = epanechnikov( x, d, cd )
   
    if x > 1
        y = 0;
    else 
        y = 0.5 * cd^(-1) * (d+2) * (1-x);
    
    y(y<0) = 0;
    
end

