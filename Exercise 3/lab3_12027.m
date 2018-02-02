close all;
clear all;
clc;
Xb=[1 1 1 0 0 0 0 1 1]; % BandPass Signal Spectrum with even summetry
figure; 
subplot (2,1,1);
plot([-4:4],Xb); 
ylabel('Xb');
x=ifft(Xb) % IFFT
xb=fftshift(x) % real signal with even summetry as expected
subplot (2,1,2); plot([-4:4],xb); ylabel('xb');