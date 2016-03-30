[b,c] = size (TS);
cls = fts2mat(TS.CLOSE);

% mov avg 3
tm3 = tsmovavg(TS.CLOSE, 's', 3);
m3 = fts2mat(tm3);
dif3 = cls-m3;
for i = 2:b
if (dif3(i)*dif3(i-1) < 0)
crs3(i)=1;
else
crs3(i)=0;
end
end

% mov avg 5
tm5 = tsmovavg(TS.CLOSE, 's', 5);
m5 = fts2mat(tm5);
dif5 = cls-m5;
for i = 2:b
if (dif5(i)*dif5(i-1) < 0)
crs5(i)=1;
else
crs5(i)=0;
end
end

% mov avg 8
tm8 = tsmovavg(TS.CLOSE, 's', 8);
m8 = fts2mat(tm8);
dif8 = cls-m8;
for i = 2:b
if (dif8(i)*dif8(i-1) < 0)
crs8(i)=1;
else
crs8(i)=0;
end
end

% mov avg 13
tm13 = tsmovavg(TS.CLOSE, 's', 13);
m13 = fts2mat(tm13);
dif13 = cls-m13;
for i = 2:b
if (dif13(i)*dif13(i-1) < 0)
crs13(i)=1;
else
crs13(i)=0;
end
end

% mov avg 21
tm21 = tsmovavg(TS.CLOSE, 's', 21);
m21 = fts2mat(tm21);
dif21 = cls-m21;
for i = 2:b
if (dif21(i)*dif21(i-1) < 0)
crs21(i)=1;
else
crs21(i)=0;
end
end

% mov avg 34
tm34 = tsmovavg(TS.CLOSE, 's', 34);
m34 = fts2mat(tm34);
dif34 = cls-m34;
for i = 2:b
if (dif34(i)*dif34(i-1) < 0)
crs34(i)=1;
else
crs34(i)=0;
end
end

% mov avg 55
tm55 = tsmovavg(TS.CLOSE, 's', 55);
m55 = fts2mat(tm55);
dif55 = cls-m55;
for i = 2:b
if (dif55(i)*dif55(i-1) < 0)
crs55(i)=1;
else
crs55(i)=0;
end
end