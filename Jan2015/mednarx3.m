% wds = window size, ntl = network layer vector, tst = test sample size

%cleaning 0 volume rows first%
[r,c] = size(Close);

for i=1:r
    
    if (Volume(i)==0)
        Close(i)=[];
        High(i)=[];
        Low(i)=[];
        Open(i)=[];
        Time(i)=[];
        Volume(i)=[];
    end
end
    
lng = High-Low;
[i,j]= size(lng);
avh = sum(lng)/i;
clear i j;

RSI = rsindex(Close);
Median = (Low + High)/2;
TypicalClsoe = (Low + High + Close)/3;
WeightedClose = (Low + High + Close + Close)/4;
KPrice = sqrt((Low.^2 + High.^2)/2);

m5 = tsmovavg(Close,'s',5, 1);
m10 = tsmovavg(Close,'s',10, 1);
m20 = tsmovavg(Close,'s',20, 1);
m30 = tsmovavg(Close,'s',30, 1);
%macdf = macd(fn(:,4));


%tinp = [fts2mat(m5) fts2mat(m10) fts2mat(m20) fts2mat(macdf) fts2mat(rsi) fts2mat(med)];
tinp = [Median m5 m10];
tinp = con2seq(tinp');
targ = con2seq(Median');
t2 = con2seq(Median');

tinp(1:10)=[];
targ(1:10)=[];
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
net = newnarxsp(p,t,d1,d2,ntl); %create network
net = train(net,[p;t],t,Pi); %train network