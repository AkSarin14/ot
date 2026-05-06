clc
clear all

c = [-2 0 -1];
a = [-1 -1 1;-1 2 -4];
b = [-5; -8];

n = size(a, 2);
s = eye(size(a, 1));

A = [a s b];

cost = zeros(1, size(A, 2));
cost(1:n) = c;

bv = n+1 : size(A, 2)-1;

zjcj = cost(bv) * A - cost;
zcj = [A; zjcj];

simptable = array2table(zcj);
simptable.Properties.VariableNames(1:size(zcj,2)) = ...
    {'x1','x2','x3','s1','s2','Sol'}
run=true
while run
    zc=zjcj(1:end-1);
    if all(zc>=0)
        disp('optimality achieved...Go to dual simplex')
    else
        disp('not optimal')
        break;
    end
    sol=A(:,end);
    if any(sol<0)
        [minval pvt_row]=min(sol)
        for i=1:size(A,2)-1
            if A(pvt_row,i)<0
                ratio(i)=abs(zjcj(i)/A(pvt_row,i))
            else
                ratio(i)=inf
            end
        end
        [minval pvt_col]=min(ratio)         
        pvt_key = A(pvt_row, pvt_col);
        bv(pvt_row) = pvt_col;

        A(pvt_row, :) = A(pvt_row, :) / pvt_key;

        for i = 1:size(A,1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
            end
        end

        zjcj = zjcj - zjcj(pvt_col) * A(pvt_row, :);
        zcj = [A; zjcj]

        simptable = array2table(zcj);
        simptable.Properties.VariableNames(1:size(zcj,2)) = {'x1','x2','x3','s1','s2','Sol'}

    else
        run = false;
        fprintf('optimal sol')
    end
end
