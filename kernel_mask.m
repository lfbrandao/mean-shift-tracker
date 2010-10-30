% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [ M ] = kernel_mask( w, h, depth )
    % initialise M
    M = zeros(h, w);
    
    % calculate M using Epanechnikov
    cd = pi; % Epanechnikov param
    d  = 2; % Epanechnikov param
    
    [X, Y] = ndgrid(-1 : 2/(h-1) : 1, -1 : 2/(w-1) : 1);
    
    M = epanechnikov( sqrt(X.^2 + Y.^2), cd, d );
    M = repmat(M, [1,1,depth]);
    
    %Msum = sum(sum(M));
    %M = M * (1/Msum);
end