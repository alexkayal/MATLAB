%divide
x1 = p(:,1:q1);
y1 = sv(:,1:q1);
x2 = p(:,q1+1:q2);
y2 = sv(:,q1+1:q2);

%set network params and size%
net = newff(x1,y1,[40 20]);
net.trainParam.max_fail=10;
net = train(net,x1,y1);