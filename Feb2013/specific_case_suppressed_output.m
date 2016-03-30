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
%mov1 = tsmovavg(close, 'e', M1, 1);
%mov2 = tsmovavg(close, 'e', M2, 1);

% getting the difference between the MA's
%mvdiff = mov1 - mov2;

% getting the cross points
[rows,columns]=size(price_matrix);


for i=1:rows-1
    
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
           
    
    % Holding mode
    elseif (mode==1)
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
        
        
    elseif (mode==-1)
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

neuralmatrixprep = [crosspoints profit' rsifast rsimedfast rsimedium rsimedslow rsislow];
pcounter = 1;
for i=1:rows
    
    if (neuralmatrixprep(i,2)~=0)
        neuralmatrix(pcounter,:)=neuralmatrixprep(i,:);
        pcounter = pcounter+1;
    end
    
end

% Preparing data for entry in neural network
prof = neuralmatrix(:,2)';
%stddevs = neuralmatrix(:,3:7)';
%rsis = neuralmatrix(:,8:12)';
rsis = neuralmatrix(:,3:7)';
%targs = hardlim(prof);

totalnumberoforders=pcounter-1;
grossprofit = sum(prof);
netprofit = sum(prof)-totalnumberoforders;
winpercentage = numwinorders/(numwinorders+numlossorders);


% The End