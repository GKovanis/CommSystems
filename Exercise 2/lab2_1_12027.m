%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example 1 - DFT of Sine Wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear all                   %clear working space
close all                   %close all plots
clc                         %clear command panel
%
% Create a Sine wave with Frequency 0.25 Hz %
L=32; % Signal Length 
Fs=1; % Sampling Frequency 1 Hz
Ts=1/Fs; % Sampling Period
T=L*Ts; % Signal Length 32 sec
n=(0:Ts:T-Ts); 
A=1; % Signal Amplitude
phi=0; % Signal Phase
f=0.25; % Frequency (cycles/sample)
x=A*cos(2*pi*n*f+phi);
X=fft(x); % Spectrum
%
% Signal Time Plot 
%
figure(1);      
subplot(3,1,1); 
                
plot(n,x,'*k'); 
pause           
                
hold on;        
                
t=0:0.1:T;      
plot(t,A*cos(2*pi*f*t+phi),'-b'); 
grid off;       
title('Sinusoid at 1/4 the Sampling Rate'); 
xlabel('Time (samples)'); 
ylabel('Amplitude');      
hold off;                 
                          
pause
%
% Signal Frequency Plot
%
magX=abs(X); % Spectrum Amplitude
N=length(X); % FFT length
fn=[0:1/N:1-1/N]; % normalized Frequencies
subplot(3,1,2); 
stem(fn,magX,'ok');
grid on; 
xlabel('Normalized Frequency (cycles per sample))');
ylabel('Magnitude (Linear)');
pause
%
% Signal Frequency plot (in dB):
%
spec=20*log10(magX); % Spectrum Apmlitude in dB
subplot(3,1,3); 
plot(fn,spec,'--sr');
grid on;
axis([0 1 -300 30]); 
xlabel('Normalized Frequency (cycles per sample))');
ylabel('Magnitude (dB)');
                         