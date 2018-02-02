clear all; close all; clc;
load Sima_SSB ;
fo=52900;
dt = 1/Fs; % sample distance
t = [1:length(s)]'*dt; % Sampling Timestamps
d = s.*exp(-i*2*pi*fo*t+pi/3); % Complex signal at 0 Hz
d1 = decimate(d,8,'fir'); % Complex Signal with rate 32 kHz
d2 = decimate(d1,4,'fir'); % Complex Signal with rate 8 kHz
y=real(d2); % Demodulated SSB
plot(y)
soundsc(y,8000)
pause;
z= pwelch(y);
plot(z)