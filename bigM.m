{\rtf1\ansi\ansicpg1252\cocoartf2867
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red148\green0\blue242;\red8\green0\blue255;
}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;\cssrgb\c65490\c3529\c96078;\cssrgb\c5490\c0\c100000;
}
\paperw11900\paperh16840\margl1440\margr1440\vieww29200\viewh17740\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs20 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 variables = \{\cf3 \strokec3 'x1'\cf0 \strokec2 ,\cf3 \strokec3 'x2'\cf0 \strokec2 ,\cf3 \strokec3 's2'\cf0 \strokec2 ,\cf3 \strokec3 's3'\cf0 \strokec2 ,\cf3 \strokec3 'A1'\cf0 \strokec2 ,\cf3 \strokec3 'A2'\cf0 \strokec2 ,\cf3 \strokec3 'sol'\cf0 \strokec2 \};\
M=1000;\
cost = [-2 -1 0 0 -M -M 0];\
A = [3 1 0 0 1 0 3;\
     4 3 -1 0 0 1 6;\
     1 2 0 1 0 0 3];\
s = eye(size(A,1));\
BV = [];\
\pard\pardeftab720\partightenfactor0
\cf4 \strokec4 for \cf0 \strokec2 i=1:size(s,2)\
    \cf4 \strokec4 for \cf0 \strokec2 j = 1:size(A,2)\
        \cf4 \strokec4 if \cf0 \strokec2 A(:,j) == s(:,i)\
            BV = [BV j];\
        \cf4 \strokec4 end\cf0 \strokec2 \
    \cf4 \strokec4 end\cf0 \strokec2 \
\cf4 \strokec4 end\cf0 \strokec2 \
zjcj = cost(BV)*A - cost;\
Z = [zjcj;A];\
Z = array2table(Z,VariableNames=variables);\
\
run = true;\
\cf4 \strokec4 while \cf0 \strokec2 run\
    zc = zjcj(1:end-1);\
    \cf4 \strokec4 if \cf0 \strokec2 any(zc<0)\
        fprintf(\cf3 \strokec3 "sol not optimal"\cf0 \strokec2 );\
        [min_val,pvt_col] = min(zc);\
        \cf4 \strokec4 if \cf0 \strokec2 all(A(:,pvt_col)<=0)\
            fprintf(\cf3 \strokec3 'LPP invalid'\cf0 \strokec2 );\
        \cf4 \strokec4 else\cf0 \strokec2 \
            sol = A(:,end);\
            col = A(:,pvt_col);\
            \cf4 \strokec4 for \cf0 \strokec2 i = 1:size(A,1)\
                \cf4 \strokec4 if \cf0 \strokec2 col(i)>0\
                    ratio(i) = sol(i)./col(i);\
                \cf4 \strokec4 else\cf0 \strokec2 \
                    ratio(i) = inf;\
                \cf4 \strokec4 end\cf0 \strokec2 \
            \cf4 \strokec4 end\cf0 \strokec2 \
            [min_val2, pvt_row] = min(ratio);\
            BV(pvt_row) = pvt_col;\
            pvt = A(pvt_row,pvt_col);\
            A(pvt_row,:) = A(pvt_row,:)./pvt;\
            \cf4 \strokec4 for \cf0 \strokec2 i = 1:size(A,1);\
                \cf4 \strokec4 if \cf0 \strokec2 i~=pvt_row\
                A(i,:) = A(i,:) - A(i,pvt_col).*A(pvt_row,:);\
                \cf4 \strokec4 end\cf0 \strokec2 \
            \cf4 \strokec4 end\cf0 \strokec2 \
            zjcj = zjcj - zjcj(pvt_col).*A(pvt_row,:);\
            ans = [zjcj;A];\
            ans = array2table(ans,VariableNames=variables);\
            ans\
        \cf4 \strokec4 end\cf0 \strokec2 \
    \cf4 \strokec4 else \cf0 \strokec2 \
        fprintf(\cf3 \strokec3 'sol is optimal'\cf0 \strokec2 );\
        run = false;\
\
    \cf4 \strokec4 end\cf0 \strokec2 \
   \cf4 \strokec4 end\cf0 \strokec2 \
   BV\
   sol = zeros(1,size(A,2));\
   sol(BV) = A(:,end);\
   sol(end) = sum(sol.*cost);\
   sol = array2table(sol,VariableNames=variables);\
   sol\
\
\
        \
\
\
}