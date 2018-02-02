%
% Generate White Noise with specific Power 
%
close all; clear all;
fs = 256; % Sampling Frequency 
t = (0:fs)/fs; % samples in duration 1 sec
n = 0.1*randn(size(t)); % Noise with Power 0.01
%
% Spectrum Analysis
%
[Pxx,f]=periodogram(n,[],[],fs); % Calculate periodogram Pxx
N=1000;
for i=1:N-1 % repeat calculations N-1 times
n = 0.1*randn(size(t));
Pxx=Pxx+periodogram(n,[],[],fs);
end
figure;plot(f,10*log10(Pxx/N))
xlabel('Frequency (Hz)')
ylabel('Power Spectral Density (dB/Hz)')