% Create the indicators out of the data: 
% Moving averages, RSI's, StdDevs

% Cleaning previous stuff
% clear 

% Cleaning price matrix
clear profit crosspoints prof neuralmatrix neuralmatrixprep
[rows,columns]=size(prc);
pcounter =1;
for i=1:rows
    if (prc(i,5)~=0)
        price_matrix(pcounter,1)=prc(i,1);
        price_matrix(pcounter,2)=prc(i,2);
        price_matrix(pcounter,3)=prc(i,3);
        price_matrix(pcounter,4)=prc(i,4);
        pcounter = pcounter+1;
    end
end
clear pcounter

% Price matrix has already been cleaned
close = price_matrix(:,4);
open = price_matrix(:,1);
high = price_matrix(:,2);
low = price_matrix(:,3);

% Moving averages, difference between them, etc.
mov1 = tsmovavg(close, 'e', M1, 1);
mov2 = tsmovavg(close, 'e', M2, 1);

% getting the difference between the MA's
mvdiff = mov1 - mov2;

% getting the cross points
[rows,columns]=size(mvdiff);

crosspoints(1)=0;
for i=2:rows-1
    
    if (rand>thr)
        
        if (rand>0.5)
            crosspoints (i)=1;
        else crosspoints (i)=-1;
        end
    
    else crosspoints (i)=0;
    end
        
end
crosspoints(rows)=0; % prevent last point from being a cross point %
crosspoints = crosspoints';

% Getting RSI's

rsifast = rsindex(close,10);
rsimedfast = rsindex(close,20);
rsimedium = rsindex(close,30);
rsimedslow = rsindex(close,40);
rsislow = rsindex(close,50);

% Getting StdDevs
   

for i = 1:10
    stddevfast(1,i)=NaN;
end
for i = 10:rows
    stddevfast(1,i)=nanstd(close(i-9:i));
end

for i = 1:20
    stddevmedfast(1,i)=NaN;
end
for i = 20:rows
    stddevmedfast(1,i)=nanstd(close(i-19:i));
end

for i = 1:30
    stddevmedium(1,i)=NaN;
end
for i = 30:rows
    stddevmedium(1,i)=nanstd(close(i-29:i));
end

for i = 1:40
    stddevmedslow(1,i)=NaN;
end
for i = 40:rows
    stddevmedslow(1,i)=nanstd(close(i-39:i));
end

for i = 1:50
    stddevslow(1,i)=NaN;
end
for i = 50:rows
    stddevslow(1,i)=nanstd(close(i-49:i));
end

% Getting the outcome of the algorithm
% Note: profit is recorded next to the candle where the order originated,
%   not where it closed

mode = 0;
orderprice = 0;
orderindex = 0;
numwinorders = 0;
numlossorders = 0;

for i =1:rows
    
    % Empty Mode
    if (mode==0)
        if (crosspoints(i)==1)
            orderprice=close(i);
            orderindex = i;
            mode=1;
        end
        
        if (crosspoints(i)==-1)
            orderprice=close(i);
            orderindex = i;
            mode=-1;
        end
        
    end
    
    
    % Holding mode
    if (mode==1)
        if (high(i)-orderprice>(TP/10000))
            profit(1,orderindex)=TP;
            mode=0;
            numwinorders = numwinorders+1;
        end
          
        if (orderprice-low(i)>(SL/10000))
            profit(1,orderindex)=-SL;
            mode=0;
            numlossorders = numlossorders+1;
        end
        
    
    end
    
    if (mode==-1)
        if (orderprice-low(i)>(TP/10000))
            profit(1,orderindex)=TP;
            mode=0;
            numwinorders = numwinorders+1;
        end
          
        if (high(i)-orderprice>(SL/10000))
            profit(1,orderindex)=-SL;
            mode=0;
            numlossorders = numlossorders+1;
        end
        
    
    end
    
    if (orderindex~=rows)
        profit(1,rows)=0;
    end
    
end

% Preparing neural matrix

neuralmatrixprep = [crosspoints profit' stddevfast' stddevmedfast' stddevmedium' stddevmedslow' stddevslow' rsifast rsimedfast rsimedium rsimedslow rsislow];
pcounter = 1;
for i=1:rows
    
    if (neuralmatrixprep(i,2)~=0)
        neuralmatrix(pcounter,:)=neuralmatrixprep(i,:);
        pcounter = pcounter+1;
    end
    
end

% Preparing data for entry in neural network
prof = neuralmatrix(:,2)';
stddevs = neuralmatrix(:,3:7)';
rsis = neuralmatrix(:,8:12)';
targs = hardlim(prof);

totalnumberoforders=pcounter-1
totalprofit = sum(prof)
winpercentage = numwinorders/(numwinorders+numlossorders)

%divide
[q1,q2]=size(prof);
q1 = ceil(0.85*q2);

%x1 = [rsis(:,1:q1); stddevs(:,1:q1)];
x1 = [rsis(:,1:q1)];
y1 = targs(:,1:q1);
%x2 = [rsis(:,q1+1:q2); stddevs(:,q1+1:q2)];
x2 = [rsis(:,q1+1:q2)];
y2 = targs(:,q1+1:q2);

% Some stats:
numberoftestorders = q2-q1
sumofprofitintestorders = sum(prof(q1+1:q2))
testwinpercentage = sum(hardlim(prof(q1+1:q2)))/(q2-q1)

%set network params and size%
net = newff(x1,y1,[3]);
net.trainParam.max_fail=10;

% The End