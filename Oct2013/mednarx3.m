% wds = window size, ntl = network layer vector, tst = test sample size
% based on: 1.open 2.high 3.low 4.close 5.vol

%cleaning 0 volume rows first%
[rr,cc] = size(fnc);

j=1;
for i=1:rr
    
    if (fnc(i,5)~=0)
        fn (j,:) = fnc (i,:);
        j = j+1;
    end
end
    
r1 = fn(:,3);
r2 = fn(:,2);
lng = r2-r1;
[ii,jj]= size(lng);
avh = sum(lng)/ii;
clear ii jj;

rsi = rsindex(fn(:,4));
vol = fn(:,5);
opn = fn (:,1);
cls = fn(:,4);
lo = fn(:,3);
hi = fn(:,2);
med = (lo + hi)/2;
tpc = (lo + hi + cls)/3;
wc = (lo + hi + cls + cls)/4;
kprice = sqrt((lo.^2 + hi.^2)/2);

m5 = tsmovavg(med,'s',5, 1);
m10 = tsmovavg(med,'s',10, 1);
m20 = tsmovavg(med,'s',20, 1);
%m50 = tsmovavg(med,'s',50);
%m100 = tsmovavg(med,'s',100);
%[m5,m10] = movavg(fn(:,4),5,10);
%[m20,m50] = movavg(fn(:,4),20,50);
%macdf = macd(fn(:,4));


%tinp = [fts2mat(m5) fts2mat(m10) fts2mat(m20) fts2mat(macdf) fts2mat(rsi) fts2mat(med)];
tinp = [hi m5 m10];
tinp = con2seq(tinp');
targ = con2seq(hi');
t2 = con2seq(hi');

tinp(1:20)=[];
targ(1:20)=[];
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