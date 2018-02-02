clear all; close all;
Fs=8192;
t=0:1/Fs:1;
s=sin(2*pi*500*t)+sin(2*pi*1000*t)+sin(2*pi*1500*t)+sin(2*pi*2000*t);
figure; pwelch(s,[],[],[],Fs);
%Low Pass Filter Function H with cutting frequency of Fs/8.
H=[ones(1,Fs/8) zeros(1,Fs-Fs/4) ones(1,Fs/8)];
% Frequency Response of inverse Fourier Transformation
% Alternatively, we can use analtyical function Sa(x)
h=ifft(H,'symmetric');
middle=length (h)/2;
h=fftshift(h);
h32=h(middle+1-16:middle+17);
h64=h(middle+1-32:middle+33);
h128=h(middle+1-64:middle+65);
% figure; stem([0:length(h64)-1],h64); grid;
% figure; freqz(h64,1); 
wvtool(h32,h64,h128); 
wh=hamming(length(h128));
wk=kaiser(length(h128),5);
figure; plot(0:128,wk,'r',0:128,wh,'b'); grid;
h_hamming=h128.*wh';
% figure; stem([0:length(h64)-1],h_hamming); grid;
% figure; freqz(h_hamming,1);
h_kaiser=h128.*wk';
wvtool(h128,h_hamming,h_kaiser);
% We filter our signal with each one of the three filters
y_rect=conv(s,h128);
figure; pwelch(y_rect,[],[],[],Fs);
y_hamm=conv(s,h_hamming);
figure; pwelch(y_hamm,[],[],[],Fs);
y_kais=conv(s,h_kaiser);
figure; pwelch(y_kais,[],[],[],Fs);
% Low-Pass Parks-MacClellan
hpm= firpm(64, [0 0.10 0.15 0.5]*2, [1 1 0 0]);
%figure; freqz(hpm,1);
s_pm=conv(s,hpm);
figure; pwelch(s_pm,[],[],[],Fs);