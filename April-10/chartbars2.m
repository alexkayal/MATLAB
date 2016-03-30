bars = 48; 

[bb,cc] = size(mtrx);

ff(:,1) = mtrx(:,5);
ff(:,2) = mtrx(:,1);
ff(:,3) = mtrx(:,4);
ff(:,4) = mtrx(:,3);
ff(:,5) = mtrx(:,2);

for i = 1:bb
    if mod(i,bars)==0 
            fn(i/bars,1) = sum ([ff(i-bars+1:i,1)]);  %volume
            fn(i/bars,2) = ff(i-bars+1,2);  %open
            fn(i/bars,3) = ff(i,3);  %close
            fn(i/bars,4) = min ([ff(i-bars+1:i,4)]);  %low
            fn(i/bars,5) = max ([ff(i-bars+1:i,5)]);  %high
    end
end