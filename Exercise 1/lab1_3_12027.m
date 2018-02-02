clear all                   %clear working space
close all                   %close all plots
clc                         %clear command panel

Fs=500;                                      % Sampling Frequency 500 Hz
Ts=1/Fs;                                     % Sampling Period
L=1000;                                      % Number of Samples
T=L*Ts;                                      % Signal Duration
t=0:Ts:(L-1)*Ts;                             % Signal Timestamps

x=sin(2*pi*20*t)+ 0.8*sin(2*pi*70*(t-2));    % Signal Vector
figure(1)                                    
plot(t,x)                                    
title('Time domain plot of x')               
xlabel('t (sec)')                            
ylabel('Amplitude')                          
pause                                        
axis([0 0.2 -2 2])                           
pause                                        

N = 2^nextpow2(L);                           % Length of Fourier Transformation
Fo=Fs/N;                                     % Frequency analysis
f=(0:N-1)*Fo;                                % Frequency vector
X=fft(x,N);                                  % FFT for N samples

figure(2)                                    
plot(f(1:N),abs(X(1:N)))                     
title('Frequency domain plot of x')          
xlabel('f (Hz)')                             
ylabel('Amplitude')                          
pause                                        

figure(3)                                    
f=f-Fs/2;                                    % Shift Signal Fs/2 to the left
X=fftshift(X);                               % Shift zero Frequency to middle of spectrum
plot(f,abs(X));title('Two sided spectrum of x');xlabel('f (Hz)');ylabel('Amplitude')
pause                                        

power=X.*conj(X)/N/L;                        % Power Density
figure(4)                                    
plot(f,power)                                
xlabel('Frequency (Hz)')                     
title('{\bf Periodogram}')                   
pause                                        

disp('Part2')

si=size(x);
n=0.2*randn(si);                            % White Noise

figure(5)                                   
plot(t,n);
axis([0 0.2 -2 2])                          
title('Plot')                        
xlabel('Time (sec)')                        
ylabel('Amplitude')                         
pause                                       
Fn=fft(n,N);
powerNoise=Fn.*conj(Fn)/Fs/L;
figure(6)                                   
plot(f,powerNoise)
xlabel('Frequency (Hz)')                    
ylabel('Power')                             
title('Periodogram of Gaussian Noise')      
pause                                       

s = x + n;
figure(7)                                   
plot(t,s)
title('Signal plus Noise')                  
xlabel('Time (sec)')                        
ylabel('Amplitude')                         
pause                                       
axis([0 0.2 -2 2])
pause

S=fft(s,N);
S=fftshift(S); 
figure(8)                                   
plot(f,abs(S))
title('Two sided spectrum of Signal plus Noise')
xlabel('Frequency (Hz)')                    
ylabel('Amplitude')                         
pause                                       

disp('Part3')

ns=sin(2*pi*100*t);                         
multis=ns.*s;                                      

figure(9)                                   
plot(t,multis)
title('Time domain plot of Multiciplated Signals')
xlabel('Time (sec)')                        
ylabel('Amplitude')                         
pause      
axis([0 0.2 -2 2])
pause                                       

Multis=fft(multis,N);
Multis=fftshift(Multis);
figure(10)                                  
plot(f,abs(Multis))
title('Two sided spectrum of Multiciplated Signals')
xlabel('Frequency (Hz)')                    
ylabel('Amplitude')                         
pause                                       