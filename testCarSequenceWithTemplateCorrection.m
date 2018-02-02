% your code here
load('../data/carseq.mat');
rect0 = [60, 117, 146, 152];
rect = [60, 117, 146, 152];
w_main = abs(rect(1) - rect(3));
h_main = abs(rect(2) - rect(4));
[h,w,f] = size(frames);
rects = zeros(f, 4);
rects(1, :) = rect0;
width_reg = abs(rect0(1) - rect0(3));
height_reg = abs(rect0(2) - rect0(4));
rect1 = [60, 117, 146, 152];
rectf = [60, 117, 146, 152];
F1 = im2double(frames(:,:,1));
for i = 1:f-1
    display(i)
  
    It = im2double(frames(:,:,i));
    It1 = im2double(frames(:,:,i+1));
    
    [d1,d2] = LucasKanade(It, It1, rect);
    rect = [rect(1)+dpx, rect(2)+dpy ,rect(3)+dpx ,rect(4)+dpy];
    rect = round(rect);
    
   [dpx, dpy] = LucasKanade(It, It1, rectf);
    
   rect1 = [rect1(1)+dpx, rect1(2)+dpy ,rect1(3)+dpx ,rect1(4)+dpy];
   rect1 = round(rect1);
    
   [dpx2,dpy2] = LucasKanade2(F1, It1,rect0,[(rect1(1)-rect0(1)),(rect1(2)-rect0(2))]);
    
    dpx2 = dpx2 - (rect1(1) - rect0(1));
    dpy2 = dpy2 - (rect1(2)- rect0(2));
    
    pcurrent = [dpx2,dpy2];
    pold = [dpx,dpy];
    if (norm(pcurrent - pold) < 3)
        pnew = round(pcurrent);
    else
        pnew= round(pold);
    end
    img = im2double(frames(:,:,i));
    imshow(img);
    hold on;
    rectangle('Position',[rectf(1), rectf(2), width_reg, height_reg], 'LineWidth',1, 'EdgeColor', 'y');
    rectangle('Position',[rect(1), rect(2), width_reg, height_reg], 'LineWidth',1, 'EdgeColor', 'g');
    hold off;
    pause(0.1);
    
    if (i==1 || i== 100 || i==200 || i ==300 || i == 400)
        figure();
        imshow(img);
        hold on;
        rectangle('Position',[rectf(1), rectf(2), width_reg, height_reg], 'LineWidth',2, 'EdgeColor', 'g');
        rectangle('Position',[rect(1), rect(2), width_reg, height_reg], 'LineWidth',2, 'EdgeColor', 'g');
        hold off;
     end
    
    rects(i+1, :) = rect1;
    rectf = [rectf(1)+pnew(1), rectf(2)+pnew(2) ,rectf(3)+pnew(1) ,rectf(4)+pnew(2)];
    rect1 = rectf;
end

save('carseqrects-wcrt.mat', 'rects');
