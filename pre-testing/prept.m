% moving prices to a matrix %
prc = fts2mat (TS);

% getting macd %
macdF = macd(TS);
macd_m = fts2mat (macdF);

% getting rsi %
rsiF = rsindex(TS);
rsi_m = fts2mat (rsiF);

% getting the MA's %
mov1F = tsmovavg(TS,'e',21);
mov2F = tsmovavg(TS,'e',34);
mov1_m = fts2mat (mov1F.CLOSE);
mov2_m = fts2mat (mov2F.CLOSE);

% adding 10 other MA's for accuracy %
n1F = tsmovavg(TS,'s',5);
n1 = fts2mat (n1F.CLOSE);

n2F = tsmovavg(TS,'s',8);
n2 = fts2mat (n2F.CLOSE);

n3F = tsmovavg(TS,'s',13);
n3 = fts2mat (n3F.CLOSE);

n4F = tsmovavg(TS,'s',21);
n4 = fts2mat (n4F.CLOSE);

n5F = tsmovavg(TS,'s',34);
n5 = fts2mat (n4F.CLOSE);

n6F = tsmovavg(TS,'s',55);
n6 = fts2mat (n6F.CLOSE);

n7F = tsmovavg(TS,'s',89);
n7 = fts2mat (n7F.CLOSE);

% MA's difference for crossing points %
mvdiff = mov1_m - mov2_m;

% getting the 1's and 0's
[ro,co] = size(mvdiff);
pol(1)=0;
for i=2:ro
    pol(i)=hardlim(mvdiff(i)/mvdiff(i-1)*-1);
end
pol = pol';

% getting the optimal TP levels

for j=1:ro
    if pol(j)==0
        TP(j)=0;
        type(j)=0;
    elseif pol(j)==1 && mov1_m(j)<mov2_m(j) % downcrossing %
        k=j+1;
        TP(j)=prc(j,3)-prc(k,4);
        k=j+2;
        while(pol(k-1)~=1 && k<=ro)
            if ((prc(j,3)-prc(k,4))>TP(j))
                TP(j)= prc(j,3)-prc(k,4);
            end
            k=k+1;
        end
        type(j)=-1;
    elseif pol(j)==1 && mov1_m(j)>mov2_m(j) % upcrossing %
        k=j+1;
        TP(j)=prc(k,5)-prc(j,3);
        k=j+2;
        while(pol(k-1)~=1 && k<=ro)
            if((prc(k,5)-prc(j,3)>TP(j)))
                TP(j)=prc(k,5)-prc(j,3);
            end
            k=k+1;
        end
        type(j)=1;
    end
end

TP = TP';
type = type';

% creating the median 20,50,100 trend %

for i = 1:20
    ta(i)=NaN;
end

for i = 21:ro
    ta(i)=((prc(i,5)+prc(i,4))/2 - (prc(i-20,5)+prc(i-20,4))/2);
end

for i = 1:50
    tb(i)=NaN;
end

for i = 51:ro
    tb(i)=((prc(i,5)+prc(i,4))/2 - (prc(i-50,5)+prc(i-50,4))/2);
end

for i = 1:100
    tc(i)=NaN;
end

for i = 101:ro
    tc(i)=((prc(i,5)+prc(i,4))/2 - (prc(i-100,5)+prc(i-100,4))/2);
end

% creating an unclean ready matrix %
ta = ta';
tb = tb';
tc = tc';
YMatrix = [type n1 n2 n3 n4 n5 n6 n7 ta tb tc macd_m rsi_m TP];
YMatrix(1:100,:)=[];

% cleaning out zero rows %
j=1;
for i=1:ro-100
    if (YMatrix(i,15)~=0)
        ZMatrix(j,1)=YMatrix(i,1);
        ZMatrix(j,2)=YMatrix(i,2);
        ZMatrix(j,3)=YMatrix(i,3);
        ZMatrix(j,4)=YMatrix(i,4);
        ZMatrix(j,5)=YMatrix(i,5);
        ZMatrix(j,6)=YMatrix(i,6);
        ZMatrix(j,7)=YMatrix(i,7);
        ZMatrix(j,8)=YMatrix(i,8);
        ZMatrix(j,9)=YMatrix(i,9);
        ZMatrix(j,10)=YMatrix(i,10);
        ZMatrix(j,11)=YMatrix(i,11);
        ZMatrix(j,12)=YMatrix(i,12);
        ZMatrix(j,13)=YMatrix(i,13);
        ZMatrix(j,14)=YMatrix(i,14);
        ZMatrix(j,15)=YMatrix(i,15);
        j=j+1;
    end
end

% getting inputs and outputs ready %
tinp = ZMatrix(:,1:14);
targ = ZMatrix(:,15);

tinp = tinp';
targ = targ';