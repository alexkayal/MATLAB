clear tm i j d m z dif val per siz cl k y y1 y2 pft;
per= 100; per2 = 200; siz = 40000;
for i = 1:siz
    tm(i)=0;
    if mod(i,10000)== 0 
        i 
    end
end

d = rand;

if (d>0.5) tm(1)=1; else tm(1) = -1;
end

if (d>0.5) x(1)=1; else x(1)=-1;
end

for j = 2:siz
d = rand;

    if mod(j,10000)== 0 
        j 
    end
if (d>0.5) tm(j)=tm(j-1)+1; else tm(j)=tm(j-1)-1;

end

if (d>0.5) x(j)=1; else x(j)=-1;

end

end

m = tsmovavg(tm,'e',per);
m2 = tsmovavg(tm,'e',per2);
%m3 = tsmovavg(tm,'e',100);

plot (tm); 
hold on; 
%plot(m,'-r'); 
%hold on;
%plot(m2,'-g');
%hold off; 
%plot(m3,'-g');

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


    
z = [tm' m' dif val' cl'];

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