exec loader.sce
exec builder.sce

test_pass=[]
res=[]


/////////Test case for       2) arburg                  //////////

a = arburg([1,2,3,4,5],2);
a = round(a*10000)/10000;

if(a == [1.  -1.8639    0.9571])
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("arburg test failed")
end

/////////Test case for       4) aryule                  //////////

a = aryule([1,2,3,4,5],2);
a = round(a*10000)/10000;

if(a == [1.  -0.814    0.1193])
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("aryule test failed")
end

/////////Test case for       5) bitrevorder                  //////////

x = [%i,1,3,6*%i] ;
[y i]=bitrevorder(x);

if(y == [%i   3   1   6*%i] & i == [1 3 2 4])
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("bitrevorder test failed")
end

/////////Test case for       **) digitrevorder                  //////////

x = [%i,1,3,6*%i] ;
b = 2;
[y i]=digitrevorder(x,b);

if(y == [%i   3   1   6*%i] & i == [1 3 2 4])
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("digitrevorder test failed")
end

/////////Test case for       28) isfir                  //////////

fir = isfir([1 -1 1], 1)

if(fir == 1)
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("isfir test failed")
end

/////////////////////////////////////////////


/////////Test case for       29) islinearphase                  //////////

flag = islinphase([0 1 2 2 1 0],1)

if(flag == 1)
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("islinearphase Test failed")
end


/////////////////////////////////////////////


/////////Test case for       30) ismaxphase                  //////////

flag = ismaxphase([1 -5 6],1)

if(flag == 1)
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("ismaxphase Test failed")
end



/////////////////////////////////////////////


/////////Test case for       31) isminphase                  //////////
flag = isminphase([1 -0.3 0.02],1)

if(flag == 1)
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("isminphase Test failed")
end

/////////////////////////////////////////////


/////////Test case for       32) isstable                  //////////

flag = isstable([1 2],[1 -0.7 0.1])

if(flag == 1)
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("isstable Test failed")
end

/////////////////////////////////////////////


/////////Test case for       33)lar2rc                  //////////

g = [0.6389 4.5989 0.0063 0.0163 -0.0163];
k = lar2rc(g)

k=round(k*10000)/10000

if(k == [0.3090    0.9801    0.0031    0.0081  -0.0081])
    test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("lar2rc Test failed")
end



/////////////////////////////////////////////


/////////Test case for       38)levinson                  //////////

a = [1 0.1 -0.8];
v = 0.4;
w = sqrt(v)*rand(15000,1,"normal");
x = filter(1,a,w);

[r,lg] = xcorr(x,'biased');
r(lg<0) = [];

ar = levinson(r,length(a)-1)

ar = round(ar*10000)/10000

if(ar == [1 0.1043 -0.8010])
           test_pass=[test_pass,1]
    else
	test_pass=[test_pass,0]
	disp("levinson Test failed")
end

/////////////////////////////////////////////


/////////Test case for       39) lpc                  //////////

noise = rand(50000,1,"normal");
x = filter(1,[1 1/2 1/3 1/4],noise);
x = x(45904:50000);
[a,g]= lpc(x,3)
a = round(a*10000)/10000

if(a == [1 0.5177 0.3310 0.2572])
        test_pass=[test_pass,1]
else
    test_pass=[test_pass,0]
    disp("lpc Test failed")
end

/////////////////////////////////////////////


/////////Test case for       40) medfilt1                  //////////


fs = 100;
t = 0:1/fs:1;
x = sin(2*%pi*t*3)+0.25*sin(2*%pi*t*40);

y = medfilt1(x,10);
y = round(y*10000)/10000 ;
y = y'

if(y == fscanfMat("macros/medfilt1op.txt"))
           test_pass=[test_pass,1]
    else
	test_pass=[test_pass,0]
	disp("medfilt1 Test failed")
end

/////////////////////////////////////////////


/////////Test case for       41) movingrms                  //////////


[a,b]=movingrms ([4.4 94 1;-2 5*%i 5],1,-2)

b = round(b*10000)/10000

if(b == [0.1888 ; 0.1888])
           test_pass=[test_pass,1]
    else
	test_pass=[test_pass,0]
	disp("movingrms Test failed")
end



/////////////////////////////////////////////


/////////Test case for       58) pulseperiod                  //////////

x = fscanfMat("macros/pulsedata_x.txt");
t = fscanfMat("macros/pulsedata_t.txt");
p = pulseperiod(x,t);
p = round(p*10000)/10000

if(p == 0.5003)
           test_pass=[test_pass,1]
    else
	test_pass=[test_pass,0]
	disp("pulseperiod Test failed")
end

///////////////////////////////////////

/////////Test case for       59) pulsesep                  //////////

x = fscanfMat("macros/pulsedata_x.txt");
t = fscanfMat("macros/pulsedata_t.txt");
p = pulsesep(x,t);
p = round(p*10000)/10000

if(p == 0.3501)
           test_pass=[test_pass,1]
    else
	test_pass=[test_pass,0]
	disp("pulsesep Test failed")
end

///////////////////////////////////////

/////////Test case for       60) pulsewidth                  //////////

x = fscanfMat("macros/pulsedata_x.txt");
t = fscanfMat("macros/pulsedata_t.txt");
p = pulsewidth(x,t);
p = round(p*10000)/10000

if(p == 0.1502)
           test_pass=[test_pass,1]
    else
	test_pass=[test_pass,0]
	disp("pulsewidth Test failed")
end



/////////////////////////////////////////////


/////////Test case for       **)sigmoid_train                  //////////

s = sigmoid_train(0.1,[1:3],4)
s = round(s*10000)/10000

if(s == 0.2737)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("sigmoid_train Test failed")
end

/////////////////////////////////////////////



/////////Test case for       **)circshift                  /////////

 M = [1 2 3 4];
 R = circshift(M, [0 1])

if(R == [4 1 2 3])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("circshift failed")
end

/////////////////////////////////////////////



/////////Test case for       **)kaiser                 //////////

win = kaiser(6, 0.2) ;
win = round(win*10000)/10000;

if(win == [ 0.9901; 0.9964; 0.9996; 0.9996; 0.9964; 0.9901 ])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("kaiser Test failed")
end

/////////////////////////////////////////////


/////////Test case for       78)stmcb                 //////////


h = fscanfMat("macros/stmcb_h_data.txt");
H = stmcb(h,4,4);
H = round(H*10000)/10000;

if(H == [0.0003    0.001    0.0147  -0.0078    0.0317])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("stmcb Test failed")
end

/////////////////////////////////////////////


/////////Test case for       autoreg_matrix                 //////////
m = autoreg_matrix([1,2,3],2);

if(m == [1 0 0; 1 1 0; 1 2 1])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("autoreg_matrix test failed")
end

/////////////////////////////////////////////



/////////Test case for       arch_rnd                 //////////

a = [1 2 3 4 5];
b = [7 8 9 10];
t = 5 ;
m = arch_rnd (a, b, t);
m = round(m*1000)/1000

if(m == [    7.476
    67.124
    671.105
    7382.441
    80409.121  ])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("arch_rnd Test failed")
end

/////////////////////////////////////////////



/////////Test case for       arma_rnd                 //////////

a = [1 2 3 4 5];
b = [7; 8; 9; 10; 11];
t = 5 ;
v = 10 ;
n = 100 ;
m = arma_rnd (a, b, v, t, n);
m = round(m) ;

if(m == [    60562.
    156019.
    401911.
    1035344.
    2667081. ])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("arma_rnd Test failed")
end

/////////Test case for       buttap                 //////////

n = 5 ;
[z p g] = buttap(n);
g = round(g*10000)/10000;

if(g == 1)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("buttap Test failed")
end


/////////Test case for       cheb1ap                 //////////

[z p g] = cheb1ap(10, 3);
g = round(g*10000)/10000;

if(g == 0.002)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("cheb1ap Test failed")
end

/////////Test case for       cheb2ap                 //////////

[z p g] = cheb2ap(4, 10);
g = round(g*10000)/10000;

if(g == 0.3162)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("cheb2ap Test failed")
end

/////////Test case for       ellipap                 //////////

[z p g] = ellipap(4, 3, 10);
g = round(g*10000)/10000;

if(g == 0.3162)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("ellipap Test failed")
end

/////////Test case for       ncauer                 //////////

[z p g] = ncauer(3, 10, 4);
g = round(g*10000)/10000;

if(g == 0.3162)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("ncauer Test failed")
end

/////////Test case for       besselap                 //////////

[z p g] = besselap(5);
g = round(g*10000)/10000;
p = round(p*10000)/10000;

if(g == 1 & p == [-0.5906+0.9072*%i; -0.5906-0.9072*%i; -0.9264;  -0.8516+0.4427*%i; -0.8516-0.4427*%i])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("besselap Test failed")
end

/////////Test case for       zp2tf                 //////////

[num, den] = zp2tf ([1 2 3], [4 5 6], 5);
num = round(num*10000)/10000;
den = round(den*10000)/10000;

if(num == [5 -30 55 -30] & den == [1.  -15.    74.   -120])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("zp2tf Test failed")
end

/////////Test case for       tf2zp                 //////////

[z p k] = tf2zp ([1 2 3], [4 5 6]);
k = round(k*10000)/10000;
p = round(p*10000)/10000;
z = round(z*10000)/10000;

if(k == 0.25 & p == [-0.625+1.0533*%i; -0.625-1.0533*%i] & z == [-1+1.4142*%i; -1-1.4142*%i])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("tf2zp Test failed")
end

/////////Test case for       sftrans                 //////////

[Sz, Sp, Sg] = sftrans([1 2 3], [4 5 6], 15, 20, %T);
Sg = round(Sg*10000)/10000;
Sp = round(Sp*10000)/10000;
Sz = round(Sz*10000)/10000;

if(Sg == 0.75 & Sp == [5 4 3.3333] & Sz == [20 10 6.6667])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("sftrans Test failed")
end

/////////Test case for       bilinear                 //////////

[b a] = bilinear ([1 2 3], [4 5 6], 1, 1);
b = round(b*10000)/10000;
a = round(a*10000)/10000;


if(b == [0 -0.1667 -0.3333 2.5] & a == [1 7.3333 17.6667 14])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("bilinear Test failed")
end

/////////Test case for       postpad                 //////////

y = postpad([1 2 3], 6);

if(y == [1 2 3 0 0 0 ] )
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("postpad Test failed")
end

/////////Test case for       buttord                 //////////

[n, Wn] = buttord(40/500, 150/500, 3, 60);
Wn = round(Wn*10000)/10000;

if(n == 5 & Wn == 0.08)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("buttord Test failed")
end

/////////Test case for       butter                 //////////

[b a] = butter(4,0.3,"high");
b = round(b*10000)/10000;
a = round(a*10000)/10000;

if(b == [0.2754 -1.1017 1.6525 -1.1017 0.2754] & a == [1 -1.5704 1.2756 -0.4844 0.0762])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("butter Test failed")
end

/////////Test case for       besself                 //////////

[b, a]=besself(2,.3,"high","z");
b = round(b*10000)/10000;
a = round(a*10000)/10000;

if(b == [0.4668  -0.9336   0.4668 ] & a == [1.  -0.6913    0.176 ])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("besself Test failed")
end

/////////Test case for       cheb1ord                 //////////

[n, Wn]=cheb1ord([0.25 0.3],[0.24 0.31],3,10);
Wn = round(Wn*10000)/10000;

if(n == 3 & Wn == [0.25 0.3])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("cheb1ord Test failed")
end

/////////Test case for       cheby1                 //////////

[z, p, k]=cheby1(2,6,0.7,"high");
z = round(z*10000)/10000;
p = round(p*10000)/10000;
k = round(k*10000)/10000;

if(z == [1 1] & p == [-0.6292+0.5537*%i  -0.6292-0.5537*%i] & k == 0.0556)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("cheby1 Test failed")
end

/////////Test case for       cheb2ord                 //////////

Wp = 40/500;
Ws = 150/500;
Rp = 3;
Rs = 60;
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);
Ws = round(Ws*10000)/10000;

if(n == 4 & Ws == 0.3)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("cheb2ord Test failed")
end

/////////Test case for       cheby2                 //////////

[z, p, k]=cheby2(2,5,0.7,"high");
z = round(z*10000)/10000;
p = round(p*10000)/10000;
k = round(k*10000)/10000;

if(z == [-0.3165-0.9486*%i  -0.3165+0.9486*%i ] & p == [-0.3939+0.5314*%i  -0.3939-0.5314*%i ] & k == 0.4753)
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("cheby2 Test failed")
end

/////////Test case for       ellipord                 //////////

Wp = [60 200]/500;
Ws = [50 250]/500;
Rp = 3;
Rs = 40;
[n,Wp] = ellipord(Wp,Ws,Rp,Rs);
Wp = round(Wp*10000)/10000;

if(n == 5 & Wp == [0.12 0.4])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("ellipord Test failed")
end

/////////Test case for       ellip                 //////////

[b, a]=ellip(2, 3, 40, [0.3,0.4]);
b = round(b*10000)/10000;
a = round(a*10000)/10000;

if(b == [0.0203  -0.0164    0.0027  -0.0164    0.0203] & a == [1.  -1.7259    2.5097  -1.5593    0.8188 ])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("ellip Test failed")
end

/////////Test case for       wconv                 //////////
a = [1 2 3 4 5];
b = [7 8 9 10];
y = wconv(1,a,b);

if(y == [7.    22.    46.    80.    114.    106.    85.   50.])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("wconv Test failed")
end

/////////Test case for       chirp                 //////////
t = [4,3,2,1];
f0 = 4;
t1 = 5;
f1 = 0.9;
form = "quadratic";
y = chirp(t, f0, t1, f1, form);
y = round(y*10000)/10000;
if(y == [-0.6113    0.7459  -0.4854    0.9665])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("chirp Test failed")
end

/////////Test case for       dftmtx                 //////////
d = dftmtx(4);
if(d == [1 1 1 1; 1 -%i -1 %i; 1 -1 1 -1; 1 %i -1 -%i])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("dftmtx Test failed")
end

/////////Test case for       dctmtx                 //////////
T = dctmtx(3);
T = round(T*10000)/10000;
if(T == [0.5774  0.5774  0.5774; 0.7071  0  -0.7071; 0.4082 -0.8165 0.4082])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("dctmtx Test failed")
end

/////////////////////////////////////////////

/////////////////////////////////////////////


res=find(test_pass==0)

if(res~=[])
    disp("One or more tests failed")
    exit(1)
else
    disp("All test cases passed")
    exit
end
