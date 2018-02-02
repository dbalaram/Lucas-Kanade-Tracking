% your code here
load('../data/sylvbases.mat');
load('../data/sylvseq.mat');
rect_b = [102,62,156,108];
rect = [102,62,156,108];

[h,w,f] = size(frames);

rects = zeros(f, 4);
rects(1, :) = rect;

width_reg = abs(rect(1) - rect(3));
height_reg = abs(rect(2) - rect(4));

w_b = abs(rect_b(1) - rect_b(3));
h_b = abs(rect_b(2) - rect_b(4));

for i = 1:f-1
    
    
    It = im2double(frames(:,:,i));
    It1 = im2double(frames(:,:,i+1));
    
    [dpx, dpy] = LucasKanade(It, It1, rect);
    [dpx_b, dpy_b] = LucasKanadeBasis(It, It1, rect_b,bases);
    
    img = im2double(frames(:,:,i));
    imshow(img);
    hold on;
    rectangle('Position',[rect(1), rect(2), width_reg, height_reg], 'LineWidth',1, 'EdgeColor', 'r');
    rectangle('Position',[rect_b(1), rect_b(2), w_b, h_b], 'LineWidth',1, 'EdgeColor', 'y');
    pause(0.1);
    
    rect_b = [rect_b(1)+dpx_b, rect_b(2)+dpy_b ,rect_b(3)+dpx_b ,rect_b(4)+dpy_b];
    rect_b = round(rect_b);
    
    rect = [rect(1)+dpx, rect(2)+dpy ,rect(3)+dpx ,rect(4)+dpy];
    rect = round(rect);
    
     if (i==1 || i== 350 || i==200 || i ==300 || i == 400)
        figure();
        imshow(img);
        hold on;
        rectangle('Position',[rect(1), rect(2), width_reg, height_reg], 'LineWidth',1, 'EdgeColor', 'g');
        rectangle('Position',[rect_b(1), rect_b(2), width_reg, height_reg], 'LineWidth',1, 'EdgeColor', 'g');
        hold off;
     end
    
    rects(i+1, :) = rect_b;
    
end

save('sylvseqrects.mat', 'rects');
