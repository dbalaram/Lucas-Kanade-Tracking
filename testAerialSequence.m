% your code here

load('../data/aerialseq.mat');
[h,w,f] = size(frames);

for i = 1: f-1
    
    It = im2double(frames(:,:,i));
    It1 = im2double(frames(:,:,i+1));
    mask = SubtractDominantMotion(It, It1);
    rgb = zeros(size(mask,1), size(mask,2),3);
%     rgb(:,:,1) = mask;
     rgb(:,:,2) = mask;
%     rgb(:,:,3) = mask;
     Im = imfuse(It,rgb,'blend','Scaling','Joint');
    if (i==30 || i== 60 || i==90 || i ==120 )
    figure();
    imshow(Im);
    end

end


