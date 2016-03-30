% project random X, nov 2009

clear prc ri z mx mtx signal prof M;

prc = fts2mat (TS);

% create an initial frequency variable
%F = 0.1;   approximately one out of every 10 closes contains a signal%
%TH = 100-100*F; converting F to threshold TH, in this case 90%

[z,z_] = size(TS);
st = ceil(rand*500);
W = 25;
L = -25;

% signal and profit matrices %
for i = 1:z 
    signal(i)=0;
    prof(i)=0;
end

if (rand>0.5) ri = 1; else ri = -1; end
signal(st)=ri;

for i = st:z
    if abs(signal(i))==1
        % inside loop %
        j = i+1;
        while ((prc(j,3)-prc(i,3))*10000<W && (prc(j,3)-prc(i,3))*10000>L)
            j = j+1;
            if (j>=z) break; end
        end
        
        if (j<z) prof(i)= (prc(j,3)-prc(i,3))*10000;
            signal(j)=signal(i)*-1;
            
            
        end
        
    end
    
    if abs(signal(i))==-1
        % inside loop %
        j = i+1;
        while ((prc(i,3)-prc(j,3))*10000<W && (prc(i,3)-prc(j,3))*10000>L)
            j = j+1;
            if (j>=z) break; end
        end
        
        if (j<z) prof(i)= (prc(i,3)-prc(j,3))*10000;
            signal(j)=signal(i)*-1; 
            
        end
        
    end
        
end

mtx = [prc(:,3) signal' prof'];

% getting the neural network parameters %

m1 = fts2mat(tsmovavg(TS.CLOSE,'s',1));
m2 = fts2mat(tsmovavg(TS.CLOSE,'s',3));
m3 = fts2mat(tsmovavg(TS.CLOSE,'s',5));
m4 = fts2mat(tsmovavg(TS.CLOSE,'s',10));
m5 = fts2mat(tsmovavg(TS.CLOSE,'s',20));
m6 = fts2mat(tsmovavg(TS.CLOSE,'s',50));
m7 = fts2mat(tsmovavg(TS.CLOSE,'s',100));
m8 = fts2mat(tsmovavg(TS.CLOSE,'s',200));

mx = [m1 m2 m3 m4 m5 m6 m7 m8];

% clearing out the 0 rows %
zc=1;

for i=1:z
    if (mtx(i,2)~=0)
        M(zc,:)=[mx(i,:) mtx(i,2:3)];
        zc=zc+1;
    end
end

% creating the inputs and outputs of network %

p_ = M(:,1:9);
t_ = M(:,10);
v = M(:,10);
p_ = p_'; t_ = t_'; v= v';
sv = hardlim(v-0.01);

% division %
div = 0.25; % the last 25% of the signals for testing %
q2 = sum(abs(signal));
q1 = floor(q2 - (div*q2));

x1 = p_(:,1:q1);
y1 = sv(:,1:q1);
x2 = p_(:,q1+1:q2);
y2 = sv(:,q1+1:q2);

%set network params and size%
net = newff(x1,y1,[500 200 100]);
net.trainFcn = 'trainscg';
net.trainParam.max_fail=30;
net = train(net,x1,y1);
