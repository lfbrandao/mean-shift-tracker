% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

function [y1] = mean_shift(q, q_rectangle, image_shift, kernel_mask)
    %   #1
    %   initialize the location of the target with y0 an evaluate the
    %   distance between the histograms
    candidate_img_rgb = RGB2rgb(image_shift); % convert to rgb
  
    y0_x = round(q_rectangle(1));
    y0_y = round(q_rectangle(2));
    y0_width = round(q_rectangle(3));
    y0_height = round(q_rectangle(4));
    
    shift = true;
    count = 0;
    
    y0_coords = get_coordinates3(y0_width, y0_height); 
    
    while (shift)
        candidate = get_target_image(candidate_img_rgb, y0_x, y0_y, y0_width, y0_height);
 
        [candidate_histogram candidate_bins] = im_weighted_2D_histogram(16, candidate, kernel_mask);

        p_y0 = bhattacharyya_coef(q, candidate_histogram);
        
        %   #2
        %   derive the weights according to 10
        weights = compute_weights(candidate_histogram, q, candidate_bins);
         
        %   #3
        %   find the next location of the target according to 11 (y1)
        y1 = [round(sum(y0_coords(:,:,2) .* weights)/sum(weights)) round(sum(y0_coords(:,:,1) .* weights) / sum(weights))];
        sprintf('y0 = (%d,%d); y1 = (%d,%d).',y0_x,y0_y,round(y1(1)),round(y1(2)))
        
        y1 = [y0_x y0_y] + y1;
       
        candidate = get_target_image(candidate_img_rgb, y1(1), y1(2), y0_width, y0_height);
        [candidate_histogram candidate_bins] = im_weighted_2D_histogram(16, candidate, kernel_mask);

        %   #4
        %   compute the distance
        p_y1 = bhattacharyya_coef(q, candidate_histogram);
        
        sprintf('p_y0 = %d; p_y1 = %d', p_y0, p_y1)
      
        if norm(y1 - [y0_x y0_y]) > 0 && count < 10
			y0_x = y1(1);
            y0_y = y1(2);
			count = count + 1;
		else 
			break;
		end
    end
end

