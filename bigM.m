clc;
clear all;

%% Initial Table Formation
a = [1, 1; 1, 2; 2, 1]; % Constraints Coefficient
B = [4; 6; 8]; % Constraints Solution
C = [2, 3]; % Objective Function Coefficient
n = 2; % No. of variables excluding slack variable
M = 100000; % A very large number
s = [-1, 0, 0; 0, -1, 0;1, 0, 0; 0, 1, 0; 0, 0, 1]'; % Slack/Surplus/Artificial Variable Coefficients
A = [a, s, B];
av = 0;
cost = zeros(1, size(A, 2));
cost(1 : n) = C;
BV = n + 1 + (size(s, 2) - size(a, 1)) : 1 : size(A, 2) - 1;
zjcj = cost(BV) * A - cost;
for i = 1 : size(s, 2)
    if i <= size(s, 1) && s(i, i) == -1
        av = av + 1;
        continue;
    else 
        break;
    end
end
zjcj(n + i : n + i + av - 1) = M;
for i = 1 : av
    zjcj = zjcj - M * A(i, :);
end
Z = [A; zjcj];
Z = array2table(Z, 'VariableNames', {'x1', 'x2', 's1', 's2', 'A1', 'A2', 's3', 'sol'});
Z

%% Big M Iteration
Run = true;
while Run
    zc = zjcj(1 : end - 1);
    if any(zc < 0)               
        fprintf('The current solution is not optimal');
        [Minimal , pvt_col] = min(zc);
        if all(A(:, pvt_col) <= 0)
            fprintf('The given LPP is unbounded');
        else
            sol = A(:, end);
            col = A(:, pvt_col);
            for(i = 1 : size(A, 1))
                if col(i) > 0
                    ratio(i) = sol(i) / col(i);
                else
                    ratio(i) = Inf;
                end
            end
            [minratio, pvt_row] = min(ratio);
        end
        pvt_key = A(pvt_row, pvt_col);
        BV(pvt_row) = pvt_col;
        A(pvt_row, :) = A(pvt_row, : ) / pvt_key;
        for i = 1 : size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
            end
        end
        zjcj = zjcj - zjcj(pvt_col) * A(pvt_row, :);
        Z = [A; zjcj];
        Z = array2table(Z, 'VariableNames', {'x1', 'x2', 's1', 's2', 'A1', 'A2', 's3', 'sol'});
        Z
    else
        Run = false;
        fprintf('The current solution is optimal');
    end
end
