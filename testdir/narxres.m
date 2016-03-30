x = sim(net,[xin;xout],yi);
l = fts2mat(TS.LOW);
h = fts2mat(TS.HIGH);
plot (l(end-tst+1:end),'-r')
hold on
plot (h(end-tst+1:end),'-b')
hold on
plot (cell2mat(x),'.black')
hold on
plot (cell2mat(xout),'-yellow')

clear hitrate;
for i = 1:tst
    if(cell2mat(x(i))<=h(end-tst+i) && cell2mat(x(i))>=l(end-tst+i))
        hitrate(i)=1;
    else
        hitrate(i)=0;
    end
end

h = (sum(hitrate)/tst)*100