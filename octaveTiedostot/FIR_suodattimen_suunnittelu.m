function kertoimet = FIR_suodattimen_suunnittelu(NumberOfTaps,Fpassband,Fstopband)
#
# This function is used to design a lowpass FIR-filter
# Sampling frequency is set to Fs = 8000 Hz and
# ampitude specification of a lowpass filter is
# used
#

Fs = 8000;                                    % Sampling freg fixed
f = [0 Fpassband/(Fs/2) Fstopband/(Fs/2) 1];  % frequency specification
a = [1 1 0 0];                                % Amplitude specification 
                                              % of a lowpass filter
w = [1 100];                                    % weigth for both bands
                                              % passband and stopband
pkg load signal;                              % loads signal package

kertoimet = remez(NumberOfTaps,f,a,w);        % designs a FIR-filter

[h,w] = freqz(kertoimet);                     % calculates frequency response
taajuusakseli = (w/pi)*Fs/2;                  % scale the x-axis for Hz
figure(1);stem(kertoimet);
title('Filter impulse response',"fontsize",20);
xlabel('samples n starting from n = 0',"fontsize",22);
ylabel('Output of a filter to impuse signal = y(n)',"fontsize",22);
grid;

figure(2);semilogy(taajuusakseli,abs(h));
title('Filter frequency response',"fontsize",20);
xlabel('Frequency [Hz]',"fontsize",22);
ylabel('Amplification or attanuation of the filter',"fontsize",22);
grid;

% and finally lets write taps of the filter to kertoimet.h file
% for easy inclusion to your C-code.
filename = "kertoimet.h";
fid = fopen (filename, "w");
fprintf(fid,"const int pituus = %d;\n",length(kertoimet));
fprintf(fid,"float kertoimet[%d]={%d,\n",length(kertoimet),kertoimet(1));
for I = 2:length(kertoimet)-1
  fprintf(fid,"%d,\n",kertoimet(I));
end
fprintf(fid,"%d};\n",kertoimet(length(kertoimet)));
fclose(fid);

endfunction