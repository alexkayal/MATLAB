clear selected s res numofselectedorders neuralprofit neuralwinpercentage
[q1,q2]=size(prof);

for j=1:q2
    
    rsiavg = (rsis(1,j)+rsis(3,j)+rsis(5,j))/3;
    if (rsiavg<50)
        selected(j)=1;
    else selected(j)=0;
    end
    
end

    % Choosing selected orders (the ones that pass the threshold)
    s = [selected' prof(1:q2)'];
    [r1,c1] = size(s);

    % Results of selected orders
    for i = 1:r1
    res(i) = s(i,1)*s(i,2);
    end
    


    
numofselectedorders = sum(selected)
filterprofit = sum(res)
filterwinpercentage = sum(hardlim(res-0.01))/numofselectedorders
