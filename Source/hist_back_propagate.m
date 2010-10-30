% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [ out_image ] = hist_back_propagate( image, bin_counts )
    NUM_BINS = size(bin_counts,1)

    % get the r and g channels
    r = image(:,:,1);
    g = image(:,:,2);
    
    % identify the bin of each channel
    r_bin_nr = ceil(r .* NUM_BINS);
    g_bin_nr = ceil(g .* NUM_BINS);
    
    % instantiate a new image
    out_image = zeros(size(image,1), size(image,2));
    
    % create the new image based on the bins
    for i = 1:NUM_BINS
        for j = 1:NUM_BINS
            mask = (r_bin_nr == i) & (g_bin_nr == j);
            out_image(mask) = bin_counts(i, j);
        end
    end


end

