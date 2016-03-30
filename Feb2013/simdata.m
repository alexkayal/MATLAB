clear selected S res numofselectedorders neuralprofit neuralwinpercentage
% Running the network and checking the result
%th = 0.5; %Threshold of acceptance

% Training the network
net = train(net,x1,y1);

% Simulating the network
ynet = sim(net,x2); 
e = y2-ynet;

% Running variant thresholds

for j=1:100
    
    th=j/100;
    th_matrix(j)=th;
    % Choosing selected orders (the ones that pass the threshold)
    selected(j,:) = hardlim (ynet - th);
    s = [selected(j,:)' prof(q1+1:q2)'];
    [r1,c1] = size(s);

    % Results of selected orders
    for i = 1:r1
    res(i,j) = s(i,1)*s(i,2);
    end
    
end



for j=1:100
    
    numofselectedorders(j) = sum(selected(j,:));
    neuralprofit(j) = sum(res(:,j));
    neuralwinpercentage(j) = sum(hardlim(res(:,j)-0.01))/numofselectedorders(j);
    
end

plot(neuralwinpercentage,th_matrix)
