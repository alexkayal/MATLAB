clear randrx randpx rndmtrx smp i j k
% randz: can only be called from within optsim %

j = 1;
smp = v(q1+1:q2)';

for o=1:1000
    randrx(o)=0;
end

for pp=1:1000
    randpx(pp)=0;
end

for l =1:sumyh
        rndmtrx(l)=0;
end

for i = 1:1000
     
    j = 1;
    while (j<=sumyh)
        xx = ceil(rand*(q2-q1));
        c = 0;
        for (k = 1:j) % search within rndmtrx for a value similar to xx %
            if (rndmtrx(k)==xx) c=1;    
            end
        end
        if (c==0) 
            rndmtrx(j)=xx;
            j = j+1;
        end
    end
    
    % selecting values chosen for smp;
    
    for w = 1:sumyh
        randrx(i) = randrx(i) + smp(rndmtrx(w));
        if (smp(rndmtrx(w))>0) randpx(i) = randpx(i)+1; end
    end
    
end