function taajuusanalyysi(signaali)
#
# This function can be used to calculate
# and plot frequency content of a signal
% Sampling fretuency is set to be 8000 Hz

Fs = 8000;
nfft = 512;
win = ones(1,length(signaali));
%win = hamming(length(signaali),"symmetric");
[Pxx, f] = periodogram (signaali, win, nfft, Fs);
figure(1);semilogy(f,Pxx);
title('Frequency spectrum of a input signal',"fontsize",20);
xlabel('frequency [Hz]',"fontsize",22);
ylabel('Power of a signal on a logarithmic scale',"fontsize",22);
grid

endfunction