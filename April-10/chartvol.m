vol_size = 8500;
[bb,cc] = size(mtrx);

ff(:,1) = mtrx(:,5);
ff(:,2) = mtrx(:,1);
ff(:,3) = mtrx(:,4);
ff(:,4) = mtrx(:,3);
ff(:,5) = mtrx(:,2);

vol = ff(:,1);
vol_c = 0;
hi =0;
lo =100;
b = 1;

for i = 1:bb
    
    if (vol_c)> vol_size 
        fn(b,3)= ff(i,3); %placing the close%
        fn(b,1)=vol_c; %recording the volume%
        
        %if this high is higher than the recorded high update%
        if ff(i,5)> hi
            hi = ff(i,5);
        end
            
        %if this low is lower than the recorded low update%
        if ff(i,4)< lo
            lo = ff(i,4);
        end
        
        fn(b,4)= lo; %placing the low%
        fn(b,5)= hi; %placing the high%
        
        b = b+1; %start new bar%
        vol_c =0; %reset volume counter%
        lo =100; hi =0; % reset lo and hi %
    end
       
    if (vol_c)==0 
        fn(b,2)= ff(i,2); %placing the open%
        
        %if this high is higher than the recorded high update%
        if ff(i,5)> hi
            hi = ff(i,5);
        end
            
        %if this low is lower than the recorded low update%
        if ff(i,4)< lo
            lo = ff(i,4);
        end
        
        vol_c = vol_c + vol(i); %add volume%
    end
               
    if (vol_c)~=0 && (vol_c)<= vol_size
        vol_c = vol_c + vol(i); %add volume%
        %if this high is higher than the recorded high update%
        if ff(i,5)> hi
            hi = ff(i,5);
        end
            
        %if this low is lower than the recorded low update%
        if ff(i,4)< lo
            lo = ff(i,4);
        end
        
    end
        

end

fn(b,:)=[];

%if mod(i,bars)==0 
%            fn(i/bars,1) = sum ([ff(i-bars+1:i,1)]);  %volume
%            fn(i/bars,2) = ff(i-bars+1,2);  %open
%            fn(i/bars,3) = ff(i,3);  %close
%            fn(i/bars,4) = min ([ff(i-bars+1:i,4)]);  %low
%            fn(i/bars,5) = max ([ff(i-bars+1:i,5)]);  %high
%end