x = sim(net,[xin;xout],yi);
%l = fts2mat(TS.LOW);
%h = fts2mat(TS.HIGH);
tx = cell2mat(x)';
tlo = Low(end-tst+1:end);
thi = High(end-tst+1:end);
plot (tlo,'-green')
hold on
plot (thi,'-green')
hold on
plot (tx,'.black')
hold on
plot (cell2mat(xout),'-red')
hold off

e = cell2mat(x) - cell2mat(xout); sum(abs(e))/tst
e2 = cell2mat(x) - cell2mat(xcomp); sum(abs(e2))/tst

clear hitrate;
for i = 1:tst
    if(cell2mat(x(i))<=thi(end-tst+i) && cell2mat(x(i))>=tlo(end-tst+i))
        hitrate(i)=1;
    else
        hitrate(i)=0;
    end
end

h = (sum(hitrate)/tst)*100
vl = sum(lngt)/tst