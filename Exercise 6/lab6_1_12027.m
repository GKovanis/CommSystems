clear all; close all;
Fs=20000;
t=[0:2*Fs+1]'/Fs;
F1=20; F2=400; A1=0.2; A2=1;
freqdev=480;
x=A1*cos(2*pi*F1*t)+A2*cos(2*pi*F2*t);
figure; pwelch(x,[],[],[],Fs);
xmax=max(abs(x));
kf=freqdev/xmax;
b1=A1*kf/F1; b2=A2*kf/F2;
D=freqdev/400;
Bt=2*(D+1)*400;
Fc=5000;
y=fmmod(x,Fc,Fs,kf);
figure; pwelch(y,[],[],[],Fs);
y=awgn(y,15,'measured');
figure; pwelch(y,[],[],[],Fs);
z=fmdemod(y,Fc,Fs,kf);
figure; pwelch(z,[],[],[],Fs);
f1=F2/Fs; f2=1.5*f1;
order=240;
fpts=[0 f1 f2 0.5]*2;
mag=[1 1 0 0];
wt=[1 1];
b=firpm(order,fpts,mag,wt);
a=1;
[H,F]=freqz(b,a,512,Fs);
figure; plot(F,20*log(abs(H)));
z_lp=conv(z,b,'same');
figure; pwelch(z_lp,[],[],[],Fs);
n=[40:600];
figure; plot(t(n),x(n),'k-',t(n),z_lp(n),'r'); grid;
axis([min(t(n)) max(t(n)) 1.2*min(x(n)) 1.2*max(x(n))]);
legend('Initial Signal','Final Signal');
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