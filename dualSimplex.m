clc;
clear all;

%% Initial Table Formation
a = [-1, -1, 1; -1, 2, -4]; % Constraints Coefficient
B = [-5; -8]; % Constraints Solution
C = [-2, 0, -1]; % Objective Function Coefficient
n = 3; % No. of variables excluding slack variable
s = eye(size(a, 1)); % Slack Variable Coefficient
A = [a, s, B];
cost = zeros(1, size(A, 2));
cost(1 : n) = C;
BV = n + 1 : 1 : size(A, 2) - 1;
zjcj = cost(BV) * A - cost;
Z = [A; zjcj];
Z = array2table(Z, 'VariableNames', {'x1', 'x2', 'x3', 's1', 's2', 'sol'});
Z

%% Dual Simplex Iteration
Run = true;
while Run
    zc = zjcj(1 : end - 1);
    if all(zc >= 0)
        fprintf('The current solution is optimal');
    else
        fprintf('Dual Simplex can not be applied');
        break;
    end
    sol = A(:, end);
    if any(sol < 0)
        [Minimal, pvt_row] = min(sol);
        for i = 1 : size(A, 2) - 1
            if A(pvt_row, i) < 0
                ratio(i) = abs(zjcj(i) / A(pvt_row, i));
            else 
                ratio(i) = Inf;
            end
        end
        [minratio, pvt_col] = min(ratio);
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
        Z = array2table(Z, 'VariableNames', {'x1', 'x2', 'x3', 's1', 's2', 'sol'});
        Z
    else
        Run = false;
        fprintf('\nThe current solution is feasible');
    end
end
