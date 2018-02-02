% your code here

load('../data/carseq.mat');
rect = [60, 117, 146, 152];
[h,w,f] = size(frames);
rects = zeros(f, 4);
rects(1, :) = rect;
width_reg = abs(rect(1) - rect(3));
height_reg = abs(rect(2) - rect(4));

for i = 1:f-1
    img = im2double(frames(:,:,i));
    imshow(img);
        hold on;
        rectangle('Position',[rect(1), rect(2), width_reg, height_reg], 'LineWidth',3, 'EdgeColor', 'g');
%         hold off;
        pause(0.1);
    It = im2double(frames(:,:,i));
    It1 = im2double(frames(:,:,i+1));
    [dpx, dpy] = LucasKanade(It, It1, rect);
    
    rect = [rect(1)+dpx, rect(2)+dpy ,rect(3)+dpx ,rect(4)+dpy];
    rect = round(rect);
    
     if (i==1 || i== 100 || i==200 || i ==300 || i == 400)
        figure();
        imshow(img);
        hold on;
        rectangle('Position',[rect(1), rect(2), width_reg, height_reg], 'LineWidth',3, 'EdgeColor', 'g');
        hold off;
     end
    
    rects(i+1, :) = rect;
    
end

save('carseqrects.mat', 'rects');
