%   testotp algorith:
%   4. Set a random TP level, and calculate total number of pips by end of
%       simulation. (Either hit TP or reverse level)
%   5. Find the most optimal fixed TP level linearly.
%   6. Neurally modify TP for every case, to obtain highest total pip
%       value.
%   

[rr,cc]= size(ZMatrix);
for i=1:rr
    if (ZMatrix(i,5)>otp)
        profm(i)=otp;
    else
        profm(i)=ZMatrix(i,6)
    end
end
profit = sum(profm)