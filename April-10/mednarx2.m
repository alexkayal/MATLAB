% wds = window size, ntl = network layer vector, tst = test sample size
r1 = fn(:,4);
r2 = fn(:,5);
lng = r2-r1;
[ii,jj]= size(lng);
avh = sum(lng)/ii;
clear ii jj;
%m5 = tsmovavg(med,'s',5);
%m10 = tsmovavg(med,'s',10);
%m20 = tsmovavg(med,'s',20);
%m50 = tsmovavg(med,'s',50);
%m100 = tsmovavg(med,'s',100);
[m5,m10] = movavg(fn(:,3),5,10);
[m20,m50] = movavg(fn(:,3),20,50);
%macdf = macd(fn(:,3));
rsi = rsindex(fn(:,3));
volm = fn(:,1);
opn = fn (:,2);
cls = fn(:,3);
lo = fn(:,4);
hi = fn(:,5);
med = (lo + hi)/2;
tpc = (lo + hi + cls)/3;
wc = (lo + hi + cls + cls)/4;
kprice = sqrt((lo.^2 + hi.^2)/2);

%tinp = [fts2mat(m5) fts2mat(m10) fts2mat(m20) fts2mat(macdf) fts2mat(rsi) fts2mat(med)];
tinp = [m10 m20 m50 rsi volm];
tinp = con2seq(tinp');
targ = con2seq(cls');
t2 = con2seq(cls');

tinp(1:50)=[];
targ(1:50)=[];
xin = tinp(end-tst+1:end);
xout = targ(end-tst+1:end);
xcomp = t2(end-tst+1:end);
lngt = lng(end-tst+1:end)';



tinp (end-tst+1:end)=[];
targ (end-tst+1:end)=[];
d1 = [1:wds];
d2 = [1:wds];
Pi = [tinp(1:wds);targ(1:wds)];
p = tinp(wds+1:end);
t = targ(wds+1:end);
yi = [tinp(end-wds+1:end);targ(end-wds+1:end)];
net = newnarxsp(p,t,d1,d2,ntl);