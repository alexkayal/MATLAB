clear S yf yh e res;

%set threshold of acceptance%
% varying threshold th = 0.5;

%simulate and create the final S matrix%
yf = sim(net,x2); 
e = y2-yf;
yh = hardlim (yf - th);

S = [yh' v(q1+1:q2)'];
[r1,c1] = size(S);

for i = 1:r1
res(i) = S(i,1)*S(i,2);
end

sumyh = sum(yh);

% call randz %
if (q2-q1>sumyh)
    randz;

total_res = sum(v(q1+1:q2)')
rand_res = mean(randrx)
nn_res = sum(res)
sumyh
total_hr = sum(hardlim(v(q1+1:q2)-0.01))/(q2-q1)
rand_hr = mean(randpx)/sumyh
nn_hr = sum(hardlim(res-0.01))/sumyh

else
    
    total_res = sum(v(q1+1:q2)')
    rand_res = total_res
    nn_res = sum(res)
    sumyh
    total_hr = sum(hardlim(v(q1+1:q2)-0.01))/(q2-q1)
    rand_hr = total_hr
    nn_hr = sum(hardlim(res-0.01))/sumyh

end