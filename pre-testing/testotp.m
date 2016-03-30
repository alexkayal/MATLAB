%   testotp algorith:
%   4. Set a random TP level, and calculate total number of pips by end of
%       simulation. (Either hit TP or reverse level)
%   5. Find the most optimal fixed TP level linearly.
%   6. Neurally modify TP for every case, to obtain highest total pip
%       value.
%   

clear profm profit;

otp = [1:1:500];
[rr,cc]= size(ZMatrix);
for j=1:500
    
for i=1:rr
    if (ZMatrix(i,30)>otp(j))
        profm(i,j)=otp(j);
    else
        profm(i,j)=ZMatrix(i,31);
    end
end

profit(j) = sum(profm(:,j));
end