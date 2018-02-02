%%FM modulation with two tone signal
clear all; close all;
Fs=20000; % Sampling Frequency
t=[0:2*Fs+1]'/Fs; 
F1=20; F2=400; A1=0.2; A2=1;
%%relatively small modulation indexes
freqdev=480;
x=A1*cos(2*pi*F1*t)+A2*cos(2*pi*F2*t);
figure; pwelch(x,[],[],[],Fs);
xmax=max(abs(x));
kf=freqdev/xmax;
b1=A1*kf/F1; b2=A2*kf/F2;
DR=freqdev/400;
Bt=2*(DR+1)*400;
Fc=5000; 
%Modulation FM
y=fmmod(x,Fc,Fs,kf);
figure; pwelch(y,[],[],[],Fs);
y=awgn(y,15,'measured');
figure; pwelch(y,[],[],[],Fs);
f1=(Fc-Bt/2)/Fs; f2=(Fc+Bt/2)/Fs;
fpts=[0 f1 f1*1.01 f2 f2*1.026 0.5]*2;
mag=[0 0 0 1 0 0];
wt=[1 1 1];
a=1;
b=firpm(512,fpts,mag,wt);
figure; freqz(b,a,512,Fs); [H,F]=freqz(b,a,512,Fs); figure; plot(F,abs(H));
y=conv(y,b,'same');
p=abs(hilbert(y));
z=p-mean(p);
figure; pwelch(z,[],[],[],Fs);
%Band-Pass Filter Parks-McClellan
f1=F2/Fs; f2=1.5*f1;
order=240;
fpts=[0 f1 f2 0.5]*2;
mag=[1 1 0 0];
wt=[1 1];
b=firpm(order,fpts,mag,wt);
a=1;
[H,F]=freqz(b,a,512,Fs);
figure; plot(F,20*log(abs(H)));
%LP filtering
z_lp=Bt/kf*conv(z,b,'same');
figure; pwelch(z_lp,[],[],[],Fs);
% Plot of Initial and Final Signal
    n=[40:600];
figure; plot(t(n),x(n),'k-',t(n),z_lp(n),'r'); grid;
axis([min(t(n)) max(t(n)) 1.2*min(x(n)) 1.2*max(x(n))]);
legend('Initial Signal','Final Signal');
%Theoritical Calculation of specturm lines
z=[]; f=[];
for j=-4:4
for i=-5:5
    f=[f Fc+j*F2+i*F1];
    z=[z besselj(j,b2)*besselj(i,b1)];
end
end
logz=100+10*log10((z.^2)/2);
figure; stem(f,logz);
axis([0 Fs/2 max(logz)-80 max(logz)+10]); grid;    