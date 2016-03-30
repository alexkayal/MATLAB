clear X1 tt;
% 1. form the traversable matrix (last tst x bars) %
X1 = ff(end-(tst*bars)+1:end,:);

% 2. place targets in the right places %
tt = cell2mat(x)';
for i=1:tst
X1((i*bars)-bars+1:i*bars,6)=tt(i);
end

% 3. traverse the matrix %