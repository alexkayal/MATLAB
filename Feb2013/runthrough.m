for c=1:1000
    if mod(c,100)==0
        c
    end
    specific_case_suppressed_output;
    M(c)=netprofit;
    P(c)=winpercentage;
    G(c)=grossprofit;
end

plot (M,'.r')