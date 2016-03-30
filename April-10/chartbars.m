bars = 4;
[bb,cc] = size(TS);
ff = fts2mat(TS);
for i = 1:bb
    if mod(i,bars)==0 
            fn(i/bars,1) = sum ([ff(i-bars+1:i,1)]);  %volume
            fn(i/bars,2) = ff(i-bars+1,2);  %open
            fn(i/bars,3) = ff(i,3);  %close
            fn(i/bars,4) = min ([ff(i-bars+1:i,4)]);  %low
            fn(i/bars,5) = max ([ff(i-bars+1:i,5)]);  %high
    end
end