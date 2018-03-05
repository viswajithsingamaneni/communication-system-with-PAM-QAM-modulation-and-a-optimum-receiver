clc;
N0=4.1*(10^(-21));
M=4;
T=10;
fc=10;
A=2;
t=1:1:T;
m1=1:1:sqrt(M);
m2=1:1:sqrt(M);
re=rectpuls((t-T/2),T);
re(1,T)=1;
g= (A.*(re)')';
%QAM Modulation
AIm1= (2*m1)-1-(sqrt(M));
AIm2= (2*m2)-1-(sqrt(M));
Smq= ((AIm1.*( g.* cos(2*pi*fc*t))') - (AIm2.*(g.* sin(2*pi*fc*t))'));
Esavg=((((M)-1)*(A^2))/3);
SNR0=10*log10(Esavg/N0);
%Demodulation
r=awgn(Smq,SNR0)
%SER
An=(10^-1)*(1:100);
x=(3*log2(M))/((M^2)-1);
y=(1-(1/sqrt(M)));
for i=1:length(An)
    q(i)=sqrt(x*((An(i)^2)/N0));
    SNR_db(i)=10*(log10((An(i)^2)/N0));
end;
%theoretical SER
SER_th=4*y*qfunc(q).*((1-(y*qfunc(q))))
SER=berawgn(q,'qam',4)
%plots
semilogy(SNR_db,SER,':r*',SNR_db,SER_th,':g*');
grid on;
xlabel('SNR in dB');
ylabel('SER');
title('practical and theoretical SER plots of 4-QAM');