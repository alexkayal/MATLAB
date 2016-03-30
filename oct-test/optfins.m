% Optim final

clear swipe type pol TP YYY ZZZ v;
prc = fts2mat (TS);

% getting the MA's
mov1F = tsmovavg(TS,'e',5);
mov2F = tsmovavg(TS,'e',10);
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
YYY = [type mx rx sx TP*1000 swipe*1000];

% cleaning out zero rows %
j=1;
for i=1:ro
    if (YYY(i,30)~=0)
        ZZZ(j,1)=YYY(i,1);
        ZZZ(j,2)=YYY(i,2);
        ZZZ(j,3)=YYY(i,3);
        ZZZ(j,4)=YYY(i,4);
        ZZZ(j,5)=YYY(i,5);
        ZZZ(j,6)=YYY(i,6);
        ZZZ(j,7)=YYY(i,7);
        ZZZ(j,8)=YYY(i,8);
        ZZZ(j,9)=YYY(i,9);
        ZZZ(j,10)=YYY(i,10);
        ZZZ(j,11)=YYY(i,11);
        ZZZ(j,12)=YYY(i,12);
        ZZZ(j,13)=YYY(i,13);
        ZZZ(j,14)=YYY(i,14);
        ZZZ(j,15)=YYY(i,15);
        ZZZ(j,16)=YYY(i,16);
        ZZZ(j,17)=YYY(i,17);
        ZZZ(j,18)=YYY(i,18);
        ZZZ(j,19)=YYY(i,19);
        ZZZ(j,20)=YYY(i,20);
        ZZZ(j,21)=YYY(i,21);
        ZZZ(j,22)=YYY(i,22);
        ZZZ(j,23)=YYY(i,23);
        ZZZ(j,24)=YYY(i,24);
        ZZZ(j,25)=YYY(i,25);
        ZZZ(j,26)=YYY(i,26);
        ZZZ(j,27)=YYY(i,27);
        ZZZ(j,28)=YYY(i,28);
        ZZZ(j,29)=YYY(i,29);
        ZZZ(j,30)=YYY(i,30);
        ZZZ(j,31)=YYY(i,31);
        j=j+1;
    end
end

p = ZZZ(:,1:29);
t = ZZZ(:,30);
v = ZZZ(:,31);
p = p'; t = t'; v = v';
sv = hardlim(v-0.01);
