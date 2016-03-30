% project random, oct/nov 2009

clear prc ri z mx mtx signal prof M;
prc = fts2mat (TS);

% create an initial frequency variable
F = 0.1;  % approximately one out of every 10 closes contains a signal%
TH = 100-100*F; % converting F to threshold TH, in this case 90%

[z,z_] = size(TS);
if (rand>0.5) ri = 1; else ri = -1; end

% signal and profit matrices %
for i = 1:z 
    signal(i)=0;
    prof(i)=0;
end

for i=1:z
    r = ceil(rand*100); % random number %    
    if (r>TH) signal(i)=ri;
        ri = ri*-1;
    end
end

signal(z) = 0; % preventing the last item from giving a signal %

mtx = [prc(:,3) signal'];

% get the result of every signal %

% initial values % 
v1 = 0; v2 = 0;

for i=1:z
    if (signal(i)==1 || signal(i)==-1)
        v1 = mtx(i,1);
            
        % finding v2%
        j = i+1;
        while (j<=z && (signal(j) ==0))
            j=j+1;
        end
            
        if (j<z) v2=mtx(j,1); end
        prof(i)=(v2-v1)*signal(i)*10000;
            
        
    end
end

mtx = [mtx prof'];

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
