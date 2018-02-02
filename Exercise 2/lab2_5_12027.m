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
w = blackman(L); %Blackman window in time 
Fs=1; % Sampling Frequency 1 Hz
Ts=1/Fs; % Sampling Period
T=L*Ts; % Signal Length 32 sec
n=(0:Ts:T-Ts); 
A=1; % Signal Amplitude
phi=0; % Signal Phase
f=0.25; % Frequency (cycles/sample)
x=A*cos(2*pi*n*f+phi);
X=fft(x.*w'); 
%
% First Signal Time Plot 
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
% First  Signal Frequency Plot
%
magX=abs(X); % Spectrum Amplitude
N=length(X); % FFT Length
fn=[0:1/N:1-1/N]; 
subplot(3,1,2); 
stem(fn,magX,'ok'); 
grid on; 
xlabel('Normalized Frequency (cycles per sample))');
ylabel('Magnitude (Linear)');
pause
%
% First  Signal Frequency plot (in dB):
%
spec=20*log10(magX); % Spectrum Amplitude in dB
subplot(3,1,3); 
plot(fn,spec,'--sr'); 
grid on;
axis([0 1 0 30]); %
xlabel('Normalized Frequency (cycles per sample))');
ylabel('Magnitude (dB)');
f=0.25+0.5/L; % Frequency (cycles per sample)
x=A*cos(2*pi*n*f+phi);
X=fft(x.*w'); 
pause
%
% Second Signal Time Plot
%
figure(2);      % άνοιγμα παραθύρου για γραφική παράσταση
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
% Second  Signal Frequency Plot
%
magX=abs(X); % Spectrum Amplitude
N=length(X); % FFT Length
fn=[0:1/N:1-1/N]; 
subplot(3,1,2); 
stem(fn,magX,'ok'); 
grid on; 
xlabel('Normalized Frequency (cycles per sample))');
ylabel('Magnitude (Linear)');
pause
%
% First  Signal Frequency plot (in dB):
%
spec=20*log10(magX); % Spectrum Amplitude in dB
subplot(3,1,3); 
plot(fn,spec,'--sr'); 
grid on;
axis([0 1 0 30]); %
xlabel('Normalized Frequency (cycles per sample))');
ylabel('Magnitude (dB)');