% wds = window size, ntl = network layer vector, tst = test sample size
lng = TS.HIGH - TS.LOW;
lng = fts2mat(lng);
[ii,jj]= size(lng);
avh = sum(lng)/ii;
clear ii jj trg24;

med = (TS.HIGH + TS.LOW)/2;
%m3 = tsmovavg(med,'s',3);
%m5 = tsmovavg(med,'s',5);
m10 = tsmovavg(med,'s',10);
m20 = tsmovavg(med,'s',20);
m50 = tsmovavg(med,'s',50);
m100 = tsmovavg(med,'s',100);
m200 = tsmovavg(med,'s',200);
%m300 = tsmovavg(med,'s',300);
%macdf = macd(TS);
%rsi = rsindex(TS);
cls = fts2mat(TS.CLOSE);
lo = fts2mat(TS.LOW);
hi = fts2mat(TS.HIGH);

%[h, hs] = mapminmax (hi');
%[l, ls] = mapminmax (lo');
%[c, cs] = mapminmax (cls');
%[mv5, mv5s] = mapminmax (fts2mat(m5'));
%[md, mds] = mapminmax (fts2mat(med'));

%[b,c] = size(cls);
%for i = 1:b-24
%    trg24(i)=cls(i+24);
%end


%tinp = [fts2mat(med)];
tinp = [hi lo cls];
tinp = con2seq(tinp');
targ = con2seq(fts2mat(med)');


tinp(1:10)=[];
targ(1:10)=[];

%tinp(b-73:end)=[];

xin = tinp(end-tst+1:end);
xout = targ(end-tst+1:end);
tinp (end-tst+1:end)=[];
targ (end-tst+1:end)=[];
d1 = [1:wds];
d2 = [1:wds];
Pi = [tinp(1:wds);targ(1:wds)];
p = tinp(wds+1:end);
t = targ(wds+1:end);
yi = [tinp(end-wds+1:end);targ(end-wds+1:end)];
net = newnarxsp(p,t,d1,d2,ntl);