clear rr i j proxim p
D = TS.CLOSE - TS.OPEN;
d = fts2mat(D);
[rr,cc] = size (d);

for i = 1:rr
if d(i)>0 dx(i)=1;
elseif d(i)<0 dx(i)=0;
else dx(i)=hardlim(rand-0.5);
end
end

for j = 1:100
    j
    for i = 1:rr-j
        if dx(i+j)==dx(i)
        p(i,j)=1;
        else
        p(i,j)=0;
        end
    end
    proxim(j) = sum(p(:,j))/(rr-j);
    
end