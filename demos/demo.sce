//Example taken from https://in.mathworks.com/help/signal/examples/dft-estimation-with-the-goertzel-algorithm.html
//DFT Estimation with the Goertzel Algorithm
cd /home/fossee/Desktop/FOSSEE_Scilab_Octave_Interface_Toolbox

warning('off');
clc;
clear;
// Clock Signal with Noise
figure;
f=get("current_figure") 
f.background=8
fu=[1209,1336,1477,1633];
fl=[697,770,852,941];
dialer=ascii(['123A';'456B';'789C';'*0#D']);
dialer=matrix(dialer,4,4);
phno=ascii('123A456B789C*0#D');
//phno=ascii('9483999682');
Fs=8000;
T=0.1;
t=(0:Fs*T-1)/Fs;
pos=1;
tones=[];
for k=[phno]
	[j,i]=find(dialer==k);
	f1=fl(i);
	f2=fu(j);
	x=cos(2*%pi*f1*t)+cos(2*%pi*f2*t);
    subplot(4,4,4*(i-1)+(j))
    plot(x(1:25/T));
    title(msprintf(gettext("Symbol ""%s"" [%d,%d]"),char(k),f1,f2));
    tones(:,pos)=x';
    playsnd(x,Fs);
	sleep(80);
    pos=pos+1;
end;
disp("Press Enter to Continue");
halt();

//Estimating DTMF Tones with the Goertzel Algorithm
original_f = [fl(:);fu(:)];
Nt = 205;
k = round(original_f/Fs*Nt);

est_tones = tones(1:Nt,:);
exec('goertzel.sci',-1);
figure;
f=get("current_figure") 
f.background=8
color0=[2,5,13,16];
for toneChoice=[1:length(phno)]
    tone=est_tones(:,toneChoice);
    ydft(:,toneChoice) = goertzel(tone,(k+1)');
    subplot(4,4,toneChoice);
    plot2d3('gnn',original_f,abs(ydft(:,toneChoice)),color0(pmodulo(toneChoice,4)+1));
    [j,i]=find(dialer==phno(toneChoice));
	f1=fl(i);
	f2=fu(j);
    title(msprintf(gettext("Symbol ""%s"" [%d,%d]"),char(phno(toneChoice)),f1,f2));
end
disp("End of demo");
