%% FM Modulation signal of constant spectrum
clear all; close all;
load sima_lp;
F1=fc(1); 
F2=fc(2); 
figure; pwelch(sima_lp,[],[],[],Fs);
D=8;
s=interp(sima_lp,D); Fs=Fs*D; F1=F1/D; F2=F2/D; % cutting frequencies
s=s/max(abs(s));
t=[1:length(s)]'/Fs;
figure; pwelch(s,[],[],[],Fs);
Fc=12500;
freqdev=1800;
sintegr=0;
for i=1:length(t)
    sintegr=sintegr+s(i)*1/Fs;
    y(i)=cos(2*pi*Fc*t(i)+2*pi*freqdev*sintegr);
end
y=max(abs(sima_lp))*y';
figure; pwelch(y,[],[],[],Fs);
%% Band-Pass filter before demodulation
y=awgn(y,25,'measured');
figure; pwelch(y,[],[],[],Fs);
DR=freqdev/(F2*Fs);
f1=Fc/Fs-(DR+2)*F2; fh=Fc/Fs+(DR+2)*F2; % Carson's rule
M=128;
hpm=firpm(M,[0 f1*0.95 f1*1.02 fh*0.98 fh*1.05 0.5]*2,[0 0 1 1 0 0]);
figure; freqz(hpm,1,512,Fs);
y=conv(y,hpm,'same');
figure; pwelch(y,[],[],[],Fs);
kf=freqdev/max(abs(s));
sh=hilbert(y);
phase=unwrap(angle(sh)-2*pi*Fc*t);
z=diff (phase)./diff(t)/kf/2/pi;
figure; pwelch(z,[],[],[],Fs);
% Band-Pass filter Parks-McClellan
f1=F2; f2=1.1*f1; order=64*D;
fpts=[0 f1 f2 0.5]*2;
mag=[1 1 0 0]; wt=[1 1];
b=firpm(order,fpts,mag,wt);
z_lp=conv(z,b,'same');
figure; pwelch(z_lp,[],[],[],Fs);
% Plot the original and recovered signals.
n=[4500:7000];
figure; plot(t(n),s(n),'k-',t(n),z_lp(n),'r');
grid; axis([min(t(n)) max(t(n)) 1.2*min(s(n)) 1.2*max(s(n))]);
legend('Initial Signal','Final Signal');
figure; pwelch(downsample(z_lp,D),[],[],[],Fs);