clear all; close all;
load sima_lp;
F1=fc(1); 
F2=fc(2); 
figure; pwelch(sima_lp,[],[],[],Fs);
pause;
Fs=Fs*4;
s_dense=interp(sima_lp,4);
figure; pwelch(s_dense,[],[],[],Fs);
pause;
s_dense=s_dense+2*max(abs(s_dense));
figure; pwelch(s_dense,[],[],[],Fs);
pause;
%%%% DSB Modulation
Fc=4*F2;  
s_dsb=sqrt(2)*s_dense.*cos(2*pi*Fc*[1:length(s_dense)]');
figure; pwelch(s_dsb, [], [], [], Fs);
pause;
%%%% DSB Demodulation
s_dsb_dm=abs (hilbert(s_dsb))/sqrt(2);
figure; pwelch(s_dsb_dm, [], [], [], Fs);
pause;
%
s_dsb_lp = decimate(s_dsb_dm,4); Fs=Fs/4;
s_dsb_lp=s_dsb_lp-mean(s_dsb_lp);
figure; pwelch(s_dsb_lp, [], [], [], Fs);
pause;
%%%% Comparison with initial signal
n=[200:400];
t=[1:length(sima_lp)]'/Fs;
figure; plot(t(n),sima_lp(n),t(n),s_dsb_lp(n),':'); grid;
axis([min(t(n)) max(t(n)) 1.2*min(sima_lp(n)) 1.2*max(sima_lp(n))]);
legend('Initial Signal'',' Final Signal');