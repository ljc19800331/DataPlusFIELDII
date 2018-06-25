%% Use the RF data for medical image processing
f0=5e6;                  %  Transducer center frequency [Hz]
fs=100e6;                %  Sampling frequency [Hz]
c=1540;                  %  Speed of sound [m/s]
fprf=5e3;                %  Pulse emissions frequency  [Hz] : default
D=20;                    %  Sampling frequency decimation rate

% you may change this number for other application
no_lines=5000;           %  Number of lines for one direction(RF-lines)

% Load the data for one image line and a number of pulse emissions
data=zeros(250,no_lines);  % 250 is the length of the whole RF-lines

%% Get the audio signal based on STFT and Hilbert transform
% Go for the literature for more details
for i=1:no_lines
  if (rem(i,20)==0)    % compute the remainder of i over 20
    i
    end
  start_sample=6000;  % What does it mean?

  cmd=['load sim_flow_data/rf_data/rf_ln',num2str(i),'.mat'];
  eval(cmd);
  
%  Decimate the data and store it in data
%  extract the signal based on the start time
  rf_sig = rf_data (  start_sample-tstart*fs : length(rf_data)   );  
  rf_sig = hilbert(rf_sig(1:D:max(size(rf_sig))));
  data(1:length(rf_sig),i)=rf_sig(1:length(rf_sig));
end

%% Get the audio file with the RF data
data_real = real(data(125,:)); % '125' is the center value of the whole RF-lines
plot(real(data(125,:)),'b')   % this is on the centerline which is half of 250

drawnow
audio=data(125,:);
save audio.mat audio
xlim([0,2500]);
xlabel('Time step'); ylabel('Waveform');
title('Audio-healthy model');
set(gca,'FontSize',15);
