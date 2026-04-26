{\rtf1\ansi\ansicpg1252\cocoartf2867
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 a = [1 2 2;2 4 1];\
B = [10;15];\
C = [5 2 3];\
s = [1 0;0 1];\
A = [a s B];\
cost = zeros(1,size(A,2));\
n = 3;\
cost(1:n)= C;\
BV = n+1:1:size(A,2)-1;\
\
zjcj = cost(BV)*A - cost;\
\
Z = [zjcj;A];\
\
Z = array2table(Z,'VariableNames',\{'x1','x2','x3','s1','s2','sol'\});\
\
Z\
\
run = true;\
while run\
    zc = zjcj(1:end-1);\
if any(zc<0)\
    [min_val,pvt_col] = min(zc);\
    if all(A(:,pvt_col)<=0)\
        fprintf('invalid lpp');\
    else\
        sol = A(:,end);\
        col = A(:,pvt_col);\
        for i=1:size(A,1);\
            if col(i)<=0\
                ratio(i) = inf;\
            else\
                ratio(i) = sol(i)/col(i);\
            end\
        end\
        [min_val2,pvt_row] = min(ratio);\
\
        BV(pvt_row) = pvt_col;\
        pvt = A(pvt_row,pvt_col);\
\
        A(pvt_row,:) =A(pvt_row,:)./pvt ;\
\
        for i=1:size(A,1)\
            if i~=pvt_row\
            A(i,:) = A(i,:) - A(i,pvt_col).*A(pvt_row,:);\
            end\
        end\
        zjcj = zjcj - zjcj(pvt_col).*A(pvt_row,:);\
    end\
ans = [zjcj;A];\
ans = array2table(ans,'VariableNames',\{'x1','x2','x3','s1','s2','sol'\});\
ans\
else \
    fprintf('the soln is optimal');\
    run = false;\
end\
end\
\
sol = zeros(1,size(A,2));\
sol(BV) = A(:,end);\
sol(end) = sum(cost.*sol);\
sol = array2table(sol,'VariableNames',\{'x1','x2','x3','s1','s2','sol'\});\
sol\
\
\
\
\
\
\
\
\
\
\
\
}