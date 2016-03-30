for xe = 1:100
th = xe/100;
optsim;
KMatrix(xe,:)= [sum(hardlim(v(q1+1:q2)-0.01))/(q2-q1) mean(randpx)/sumyh sum(hardlim(res-0.01))/sumyh];
LMatrix(xe,:)= [total_res rand_res nn_res];
end

subplot(2,1,1)
plot (KMatrix)
subplot(2,1,2)
plot(LMatrix)