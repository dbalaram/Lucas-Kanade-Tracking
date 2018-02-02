function [dp_x,dp_y] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [dp_x,dp_y] in the x- and y-directions.
[h,w,d] = size(bases);
bases =  reshape(bases, [(h*w),d]);
[x_r,y_r] = meshgrid(rect(1):rect(3),rect(2):rect(4));
image_template = interp2(It,x_r,y_r); %linear interpolation

% image_template = It(rect(2):rect(4),rect(1):rect(3)); % y,x not x,y

%we have I so now we calculate gradient of I
[GIx,GIy] = gradient(image_template);

GradI = [GIx(:),GIy(:)];
%we don't calculate Jacobian because it is an identity function
%We now have to calculate the hessian
G = GradI ;
%Jacobian is basically the bases
G2 = bases' * G;
H = (G' * G) -  (G2' * G2);


p = [0,0];
deltaP = [1,1];
while(norm(deltaP) >= 0.01)
    
   
    x_new = rect(1) : rect(3) ;
    x_new = x_new + p(1,1);
    y_new = rect(2) : rect(4) ;
    y_new = y_new + p(1,2);
     %generating the warped image
    [X,Y] = meshgrid(x_new,y_new);
    warpI = interp2(It1,X,Y);
    
    Error =  warpI - image_template;
    e = Error(:);
    ErrGr = G' * e - G2'  * (bases'*e);
    deltaP =  inv(H) * ErrGr ;
    
    p = p - deltaP';
end
dp_x= p(1);
dp_y= p(2);
end


