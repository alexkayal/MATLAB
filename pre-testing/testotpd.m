%   testotp algorith:
%   4. Set a random TP level, and calculate total number of pips by end of
%       simulation. (Either hit TP or reverse level)
%   5. Find the most optimal fixed TP level linearly.
%   6. Neurally modify TP for every case, to obtain highest total pip
%       value.
%   

otp = [1:1:2000];
[rr,cc]= size(ZMatrix);
for j=1:2000
    
for i=1:rr
    if (ZMatrix(i,5)>otp(j))
            profm(i)=otp(j);
    else
        profm(i)=ZMatrix(i,6);
    end
end

profit(j) = sum(profm);
end