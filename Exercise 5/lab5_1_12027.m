clear all; close all;
f1=2; f2=6; f3=12;
Fs=200;
order=256;
Fc=50;
t=[0:1/Fs:20]';
s=2*cos(2*pi*f1*t)+4*cos(2*pi*f2*t)+8*cos(2*pi*f3*t);
figure; pwelch(s,[],[],[],Fs);

s1=s;
s2=imag(hilbert(s));
ssb=sqrt(2)*(s1.*cos(2*pi*Fc*t)+s2.*sin(2*pi*Fc*t));
figure; pwelch(ssb,[],[],[],Fs);
ssb=awgn(ssb,20);
% ssb1=sqrt(2)*(s1.*cos(2*pi*Fc*t)-s2.*sin(2*pi*Fc*t));
figure; pwelch(ssb,[],[],[],Fs); title('Spectrum of Noisy Signal');
w=15;
p=(w-f3+f1)/2;
F1=Fc-f3-p; F2=Fc-f3; F3=Fc-f1; F4=Fc-f1+p;
fpts=[0 [F1 F2 F3 F4]/Fs 0.5]*2;
mag=[0 0 1 1 0 0];
wt=[1 1 1];
b=firpm(order,fpts,mag,wt);
ssb_bp=filter(b,1,ssb);
figure; pwelch(ssb_bp,[],[],[],Fs); 
title('Spectrum of Noisy Signal after Band-Pass filter Parks-McClellan');

dsb=sqrt(2)*s.*cos(2*pi*Fc*t);
figure; pwelch(dsb,[],[],[],Fs); 
fpts=[0 Fc-0.98*f1 Fc+0.98*f1 Fs/2]*2/Fs;
b=firpm(order,fpts,[1 1 0 0],[1 1]);
ssb1=conv(dsb,b,'same');
figure; pwelch(ssb1,[],[],[],Fs); 

clear z z1 z2;
z=sqrt(2)*ssb.*cos(2*pi*Fc*t);
figure; pwelch(z,[],[],[],Fs);

F1=1.1*f3/Fs; F2=1.5*F1;
fpts=[0 F1 F2 0.5]*2;
mag=[1 1 0 0];
wt=[1 1];
b=firpm(order,fpts,mag,wt);
a=1;
%[H,F]=freqz(b,a,512,'whole',Fs);
figure; freqz(b,a,512,Fs);

z_lp=conv(z,b,'same');
figure; pwelch(z_lp,[],[],[],Fs);
figure;
n=[200:400]; t1=t(n)*1000;
subplot(2,1,1); plot(t1,s(n));
maxs=max(s); mins=min(s);
axis([min(t1) max(t1) mins*1.1 maxs*1.1]);
title('Initial Signal'');
grid;
subplot(2,1,2); plot(t1,z_lp(n));
axis([min(t1) max(t1) mins*1.1 maxs*1.1]);
xlabel('time (msec)');
title('signal after demodulation');
grid;