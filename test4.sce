test_pass=[]
res=[]


test4=0


//<----------------test case for cceps------------------>
//x=[1 2 3];
//correct=1;

//vp=cceps(x, correct);
//vi=[ 1.92565
//     0.96346
//   -1.09735];
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;  
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('cceps test failed.');
//end



//<----------------test case for clustersegment------------------>
// x=[0,1,0,0,1,1]
//vp = clustersegment(x)
// 
//vi=[2 5;2 6]
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('clustersegment test failed.');
//end
//
//<----------------test case for cmorwavf------------------>
lb=1; ub=2; n=1; fb=3;
fc=4;

[a,b]=cmorwavf(lb,ub,n,fb,fc)

a1=0.0858628;
b1=2;

a1=round(a1*100)/100;
a=round(a*100)/100;
b1=round(b1*100)/100;
b=round(b*100)/100;


if(a==a1) then
          if (b==b1) then
    test_pass=[test_pass,1];
    end
else
     test_pass=[test_pass, 0];
    disp('cmorwavf test failed.');
end

////<----------------test case for czt------------------>
// x=[4 5 6 3 2]; fs = 1000; f1 = 100; f2 = 150;     
// m = 8; 
// w = exp(-%i*2*%pi*(f2-f1)/(m*fs)); 
//a = exp(%i*2*%pi*f1/fs); 
//             
// vp = czt(x, m, w, a);
//// 
//vi=[7.3541-12.6740*%i 6.2892-12.5620*%i	5.2710-12.3493*%i	4.3097-12.04432*%i	3.4142-11.6568*%i	2.5919-11.1975*%i	1.84859-10.6776*%i	1.18835-10.1088*%i
//]
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
////
////
//if(vp==vi)
//   test_pass=[test_pass,1];
//else
//    test_pass=[test_pass, 0];
//    disp('czt test failed.');
//end
//


//<----------------test case for diric------------------>
 x=[1 2 3];
 n=3;

 vp=diric(x,n);
 
vi=[0.6935349    0.0559021  -0.3266617]
vi=round(vi*100)/100;
vp=round(vp*100)/100;

if(vp==vi)
    test_pass=[test_pass,1];
else
     test_pass=[test_pass, 0];
    disp('diric test failed.');
end

//<----------------test case for dst1 ------------------>
// x=[3 5 2 7];
// n=3;
//
// vp=dst1(x,n);
// 
//vi=[ 8.5355339  
//    1.         
//  - 1.4644661 ]
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('dst1 test failed.');
//end



//<----------------test case for fft1 ------------------>
//x = [1 2 3; 4 5 6; 7 8 9]
//n = 3
//dim = 2
//vp=fft1 (x, n, dim)
// 
//vi=[6.0	-1.5000000000000009+0.8660254037844375*%i	-1.4999999999999984-0.8660254037844406*%i
//15.0	-1.5000000000000018+0.8660254037844357*%i	-1.4999999999999973-0.8660254037844428*%i
//24.0	-1.5000000000000018+0.8660254037844348*%i	-1.4999999999999964-0.8660254037844455*%i]
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('fft1 test failed.');
//end
//




//<----------------test case for fftconv ------------------>
//x=[1, 2, 3];
//y=[3,4,5]
//vp=fftconv(x, y)
// 
//vi=[3; 10; 22; 22;  15]
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('fftconv test failed.');
//end

//<----------------test case for fftn ------------------>
//x=[2 3 4];
//siz=[1 5]
//
//vp=fftn(x,siz);
// 
//
//vi=[9.0000+0.0000*%i;  -0.3090-5.2043*%i ;  0.8090+2.0409*%i; 0.8090-2.0409*%i;  -0.3090+5.2043*%i]
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('fftn test failed.');
//end
//

//<----------------test case for fht ------------------>
//x=1:4;
//vp=fht(x)
//
//
//vi=[10;   -4;   -2;   0]
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('fht test failed.');
//end


//<----------------test case for filter1 ------------------>
//b=[1,2,3];
//a= [3,4,5];
//x= [5,6,7];
//[a b]=filter1(b, a, x)
//
//
//a1=[1.6666667 3.1111111 4.4074074];
//b1=[- 0.3950617; - 0.3456790];
//
//a=round(a*100)/100;
//a1=round(a1*100)/100;
//b=round(b*100)/100;
//b1=round(b1*100)/100;
//
//
//if(a==a1) then
//          if (b==b1) then
//    test_pass=[test_pass,1];
//    end
//else
//     test_pass=[test_pass, 0];
//    disp('filter1 test failed.');
//end

//<----------------test case for filtic ------------------>
b=[%i,1,-%i,5];
a= [1,2,3*%i];
y= [0.8*%i,7,9];

vp=filtic(b,a,y)



vi=[- 22.6*%i; 2.4; 0 ]

vi=round(vi*100)/100;
vp=round(vp*100)/100;


if(vp==vi)
    test_pass=[test_pass,1];
else
     test_pass=[test_pass, 0];
    disp('filtic test failed.');
end

//<----------------test case for fractdiff ------------------>
x=[4 5 6];
d=3;

vp=fractdiff(x,d)

vi=[]

vi=round(vi*100)/100;
vp=round(vp*100)/100;


if(vp==vi)
    test_pass=[test_pass,1];
else
     test_pass=[test_pass, 0];
    disp('fractdiff test failed.');
end


//<----------------test case for gauspuls ------------------>
t=[1 2 3];
fc=1; bw=1;
vp=gauspuls(t,fc,bw)


vi=[0.0281016    0.0000006    1.093D-14]

vi=round(vi*100)/100;
vp=round(vp*100)/100;


if(vp==vi)
    test_pass=[test_pass,1];
else
     test_pass=[test_pass, 0];
    disp('gauspuls test failed.');
end


//<----------------test case for gaussian ------------------>
//m=5;a=6;
//vp = gaussian (m, a)
//
//vi=[ 5.380D-32; 1.523D-08; 1; 1.523D-08; 5.380D-32]
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('gaussian test failed.');
//end
//
////<----------------test case for idct1 ------------------>
//x=[1 3 6];n=6;
//vp=idct1(x,n)
//
//vi=[ 5.0812809  
//    1.6329932  
//  - 2.143464   
//  - 3.0400394  
//  - 0.8164966  
//    1.7352157]
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('idct1 test failed.');
//end
//

//<----------------test case for idst1 ------------------>
//x=[1 3 6];n=6;
//vp=idst1(x,n)
//
//vi=[ 2.4654143  
//    1.8028286  
//  - 0.6898286  
//  - 1.4336286  
//    0.1315286  
//    1.1251286 ]
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('idst1 test failed.');
//end
//

//<----------------test case for ifft1 ------------------>
//x = [1 2 3; 4 5 6; 7 8 9];
//n = 3;
//dim = 2
//vp=ifft1 (x, n, dim)
//
//vi=[ 2  -0.5+0.2886751*%i  -0.5-0.2886751*%i  
//    5  -0.5+0.2886751*%i  -0.5-0.2886751*%i  
//    8  -0.5+0.2886751*%i  -0.5-0.2886751*%i];
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('ifft1 test failed.');
//end
//

//<----------------test case for ifht ------------------>
//x = [1 2 3 4];
//n = 2;
//dim = 2;
//
//vp=ifht(x,n, dim)
//
//vi=[1.5  -0.5];
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('ifht test failed.');
//end
//
//<----------------test case for kaiserord ------------------>

f=[1000, 1200]; m=[1, 0]; dev= [0.05, 0.05]; fs= 11025;

[a b c d] = kaiserord (f, m, dev, fs)

a1=70; b1=0.19955; c1=1.5099; d1='low'


a=round(a*100)/100;
a1=round(a1*100)/100;
b=round(b*100)/100;
b1=round(b1*100)/100;
c=round(c*100)/100;
c1=round(c1*100)/100;


if(a==a1)
          if (b==b1)
                    if (c==c1)
                              if (d==d1)
    test_pass=[test_pass,1];
end
end
end
else
     test_pass=[test_pass, 0];
    disp('kaiserord test failed.');
end


//<----------------test case for meyeraux ------------------>
x = [1 2 3];

vp=meyeraux(x);

vi=[1    -208  -10287];

vi=round(vi*100)/100;
vp=round(vp*100)/100;


if(vp==vi)
    test_pass=[test_pass,1];
else
     test_pass=[test_pass, 0];
    disp('meyeraux test failed.');
end

//<----------------test case for morlet ------------------>
//lb = [1 2 3];
//ub=[1 2 3];
//n=1;
//
//[a,b]=morlet(lb, ub, n);
//
//a1=[0.1720498  
//  -0.1135560  
//  -0.0084394];
//  
//  b1=[1;2;3]
//
//a=round(a*100)/100;
//a1=round(a1*100)/100;
//b=round(b*100)/100;
//b1=round(b1*100)/100;
//
//
//if(a==a1)
//          if (b==b1)
//    test_pass=[test_pass,1];
//    end
//else
//     test_pass=[test_pass, 0];
//    disp('morlet test failed.');
//end
//
//<----------------test case for rceps ------------------>
        
//x =[1 4.0315 8.1095 11.9561];
//
//[a b]=rceps(x);
//
//a1=[2.4703812  
//    0.3236025  
//    0.1051662  
//    0.3236025];
//    
//    b1=[12.240472  
//    7.7643989  
//    3.7471281  
//    1.3451011]
//
//a=round(a*100)/100;
//a1=round(a1*100)/100;
//b=round(b*100)/100;
//b1=round(b1*100)/100;
//
//
//if(a==a1)
//          if (b==b1)
//    test_pass=[test_pass,1];
//    end
//else
//     test_pass=[test_pass, 0];
//    disp('rceps test failed.');
//end
//



//<----------------test case for rectpuls------------------>
x = [1 2 3];

vp=meyeraux(x);

vi=[1    -208  -10287];

vi=round(vi*100)/100;
vp=round(vp*100)/100;


if(vp==vi)
    test_pass=[test_pass,1];
else
     test_pass=[test_pass, 0];
    disp('rectpuls test failed.');
end


//<----------------test case for sawtooth------------------>
t = [1 2 3 4 5];
width=0.5;
vp=sawtooth(t,width);
vi=[-0.36338   0.27324   0.90986   0.45352  -0.18310]

vi=round(vi*100)/100;
vp=round(vp*100)/100;


if(vp==vi)
    test_pass=[test_pass,1];
else
     test_pass=[test_pass, 0];
    disp('sawtooth test failed.');
end



//<----------------test case for sgolay------------------>
p=1; n=3; m=0;
vp=sgolay (p, n, m)

vi=[0.83333   0.33333  -0.16667
 0.33333   0.33333   0.33333
 -0.16667   0.33333   0.83333]

vi=round(vi*100)/100;
vp=round(vp*100)/100;


if(vp==vi)
    test_pass=[test_pass,1];
else
     test_pass=[test_pass, 0];
    disp('sgolay test failed.');
end

//<----------------test case for sgolayfilt------------------>
//x=[1;2;4;7]; p=0.3; n= 3; m=0; ts=0;
//vp=sgolayfilt (x, p, n, m, ts)
//
//vi=[  2.3333333  
//   2.3333333  
//  4.3333333  
// 4.3333333]
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('sgolayfilt test failed.');
//end
//
//<----------------test case for shanwavf------------------>
//lb=2; ub=8; n=3; fb=1; fc=6
//[a b]=shanwavf(lb,ub,n,fb,fc)
//
//a1 =   [-3.8982e-17 + 1.1457e-31*%i   3.8982e-17 - 8.4040e-31*%i  -3.8982e-17 + 4.5829e-31*%i]
//	b1 =   [2   5   8]
//a=round(a*100)/100;
//a1=round(a1*100)/100;
//b=round(b*100)/100;
//b1=round(b1*100)/100;
//
//if(a==a1)
//          if (b==b1)
//    test_pass=[test_pass,1];
//    end
//else
//     test_pass=[test_pass, 0];
//    disp('shanwavf test failed.');
//end
//
//<----------------test case for sinewave------------------>
//x=8; n= 4; 
//vp=sinewave(x, n)
//
//vi=[0 1 1.225D-16  -1  -2.449D-16 1  3.674D-16 -1]
//
//vi=round(vi*100)/100;
//vp=round(vp*100)/100;
//
//
//if(vp==vi)
//    test_pass=[test_pass,1];
//else
//     test_pass=[test_pass, 0];
//    disp('sinewave test failed.');
//end
//
//<----------------test case for sos2tf------------------>
sos = [1  1  1  1  0 -1; -2  3  1  1 10  1];
[a b]=sos2tf(sos)

a1 =[ -2   1  2  4  1];
b1 =[ 1 10  0 -10 -1];

a=round(a*100)/100;
b=round(b*100)/100;
a1=round(a1*100)/100;
b1=round(b1*100)/100;


if(a==a1) 
          if (b==b1)
    test_pass=[test_pass,1];
    end
else
     test_pass=[test_pass, 0];
    disp('sos2tf test failed.');
end

//<----------------test case for sos2zp------------------>
sos = [1,2,3,4,5,6];
[a b c ] = sos2zp (sos)

a1 =[-1.0000 + 1.4142*%i
-1.0000 - 1.4142*%i];
b1 =[-0.6250 + 1.0533*%i
 -0.6250 - 1.0533*%i];
c1 =  1;

a=round(a*100)/100;
b=round(b*100)/100;
a1=round(a1*100)/100;
b1=round(b1*100)/100;

c1=round(c1*100)/100;
c=round(c*100)/100;


if(a==a1) 
          if (b==b1)
                    if (c==c1)
    test_pass=[test_pass,1];
end
end
else
     test_pass=[test_pass, 0];
    disp('sos2zp test failed.');
end

//<----------------test case for welchwin------------------>
x=4; opt="symmetric"; 
vp=welchwin(x, opt)

vi=[0.         
   0.8888889  
    0.8888889  
    0.]

vi=round(vi*100)/100;
vp=round(vp*100)/100;


if(vp==vi)
    test_pass=[test_pass,1];
else
     test_pass=[test_pass, 0];
    disp('welchwin test failed.');
end

res=find(test_pass==0)

if(res~=[])
    disp("One or more tests failed in test1")
    test4=1;
end

