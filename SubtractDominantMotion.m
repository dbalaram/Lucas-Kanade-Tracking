function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size
M = LucasKanadeAffine(im2double(image1), im2double(image2));

W = warpH(image1,M,size(image2));

diff = abs(W - image1);
mask = diff;
%converting to binary with threshold got from graythresh

threshold = 0.09;
mask(mask>threshold) = 1;
mask(mask<threshold) = 0;
%remove big structures that are not reuired

%remove noise in both dimensions

%create 8 disks that represent the object the object and make sure it fits
%properly
blob = strel('diamond',6);
mask = imdilate(mask, blob);
mask = imerode(mask, blob);

blob2 = strel('diamond',4);
mask = imdilate(mask, blob2);
mask = imerode(mask, blob2);
mask = mask - bwareaopen(mask,600);             
