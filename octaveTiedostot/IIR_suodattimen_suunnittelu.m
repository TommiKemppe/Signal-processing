function [SOS b a]=IIR_suodattimen_suunnittelu(NumberOfTaps,Fcutoff)
#
# This function can be used to design an IIR-filter.
# Function returns both Second Order Section (SOS) coefficients
# and direct form coefficients b = feedforward coefficients and a = feedback 
# coefficients. Sampling frequency is fixed to 8000 Hz

Fs = 8000;

pkg load signal;        

#[b,a] = butter(NumberOfTaps,Fcutoff/(Fs/2));

rp = 0.01; 
#rippeli päästökaistalla desibeleinä
rs = 100;
#suodatin

[b,a] = ellip(NumberOfTaps,rp,rs,Fcutoff/(Fs/2));

% You will find out that butterworth filter is not optimal
% test also cheby1 and ellip filter design fuctions
% google => octave chepy or octave ellip


[h,w] = freqz(b,a);
taajuusakseli = (w/pi)*Fs/2;
figure(1);semilogy(taajuusakseli,abs(h));
title('Filter frequency response',"fontsize",20);
xlabel('Frequency [Hz]',"fontsize",22);
ylabel('Amplification or attanuation of the filter',"fontsize",22);
grid;

figure(2);zplane(b,a);title('IIR-suodattimen nolla-napakartta');
title('Filter pole-zero "map"',"fontsize",20);
grid;

% And finally lets convert direct form coefficients to
% second order filters and plot them to a file

 SOS = tf2sos(b,a);
 koko = size(SOS);
 riveja = koko(1);
 sarakkeita = koko(2);


filename = "IIR_kertoimet.h"
fid = fopen (filename, "w");
fprintf(fid,"const int riveja = %d;\n",riveja);
fprintf(fid,"const int sarakkeita = %d;\n",sarakkeita);
fprintf(fid,"float SOS[%d][%d]={\n",riveja,sarakkeita);
for I = 1:riveja-1
      fprintf(fid,"%f, %f, %f, %f, %f, %f,\n",SOS(I,1:sarakkeita))
end
fprintf(fid,"%f, %f, %f, %f, %f, %f};\n",SOS(riveja,1:sarakkeita))
fclose(fid);

endfunction