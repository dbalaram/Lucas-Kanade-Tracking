function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix
p = zeros(1,6);
deltaP = ones(1,6);
[X, Y] =  meshgrid(1:size(It,1),1:size(It,2));
[dx ,dy] = gradient(It);
% unity = ones(size(Y(:)));

while(norm(deltaP) >= 0.1)
    M =[[1+p(1),p(2),p(3)];[p(4),1+p(5),p(6)];[0,0,1]];
    W = warpH(It,M,size(It1));
%     interp2(It1,)
    Grad =[(dx(:) .* X(:)) (dx(:).*Y(:)) dx(:) (dy(:) .* X(:)) (dy(:).*Y(:)) dy(:) ]; 
    [dx ,dy] =  gradient(W);
     
    H = Grad' * Grad;
    Error =  It1 - W;
    e = Error(:);
    ErrGr = Grad' * e;
    deltaP =  inv(H) * ErrGr ;
    
    p = p - deltaP';
  
end    
end
