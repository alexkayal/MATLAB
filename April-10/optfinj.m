% Optim final

clear swipe type pol TP YMatrix ZMatrix v;
prc = fts2mat (TS);

% getting the MA's
mov1F = tsmovavg(TS,'e',7);
mov2F = tsmovavg(TS,'e',15);
mov1_m = fts2mat (mov1F.CLOSE);
mov2_m = fts2mat (mov2F.CLOSE);

% getting the difference between the MA's
mvdiff = mov1_m - mov2_m;

% getting the cross points
[ro,co]=size(mvdiff);
pol(1)=0;
for i=2:ro-1
    pol(i)=hardlim(mvdiff(i)/mvdiff(i-1)*-1);
end
pol(ro)=0; % prevent last point from being a cross point %
pol = pol';

% getting out the matrix (type, TP, swipe, etc..)

for j = 1:ro

    if pol(j) == 0; % no crossing %
        TP(j)=0; swipe(j)=0; type(j)=0;
        
    elseif pol(j) == 1 && mov1_m(j)<mov2_m(j) % downcrossing %
        type(j)=-1; % assign type %
        TP(j) = prc(j,3) - prc(j+1,4); % assign initial TP to the current CLOSE - next LOW %
                
        %run the loop%
        k = j+1;
        while (k<=ro && pol(k)~=1)
            if (prc(j,3)-prc(k,4)>TP(j)) TP(j)= prc(j,3)-prc(k,4);
            end
            k=k+1; %check for right swipe val%
        end
        
        if (k<=ro) swipe(j)=prc(j,3)-prc(k,3); else swipe(j)=0; end
       
        
    elseif pol(j) == 1 && mov1_m(j)>mov2_m(j) %upcrossing%
        type(j)=1; % assign type %
        TP(j) = prc(j+1,5) - prc(j,3); % assign initial TP to the current CLOSE - next LOW %
        
        %run the loop%
        k = j+1;
        while (k<=ro && pol(k)~=1)
            if (prc(k,5)-prc(j,3)>TP(j)) TP(j)= prc(k,5)-prc(j,3);
            end
            k=k+1; %check for right swipe val%
        end
        if (k<=ro) swipe(j)=prc(k,3)-prc(j,3); else swipe(j)=0; end
    end
    
    
end

TP = TP';
swipe = swipe';
type = type';

r1 = rsindex(prc(:,3),3);
r2 = rsindex(prc(:,3),5);
r3 = rsindex(prc(:,3),8);
r4 = rsindex(prc(:,3),13);
r5 = rsindex(prc(:,3),21);
r6 = rsindex(prc(:,3),34);
r7 = rsindex(prc(:,3),55);
r8 = rsindex(prc(:,3),89);
rx = [r1 r2 r3 r4 r5 r6 r7 r8];

m1 = fts2mat(tsmovavg(TS.CLOSE,'s',3));
m2 = fts2mat(tsmovavg(TS.CLOSE,'s',5));
m3 = fts2mat(tsmovavg(TS.CLOSE,'s',8));
m4 = fts2mat(tsmovavg(TS.CLOSE,'s',13));
m5 = fts2mat(tsmovavg(TS.CLOSE,'s',21));
m6 = fts2mat(tsmovavg(TS.CLOSE,'s',34));
m7 = fts2mat(tsmovavg(TS.CLOSE,'s',50));
m8 = fts2mat(tsmovavg(TS.CLOSE,'s',75));
m9 = fts2mat(tsmovavg(TS.CLOSE,'s',100));
m10 = fts2mat(tsmovavg(TS.CLOSE,'s',150));
m11 = fts2mat(tsmovavg(TS.CLOSE,'s',200));
m12 = fts2mat(tsmovavg(TS.CLOSE,'s',250));
m13 = fts2mat(tsmovavg(TS.CLOSE,'s',300));
mx = [m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13];

% creatind the stddev matrix %

% stddev8%
for i = 1:7
    s0(i)=NaN;
end
for i = 8:ro
    s0(i)=nanstd(prc(i-7:i,3));
end

% stddev13%
for i = 1:12
    s1(i)=NaN;
end
for i = 13:ro
    s1(i)=nanstd(prc(i-12:i,3));
end

% stddev21%
for i = 1:20
    s2(i)=NaN;
end
for i = 21:ro
    s2(i)=nanstd(prc(i-20:i,3));
end

% stddev34%
for i = 1:33
    s3(i)=NaN;
end
for i = 34:ro
    s3(i)=nanstd(prc(i-33:i,3));
end

% stddev55%
for i = 1:54
    s4(i)=NaN;
end
for i = 55:ro
    s4(i)=nanstd(prc(i-54:i,3));
end

% stddev89%
for i = 1:88
    s5(i)=NaN;
end
for i = 89:ro
    s5(i)=nanstd(prc(i-88:i,3));
end

% stddev144%
for i = 1:143
    s6(i)=NaN;
end
for i = 144:ro
    s6(i)=nanstd(prc(i-143:i,3));
end

sx = [s0' s1' s2' s3' s4' s5' s6'];

% creating an unclean ready matrix %
YMatrix = [type mx rx sx TP*100 swipe*100];

% cleaning out zero rows %
j=1;
for i=1:ro
    if (YMatrix(i,30)~=0)
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
        ZMatrix(j,16)=YMatrix(i,16);
        ZMatrix(j,17)=YMatrix(i,17);
        ZMatrix(j,18)=YMatrix(i,18);
        ZMatrix(j,19)=YMatrix(i,19);
        ZMatrix(j,20)=YMatrix(i,20);
        ZMatrix(j,21)=YMatrix(i,21);
        ZMatrix(j,22)=YMatrix(i,22);
        ZMatrix(j,23)=YMatrix(i,23);
        ZMatrix(j,24)=YMatrix(i,24);
        ZMatrix(j,25)=YMatrix(i,25);
        ZMatrix(j,26)=YMatrix(i,26);
        ZMatrix(j,27)=YMatrix(i,27);
        ZMatrix(j,28)=YMatrix(i,28);
        ZMatrix(j,29)=YMatrix(i,29);
        ZMatrix(j,30)=YMatrix(i,30);
        ZMatrix(j,31)=YMatrix(i,31);
        j=j+1;
    end
end

p = ZMatrix(:,1:29);
t = ZMatrix(:,30);
v = ZMatrix(:,31);
p = p'; t = t'; v = v';
sv = hardlim(v-0.01);
