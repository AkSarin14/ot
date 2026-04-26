{\rtf1\ansi\ansicpg1252\cocoartf2867
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red8\green0\blue255;\red148\green0\blue242;
}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;\cssrgb\c5490\c0\c100000;\cssrgb\c65490\c3529\c96078;
}
\paperw11900\paperh16840\margl1440\margr1440\vieww29200\viewh17740\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs20 \cf0 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 cost = [2 7 4;3 3 1;5 5 4;1 6 2];\
A = [5 8 7 14];\
B = [7 9 18];\
\
\pard\pardeftab720\partightenfactor0
\cf3 \strokec3 if\cf0 \strokec2 (sum(A)==sum(B))\
    fprintf(\cf4 \strokec4 'balanced problem'\cf0 \strokec2 );\
\cf3 \strokec3 else\cf0 \strokec2 \
    fprintf(\cf4 \strokec4 'Unbalanced problem'\cf0 \strokec2 )\
    \cf3 \strokec3 if \cf0 \strokec2 sum(A)<sum(B)\
        cost(end+1,:) = zeros(1,size(B,2));\
        A(end+1) = sum(B)-sum(A);\
\
    \cf3 \strokec3 else \cf0 \strokec2 \
        cost(:,end+1) = zeros(1,size(A,2));\
        B(end+1) = sum(A)-sum(B);\
    \cf3 \strokec3 end\cf0 \strokec2 \
\cf3 \strokec3 end\cf0 \strokec2 \
icost = cost;\
X = zeros(size(cost));\
\
[m,n] = size(cost);\
m \
n\
\
bfs = m+n-1;\
\cf3 \strokec3 for \cf0 \strokec2 i = 1:size(cost,1)\
    \cf3 \strokec3 for \cf0 \strokec2 j = 1:size(cost,2)\
        hh = min(cost(:));\
        [row_ind,col_ind] = find(hh==cost);\
        x11 = min(A(row_ind),B(col_ind));\
        [val,ind] = max(x11);\
        ii = row_ind(ind);\
        jj = col_ind(ind);\
        y11 = min(A(ii),B(jj));\
        X(ii,jj) = y11;\
        A(ii) = A(ii)-y11;\
        B(jj) = B(jj)-y11;\
        cost(ii,jj) = inf;\
    \cf3 \strokec3 end\cf0 \strokec2 \
\cf3 \strokec3 end\cf0 \strokec2 \
sol = array2table(X);\
X\
sol\
totalbfs = length(nonzeros(X));\
totalbfs\
\
\cf3 \strokec3 if \cf0 \strokec2 totalbfs == bfs\
    fprintf(\cf4 \strokec4 'Soln is non degerate\\n'\cf0 \strokec2 );\
\cf3 \strokec3 else \cf0 \strokec2 \
    fprintf(\cf4 \strokec4 'Soln is degenerate\\n'\cf0 \strokec2 );\
\cf3 \strokec3 end\cf0 \strokec2 \
ans = sum(sum(icost.*X));\
fprintf(\cf4 \strokec4 '\\nFinal Cost = %d\\n'\cf0 \strokec2 ,ans);\
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
\
\
\
\
}