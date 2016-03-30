%   Algorithm
%   
%   1. Calculate entry points. Default method: SMA(10) and SMA(20) crossing.
%   2. Calculate Max profit level from every cross.
%   3. Calculate Profit/Loss by the time of reverse point/next crossing.

% moving prices to a matrix %
prc = fts2mat (TS);

% getting the MA's %
mov1F = tsmovavg(TS,'e',21);
mov2F = tsmovavg(TS,'e',34);
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

% getting the optimal TP and swipe levels

for j=1:ro
    if pol(j)==0
        TP(j)=0;
        swipe(j)=0;
    elseif pol(j)==1 && mov1_m(j)<mov2_m(j) % downcrossing %
        k=j+1;
        TP(j)=prc(j,3)-prc(k,4);
        k=j+2;
        while(pol(k-1)~=1 && k<=ro)
            if ((prc(j,3)-prc(k,4))>TP(j))
                TP(j)= prc(j,3)-prc(k,4);
            end
            swipe(j)=prc(j,3)-prc(k,3);
            k=k+1;
        end
    elseif pol(j)==1 && mov1_m(j)>mov2_m(j) % upcrossing %
        k=j+1;
        TP(j)=prc(k,5)-prc(j,3);
        k=j+2;
        while(pol(k-1)~=1 && k<=ro)
            if((prc(k,5)-prc(j,3)>TP(j)))
                TP(j)=prc(k,5)-prc(j,3);
            end
            k=k+1;
            swipe(j)=prc(k-1,3)-prc(j,3);
        end
    end
end

TP = TP';
swipe = swipe';

% creating an unclean ready matrix %
YMatrix = [prc TP*10000 swipe*10000];

% cleaning out zero rows %
j=1;
for i=1:ro
    if (YMatrix(i,6)~=0)
        ZMatrix(j,1)=YMatrix(i,2);
        ZMatrix(j,2)=YMatrix(i,3);
        ZMatrix(j,3)=YMatrix(i,4);
        ZMatrix(j,4)=YMatrix(i,5);
        ZMatrix(j,5)=YMatrix(i,6);
        ZMatrix(j,6)=YMatrix(i,7);
        j=j+1;
    end
end
