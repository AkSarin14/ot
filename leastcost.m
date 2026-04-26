cost = [2 7 4;3 3 1;5 5 4;1 6 2];
A = [5 8 7 14];
B = [7 9 18];

if(sum(A)==sum(B))
    fprintf('balanced problem');
else
    fprintf('Unbalanced problem')
    if sum(A)<sum(B)
        cost(end+1,:) = zeros(1,size(B,2));
        A(end+1) = sum(B)-sum(A);

    else 
        cost(:,end+1) = zeros(1,size(A,2));
        B(end+1) = sum(A)-sum(B);
    end
end
icost = cost;
X = zeros(size(cost));

[m,n] = size(cost);
m 
n

bfs = m+n-1;
for i = 1:size(cost,1)
    for j = 1:size(cost,2)
        hh = min(cost(:));
        [row_ind,col_ind] = find(hh==cost);
        x11 = min(A(row_ind),B(col_ind));
        [val,ind] = max(x11);
        ii = row_ind(ind);
        jj = col_ind(ind);
        y11 = min(A(ii),B(jj));
        X(ii,jj) = y11;
        A(ii) = A(ii)-y11;
        B(jj) = B(jj)-y11;
        cost(ii,jj) = inf;
    end
end
sol = array2table(X);
X
sol
totalbfs = length(nonzeros(X));
totalbfs

if totalbfs == bfs
    fprintf('Soln is non degerate\n');
else 
    fprintf('Soln is degenerate\n');
end
ans = sum(sum(icost.*X));
fprintf('\nFinal Cost = %d\n',ans);














