clear all; close all;
f1=2; f2=6; f3=12;
Fc=50; Fs=200; order=256;
t=[0:1/Fs:20];
s=2*cos(2*pi*f1*t)+4*cos(2*pi*f2*t)+8*cos(2*pi*f3*t);
figure; pwelch(s,[],[],[],Fs);
title('Initial Signal Spectrum');
dsb=sqrt(2)*s.*cos(2*pi*Fc*t);
figure; pwelch(dsb,[],[],[],Fs);
title('DSB Signal Spectrum');

w=10;
fpts=[0 45/Fs (Fc-0.4*w)/Fs (Fc+0.4*w)/Fs 55/Fs 0.5]*2;
mag=[1 1 1 0 0 0];
bpf=firpm(order,fpts,mag);
[H,f]=freqz(bpf,1,401);
f=f*Fs/2/pi;
figure;
subplot(2,1,1);
stem(bpf);
title('frequency response of filter fir');
subplot(2,1,2);
plot(f,abs(H));
axis([0 Fs/2 0 1.5]); grid;
xlabel('Frequency (Hz)');
title('frequency response of filter fir');
hold off;

fsb_lb=conv(dsb,bpf,'same');
% vsb_lb=awgn(vsb_lb,15,'measured');
figure; pwelch(fsb_lb,[],[],[],Fs);
title('Signal Spectrum');

s_dm=sqrt(2)*fsb_lb.*cos(2*pi*Fc*t);
figure; pwelch(s_dm,[],[],[],Fs);
title('Signal Spectrum after Demodulation');

hpm=fir1(order,15/Fs*2);
s_pm=conv(s_dm,hpm,'same');
figure; pwelch(s_pm,[],[],[],Fs);
title('Demodulated Signal spectrum after BandPass Filter');
figure;
n=[200:400]; t1=t(n)*1000;
subplot(2,1,1); plot(t1,s(n));
maxs=max(s); mins=min(s);
axis([min(t1) max(t1) mins*1.1 maxs*1.1]);
title('Initial Signal'); grid;
subplot(2,1,2); plot(t1,s_pm(n));
maxs=max(s); mins=min(s);
axis([min(t1) max(t1) mins*1.1 maxs*1.1]);
xlabel('time (msec)');
title('Final Signal'); grid;