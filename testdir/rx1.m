% rx1 : a system that buys and sells randomly.
clear cls r r2 c c2 i j z parray X Y Z;
clear m1 m2 m3 m4 rsi1 rsi2 rsi3 s1 s2 s3 ta

cls = fts2mat(TS.CLOSE);
[r,c] = size(cls);

% getting TA's 

rsi1 = rsindex(cls,5);
rsi2 = rsindex(cls,14);
rsi3 = rsindex(cls,21);
m1 = tsmovavg(cls','s',5);
m2 = tsmovavg(cls','s',10);
m3 = tsmovavg(cls','s',20);
m4 = tsmovavg(cls','s',50);

% stddev13%
for i = 1:12
    s1(i)=NaN;
end
for i = 13:r
    s1(i)=nanstd(cls(i-12:i));
end

% stddev21%
for i = 1:20
    s2(i)=NaN;
end
for i = 21:r
    s2(i)=nanstd(cls(i-20:i));
end

% stddev34%
for i = 1:33
    s3(i)=NaN;
end
for i = 34:r
    s3(i)=nanstd(cls(i-33:i));
end

ta = [m1' m2' m3' m4' rsi1 rsi2 rsi3 s1' s2' s3'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


freq = 80;

parry (1:r,1:2)=0;

rand1 = rand;
if rand>0.5 p0(1)= 1; else p0(1)= -1; end;
p0(2) = p0(1)*-1;
%j = 1;

for i = 1:r
    rand1 = rand*100;
    if rand1 > freq;
        parray(i,1) = cls(i);
        parray(i,2) = p0(mod(i,2)+1)*-1;
    else parray(i,1)=0; parray(i,2)=0;
    end
end

% remove empty NaNs
ta(1:49,:)=[]; parray(1:49,:)=[];
X = [ta parray];

[r2,c2] = size(X);
j=1;
for i = 1:r2
    if X(i,12)~=0
        Y(j,:)=X(i,:);
        j = j+1;
    end
end

%%%%%%%%%%%% delete all below

for i = 1:j-2
    Z(i)= (Y(i+1,11) - Y(i,11))*Y(i,12);
end
Y(j-1,:) = [];

Z = Z*10000;
W = hardlim(Z-0.01);

tinp = Y';
targ = W';