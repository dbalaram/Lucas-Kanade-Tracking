load('../data/aerialseq.mat');

    img1 = im2double(frames(:,:,1));
    img2 = im2double(frames(:,:,2));
   
    mask = SubtractDominantMotion(img1, img2);