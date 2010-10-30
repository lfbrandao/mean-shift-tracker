% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [bin_counts, bin_numbers] = im_weighted_2D_histogram(NUM_BINS, image, kernel)
  normHx = size(kernel,1);
	normHy = size(kernel,2);
	
	binsize = 256 / NUM_BINS;

	image = (image + abs(min(image(:)))) / (abs(min(image(:))) + max(image(:)));
	image = (image * 255) + 1;
	
    r = image(:,:,1); % blue
    g = image(:,:,2);
    
    % identify the bin of each channel
    r_bin_nr = ceil(double(r)/binsize);
	  g_bin_nr = ceil(double(g)/binsize);

    % loop through the image
    dim_rows = size(image, 1);
    dim_cols = size(image, 2);
    
    % set vectors holding the bin counts
    %r_bin_counts = zeros(NUM_BINS, 1);
    %g_bin_counts = zeros(NUM_BINS, 1);
    bin_counts = zeros(binsize, binsize);
    
    % count bins
    for i = 1:dim_rows
       for j = 1:dim_cols
           bin_counts(r_bin_nr(i,j), g_bin_nr(i,j)) = ...
                bin_counts(r_bin_nr(i,j), g_bin_nr(i,j)) + kernel(i,j);
       end
    end
    
    %image_size = size(image,1) * size(image,2);
    %bin_counts = bin_counts / image_size;

    bin_numbers(:,:,1) = r_bin_nr;
    bin_numbers(:,:,2) = g_bin_nr;
end

