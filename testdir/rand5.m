clear tm i j d m z dif val per siz cl k y y1 y2 pft rr cc siz2;
per= 10; 

tm = fts2mat(TS.CLOSE);
[siz,siz2] = size(tm);

m = fts2mat(tsmovavg(TS.CLOSE,'e',per));
%m2 = tsmovavg(tm,'e',200);
%m3 = tsmovavg(tm,'e',100);

plot (tm); 
hold on; 
plot(m,'-r'); 
hold off; 
%plot(m2,'-b'); plot(m3,'-g');

dif = tm' - m';
for i =per+1:siz
if (dif(i-1)/dif(i)<0) && dif(i-1)>dif(i) val(i)=-1;
elseif (dif(i-1)/dif(i)<0) && dif(i-1)<dif(i) val(i)=1;
else val(i)=0;
end
end

for i =per+1:siz
    if (val(i)~=0) cl(i)=tm(i);
    else cl(i)=0;
    end
end


    
%z = [tm' m' dif val' cl'];

k= 1;
for i =1:siz
    if (val(i)~=0) 
        y1(k)=val(i); 
        y2(k)=cl(i);
        k = k+1;
    end
end

y = [y1' y2'];
[rr,cc] = size(y);

for i = 1:rr-1
if (y1(i)<0)
    pft(i)=y2(i)-y2(i+1);
else 
    pft(i)=y2(i+1)-y2(i);
end
end

sum(pft)