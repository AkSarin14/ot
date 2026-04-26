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
\outl0\strokewidth0 \strokec2 f = @(x1,x2) x1-x2+2*x1.^2 + 2*x1*x2 +x2.^2;\
grad_f = @(x1,x2) [1+4*x1+2*x2;-1+2*x1+2*x2];\
\
max_iter = 100;\
tol = 1e-6;\
alpha = 0.1;\
x = [3;3];\
fprintf(\cf3 \strokec3 'Initial x values is (%f , %f)\\n'\cf0 \strokec2 ,x(1),x(2));\
\pard\pardeftab720\partightenfactor0
\cf4 \strokec4 for \cf0 \strokec2 i=1:max_iter\
    gradient = grad_f(x(1),x(2));\
    \cf4 \strokec4 if \cf0 \strokec2 norm(gradient)<tol\
        fprintf(\cf3 \strokec3 "result found after iterations %d \\n"\cf0 \strokec2 ,i-1);\
        \cf4 \strokec4 break\cf0 \strokec2 ;\
    \cf4 \strokec4 end\cf0 \strokec2 \
    x =x-alpha*gradient;\
    fprintf(\cf3 \strokec3 ' x values is (%f , %f) iteration %d \\n '\cf0 \strokec2 ,x(1),x(2),i);\
\cf4 \strokec4 end\cf0 \strokec2 \
fprintf(\cf3 \strokec3 'Final soln is at (%f ,%f) and value is %f'\cf0 \strokec2 ,x(1),x(2),f(x(1),x(2)));\
\
\
\
}