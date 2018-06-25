% Program to take audio data and convert it into a sonogram
%
%  Version 3, 23/10-96, by JAJ, after version by Henrik Klebaek

%  Find the number of samples

lines=max(size(audio));   % For example, 'audio' has 5000 samples number in 1 second

%  Set parameters for calculating the sonogram
dN=floor(lines/1000+0.5);       %  Number of new samples for spectrum, here dN is 5
Ndft=256;                       %  Samples in one spectrum -- 256
Nspec=floor((lines-Ndft)/dN);   %  Number of spectra -- 948, like the range of the wave
f0=2e6;                         %  Transducer center frequency
fprf=5e3;                       %  Pulse repetition frequency: default

%  Initialize data structure
power_dft=zeros(Ndft,Nspec); % Samples in the spectrum corresponding to the spectra
power_min=[];
power_max=[];

disp('Making spectrum...')
for i=1:Nspec     %Number of spectra = 948
  if (rem(i,50)==0)
    i
    end  
  sig=( audio( (i-1)*dN+(1:Ndft) ) )';  %Use a sliding window to get each sample
  sig=sig.*hanning(Ndft);   % divide by hanning window
  dft=fftshift(abs(fft(sig)).^2);  %discrete Fourier transform of the power
  power_dft(:,i)=dft;
end

%  Scale power density
power_min=min(min(power_dft));
power_max=max(max(power_dft));
scale=128/(power_max-power_min);
power_dft=(power_dft-power_min)*scale;

% scale again aftering using log transformation
power_dft=log(power_dft+0.005);  % Change to power spectrum density (dB)?
power_min=min(min(power_dft));
power_max=max(max(power_dft));
scale=128/(power_max-power_min);
power_dft=(power_dft-power_min)*scale;

f=fprf/Ndft*(   (Ndft/2) : -1 : -(Ndft/2-1)  );    % (128~-128) -- 256 -- (-0.5~0.5) -- -2500~2500
tidsakse = (1:Nspec)*dN/fprf;   %(1:948) * (5 / 5000): Moving time 5/5000 = 0.001; The lenght is 948

%  Make the figure

image(  tidsakse,  f/1000,  power_dft(Ndft:-1:1,:)  );		% Sonogram-plot
map=gray(128);
colormap(map(128:-1:1,:))
brighten(0.2)

title('Sonogram model');					
xlabel('Time [s]');
ylabel('Frequency [kHz]');
set(gca,'Fontsize',16);


