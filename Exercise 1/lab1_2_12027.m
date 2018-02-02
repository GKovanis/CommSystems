clear all                   %clear working space
close all                   %close all plots
clc                         %clear command panel

% Create sine wave

Fs=500;                    %Sampling Frequency 500Hz
Ts=1/Fs;                   %ðSampling Period
T=1;                       %Signal Duration 0.1 sec 
t=0:Ts:T-Ts;               %Sampling Timestamps
A=1;                       %Signal Amplitude
x=A*sin(2*pi*50*t);        %Signal vector
L=length(x);               %Signal Length
plot(t,x)                  
pause                      

% Sine Fourier Discrete Transformation

N=2*L;                     %Length of Fourier Transformation
Fo=Fs/N;                   
Fx=fft(x,N);               % DFT for N points
freq=(0:N-1)*Fo;           % frequency vector
plot(freq,abs(Fx))         % FFT Amplitude 
title('FFT')               
pause                      
axis([0 100 0 L/2])        
pause                      

% Periodogram Plot 

power = Fx.*conj(Fx)/Fs/L; 
plot(freq,power)           
xlabel('Frequency (Hz)')   
ylabel('Power')            
title('{\bf Periodogram}') 

% Sine Wave Power Calculation

power_theory=A^2/2         
dB=10*log10(power_theory)  %in dB
power_time_domain=sum(abs(x).^2)/L 
power_frequency_domain=sum(power)*Fo 