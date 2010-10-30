% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [weighted_histogram] = weight_histogram(histogram, kernel_mask)
    weighted_histogram = histogram .* kernel_mask
end

