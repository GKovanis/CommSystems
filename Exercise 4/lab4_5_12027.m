%Part 4
clear all; close all;
load sima_AM;
fc=134.85*10^6;
spectrogram(s,512,128,256,Fs)
pause;
%Part 5
fo=252*10^3;
dt = 1/Fs; % sample distance
t = [1:length(s)]'*dt; % sampling timestamps
d = s.*exp(-i*2*pi*fo*t); % Complex Envelope with rate 256 kHz
d1 = decimate(d,8,'fir'); % Complex signal with rate 32 kHz
d2 = decimate(d1,4,'fir'); % Complex signal with rate 8 kHz
y=abs(d2); % AM signal
plot(y)
pause;