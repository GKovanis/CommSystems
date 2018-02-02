clear all;
close all;
t = 0:.001:1-0.001; %time vector
x = cos(2*pi*30*t) + 0.1*sin(2*pi*300*t); %sine signal
y = downsample(x,4); 
figure(1);
% Adding first code
subplot(1,2,1);
stem(x(1:240));
hold on;
stem([1:4:240],y(1:60),'r');
axis([1 240 -1.2 1.2]);
hold off;
subplot(1,2,2);
plot(abs(fft(y))); % Spectrum Amplitude of y
pause;
% decimate
y = decimate(x,4); 
figure(2);
subplot(1,2,1);
stem(x(1:240));
hold on;
stem([1:4:240],y(1:60),'r');
axis([1 240 -1.2 1.2]);
hold off;
subplot(1,2,2);
plot(abs(fft(y))); % Spectrum Amplitude of y
pause;
%Adding second code
y = upsample(x,4);
figure(3);
subplot(1,2,1);
stem(x(1:240));
hold on;
stem([1:4:240],y(1:60),'r');
axis([1 240 -1.2 1.2]);
hold off;
subplot(1,2,2);
plot(abs(fft(y))); % Spectrum Amplitude of y
pause;
% interp
y = interp(x,4); 
figure(4);
subplot(1,2,1);
stem(x(1:240));
hold on;
stem([1:4:240],y(1:60),'r');
axis([1 240 -1.2 1.2]);
hold off;
subplot(1,2,2);
plot(abs(fft(y))); % Spectrum Amplitude of y
pause;
% Adding third code
y1=resample(x,2,3); %Dilution 2/3
y2 = resample(x,3,2); % Densing 3/2
figure(5);
subplot(1,2,1);
stem(x(1:60));
hold on;
stem([1:1.5:60],y1(1:40),'r');
axis([1 60 -1.2 1.2]);
hold off;
pause;
subplot(1,2,2);
stem([1:1.5:90],x(1:60));
hold on;
stem(y2,'r');
axis([1 90 -1.2 1.2]);
hold off;
pause;
% Spectrums
figure(6);
subplot(1,2,1);
plot(abs(fft(y1)));
subplot(1,2,2);
plot(abs(fft(y2)));
pause;