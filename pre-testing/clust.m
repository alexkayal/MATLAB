for i = 1:3610
    if (lng(i)<-0.25)
        typ(i)=-2;
    elseif (lng(i)>=-0.25 && lng(i)<-0.05)
        typ(i)=-1;
    elseif (lng(i)>=-0.05 && lng(i)<0.05)
        typ(i)=0;
    elseif (lng(i)>=0.05 && lng(i)<0.25)
        typ(i)=1;
    else
        typ(i)=2;
    end
end

            