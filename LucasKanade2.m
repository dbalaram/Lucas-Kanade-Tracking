function [dp_x, dp_y] = LucasKanade2(It, It1,rect, p)


[x_r,y_r] = meshgrid(rect(1):rect(3),rect(2):rect(4));
image_template = interp2(It,x_r,y_r); %linear interpolation

% image_template = It(rect(2):rect(4),rect(1):rect(3)); % y,x not x,y

%we have I so now we calculate gradient of I
[GIx,GIy] = gradient(image_template);
J = [[1,0];[0,1]];
GradI = [GIx(:),GIy(:)];
%we don't calculate Jacobian because it is an identity function
%We now have to calculate the hessian
G = GradI * J;
H = G' * G;
%jacobian is [1,0;0,1]

% p = [0,0];
deltaP = [1,1];
while(norm(deltaP) >= 0.01)
    
    %generating the warped image
    x_new = rect(1) : rect(3) ;
    x_new = x_new + p(1,1);
    y_new = rect(2) : rect(4) ;
    y_new = y_new + p(1,2);
    [X,Y] = meshgrid(x_new,y_new);
    warpI = interp2(It1,X,Y);
    
    Error =  warpI - image_template;
    e = Error(:);
    ErrGr = G' * e;
    deltaP =  inv(H) * ErrGr ;
    
    p = p - deltaP';
end
dp_x= p(1);
dp_y= p(2);
end


