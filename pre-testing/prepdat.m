% moving prices to a matrix %
prc = fts2mat (TS);

% getting macd %
macdF = macd(TS);
macd_m = fts2mat (macdF);

% getting rsi %
rsiF = rsindex(TS);
rsi_m = fts2mat (rsiF);

% getting the MA's %
mov1F = tsmovavg(TS,'s',10);
mov2F = tsmovavg(TS,'s',20);
mov1_m = fts2mat (mov1F.CLOSE);
mov2_m = fts2mat (mov2F.CLOSE);

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

% creating an unclean ready matrix %
YMatrix = [type macd_m rsi_m TP];

% cleaning out zero rows %
j=1;
for i=1:ro
    if (YMatrix(i,5)~=0)
        ZMatrix(j,1)=YMatrix(i,1);
        ZMatrix(j,2)=YMatrix(i,2);
        ZMatrix(j,3)=YMatrix(i,3);
        ZMatrix(j,4)=YMatrix(i,4);
        ZMatrix(j,5)=YMatrix(i,5);
        j=j+1;
    end
end

% getting inputs and outputs ready %
tinp = ZMatrix(:,1:4);
targ = ZMatrix(:,5);