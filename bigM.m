variables = {'x1','x2','s2','s3','A1','A2','sol'};
M=1000;
cost = [-2 -1 0 0 -M -M 0];
A = [3 1 0 0 1 0 3;
     4 3 -1 0 0 1 6;
     1 2 0 1 0 0 3];
s = eye(size(A,1));
BV = [];
for i=1:size(s,2)
    for j = 1:size(A,2)
        if A(:,j) == s(:,i)
            BV = [BV j];
        end
    end
end
zjcj = cost(BV)*A - cost;
Z = [zjcj;A];
Z = array2table(Z,VariableNames=variables);

run = true;
while run
    zc = zjcj(1:end-1);
    if any(zc<0)
        fprintf("sol not optimal");
        [min_val,pvt_col] = min(zc);
        if all(A(:,pvt_col)<=0)
            fprintf('LPP invalid');
        else
            sol = A(:,end);
            col = A(:,pvt_col);
            for i = 1:size(A,1)
                if col(i)>0
                    ratio(i) = sol(i)./col(i);
                else
                    ratio(i) = inf;
                end
            end
            [min_val2, pvt_row] = min(ratio);
            BV(pvt_row) = pvt_col;
            pvt = A(pvt_row,pvt_col);
            A(pvt_row,:) = A(pvt_row,:)./pvt;
            for i = 1:size(A,1);
                if i~=pvt_row
                A(i,:) = A(i,:) - A(i,pvt_col).*A(pvt_row,:);
                end
            end
            zjcj = zjcj - zjcj(pvt_col).*A(pvt_row,:);
            ans = [zjcj;A];
            ans = array2table(ans,VariableNames=variables);
            ans
        end
    else 
        fprintf('sol is optimal');
        run = false;

    end
   end
   BV
   sol = zeros(1,size(A,2));
   sol(BV) = A(:,end);
   sol(end) = sum(sol.*cost);
   sol = array2table(sol,VariableNames=variables);
   sol


        

