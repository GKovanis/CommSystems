(* ::Package:: *)

close all;clear all; clc;
load Sima_FM ; 
spectrogram(s,512,128,256,Fs)
pause;
fc=145.5*10^6;
dt = 1/Fs; % \[Alpha]\[Pi]\:03cc\[Sigma]\[Tau]\[Alpha]\[Sigma]\[Eta] \[Delta]\[CurlyEpsilon]\[Iota]\[Gamma]\[Mu]\:03ac\[Tau]\[Omega]\[Nu]
fo=240*10^3;
t = [1:length(s)]'*dt; % \[Chi]\[Rho]\[Omicron]\[Nu]\[Iota]\[Kappa]\:03ad\[FinalSigma] \[Sigma]\[Tau]\[Iota]\[Gamma]\[Mu]\:03ad\[FinalSigma] \[Delta]\[CurlyEpsilon]\[Iota]\[Gamma]\[Mu]\[Alpha]\[Tau]\[Omicron]\[Lambda]\[Eta]\[Psi]\:03af\[Alpha]\[FinalSigma]
d = s.*exp(-i*2*pi*fo*t); % \[Mu]\[Iota]\[Gamma]\[Alpha]\[Delta]\[Iota]\[Kappa]\:03ae \[Pi]\[CurlyEpsilon]\[Rho]\[Iota]\[Beta]\:03ac\[Lambda]\[Lambda]\[Omicron]\[Upsilon]\[Sigma]\[Alpha] \[Sigma]\[CurlyEpsilon] \[Rho]\[Upsilon]\[Theta]\[Mu]\:03cc 256 kHz
d1 = decimate(d,8,'fir'); % \[Mu]\[Iota]\[Gamma]\[Alpha]\[Delta]\[Iota]\[Kappa]\:03cc \[Sigma]\:03ae\[Mu]\[Alpha] \[Sigma]\[CurlyEpsilon] \[Rho]\[Upsilon]\[Theta]\[Mu]\:03cc 32 kHz
d2 = decimate(d1,4,'fir'); % \[Mu]\[Iota]\[Gamma]\[Alpha]\[Delta]\[Iota]\[Kappa]\:03cc \[Sigma]\:03ae\[Mu]\[Alpha] \[Sigma]\[CurlyEpsilon] \[Rho]\[Upsilon]\[Theta]\[Mu]\:03cc 8 kHz
y=angle(d2); % \[Alpha]\[Pi]\[Omicron]\[Delta]\[Iota]\[Alpha]\[Mu]\[Omicron]\[Rho]\[CurlyPhi]\[Omega]\[Mu]\:03ad\[Nu]\[Omicron] \[Sigma]\:03ae\[Mu]\[Alpha] FM
plot(y)
pause;
z= pwelch(y);
plot(z)
