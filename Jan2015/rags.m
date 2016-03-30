x(1)=10000;
for i=2:500
    r= rand;
    if r>0.40
        x(i)=x(i-1)*1.5;
    else
        x(i)=x(i-1)*0.5;
    end
end
plot (x)