g = ZMatrix;
c = 1;

for i = 1:580

    if (mod(i,10)==1)
    
        ZMatrix = g(i:i+9,:);
        testotp;
        [a,b] = max(profit(1:100));
        N(c) = b;
        c= c+1;
    end
end