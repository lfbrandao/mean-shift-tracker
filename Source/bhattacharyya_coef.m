% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [coef] = bhattacharyya_coef(histogram_1, histogram_2)
    coef = sum(sum(sqrt(histogram_2 .* histogram_1)));
end