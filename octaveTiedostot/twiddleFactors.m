Fs = 8000;
Ts = 1/Fs;
t = 0:Ts:1-Ts;
f = 1000;
x = cos(2*pi*f*t+pi/2);
N = 16;
verrokit = zeros(16,16);
X = zeros(1,N);

for m = 0:N-1
   for n = 0:N-1
      X(m+1) = X(m+1) + x(n+1)*exp(-j*(2*pi*m*n)/N);
      verrokit(m+1,n+1)=exp(j*(2*pi*m*n)/N);
   end
end

filename = "inv_twiddle.h";
%filename = "twiddle.h";
fid = fopen (filename, "w");
riveja = N;
sarakkeita = N;

fprintf(fid,"float kosini[%d][%d]={\n",riveja,sarakkeita);

for I = 1:riveja-1
   for J = 1:sarakkeita
        fprintf(fid,"%f , ",real(verrokit(I,J)))
   end
   fprintf(fid,"\n");
end
for J = 1:sarakkeita-1
        fprintf(fid,"%f , ",real(verrokit(N,J)))
end
fprintf(fid,"%f};\n",real(verrokit(N,N)));

fprintf(fid,"float sini[%d][%d]={\n",riveja,sarakkeita);

for I = 1:riveja-1
   for J = 1:sarakkeita
        fprintf(fid,"%f , ",imag(verrokit(I,J)))
   end
   fprintf(fid,"\n");
end
for J = 1:sarakkeita-1
        fprintf(fid,"%f , ",imag(verrokit(N,J)))
end
fprintf(fid,"%f};\n",imag(verrokit(N,N)));



fclose(fid);