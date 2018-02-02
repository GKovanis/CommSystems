clear all; close all;
f1=108; f2=110;
Fs=256; Ts=1/Fs;
N=2^14;
nsamp=8; Dt=Ts/nsamp; t=Dt*[1:1:N*nsamp];

SNR=10;
x=cos(2*pi*f1*t)+0.25*sin(2*pi*f2*t); 
xn=awgn(x,SNR,'measured');

td=t(1:nsamp:length(t));
xd=xn(1:nsamp:length(xn));
figure; pwelch(x,[],[],[],Fs*nsamp);
pause;
figure; pwelch(xn,[],[],[],Fs*nsamp);
pause;
figure; pwelch(xd,[],[],[],Fs);
pause;

f01=f1-3; f11=f1-1; f12=f2+1; f02=f2+3;
order=256;
fpts=[0 [f01 f11 f12 f02]/Fs/nsamp 0.5]*2;
mag=[0 0 1 1 0 0];
wt=[1 1 1];
b=firpm(order,fpts,mag,wt); a=1;  % FIR filter Parks Mcllelan 
yn=filter(b,a,xn);
pause;

figure; pwelch(yn,[],[],[],Fs*nsamp);

order=256;
fpts=[0 [f01 f11 f12 f02]/Fs 0.5]*2;
mag=[0 0 1 1 0 0];
wt=[1 1 1];
b=firpm(order,fpts,mag,wt); a=1; 
yd=filter(b,a,xd);
pause;

figure; pwelch(yd,[],[],[],Fs);


sub=8; Fs2=Fs/sub; Ts2=1/Fs2;
td2=t(1:sub*nsamp:length(t));
xd2=downsample(xn,sub*nsamp);
pause;
figure; pwelch(xd2,[],[],[],Fs2);
yd2=downsample(yn,sub*nsamp);
pause;
figure; pwelch(yd2,[],[],[],Fs2);
yd3=downsample(yd,sub);
pause;
% Nyquist
figure; pwelch(yd3,[],[],[],Fs2);