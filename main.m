% Project: Mean-shift tracker
% Author: Luís Brandão
% University of Amsterdam, Intelligent Multimedia Systems course - Fall 2009

result_path = './Frames/Result';
path = './Frames';
%path = './Frames/ThreePastShop1cor';
%path = './Frames/ropeframes';

target_frame = imread('./LabImages/Frame0085.png');
%target_frame = imread('./Frames/ThreePastShop1cor/ThreePastShop1cor0175.jpg');
%target_frame = imread('./Frames/ropeframes/images00032.png');

fighandle = figure, imshow(target_frame);

%[xmin ymin width height] 
target_rect = getrect();
%target_rect = [420.7791  357.9884    6.6977   21.7674];
target_x = round(target_rect(1));
target_y = round(target_rect(2));
target_width = round(target_rect(3));
target_height = round(target_rect(4));

% check if width/height is odd and add 1
if(rem(target_width, 2) ~= 0)
    target_width = target_width + 1;
end

if(rem(target_height, 2) ~= 0)
    target_height = target_height + 1;
end

target_x_center = target_x + (target_width / 2);
target_y_center = target_y + (target_height / 2);

% pre-process target-image / convert to rgb
target_image = get_target_image(target_frame, target_x_center, target_y_center, target_width, target_height);
target_image_rgb = RGB2rgb(target_image); % convert to rgb

% draw a rectangle on the target current position
rectangle('Position',target_rect,'Curvature',[0.4]);

% get target coordinates on image
[coords] = get_coordinates2(target_x_center, target_y_center, target_width, target_height); 

kernel = kernel_mask(target_width+1, target_height+1, 1);

target_histogram = im_weighted_2D_histogram(16, target_image_rgb, kernel);

target_rect = [target_x_center target_y_center target_width target_height];

history = [target_x_center target_y_center];

%aviobj = avifile('example.avi');

M = [];
for next_frame_number = 85:1:285
%for next_frame_number = 175:1:300
%for next_frame_number = 32:1:232
    next_frame_name = [path '/Frame' num2str(next_frame_number, '%04d') '.png'];
    %next_frame_name = [path '/ThreePastShop1cor' num2str(next_frame_number, '%04d') '.jpg'];
    %next_frame_name = [path '/images0' num2str(next_frame_number, '%04d') '.png'];
    
    candidate_frame = imread(next_frame_name);
    
    y1 = mean_shift(target_histogram, target_rect, candidate_frame, kernel);
    
    history = [history ; y1];
    
    target_rect = [y1(1) y1(2) target_width target_height];
    
    coords = get_coordinates2(y1(1), y1(2), target_width, target_height); 
    
    hold on;
    imshow(candidate_frame);
    rectangle('Position',[y1(1)-(target_width/2), y1(2)-(target_height/2), target_width, target_height],'Curvature',[0.4]);
    plot(history(:,1), history(:,2), 'g-');
    hold off;
    
    saveas(fighandle, [result_path '/FrameSoc' num2str(next_frame_number-84, '%04d')], 'png');
end
