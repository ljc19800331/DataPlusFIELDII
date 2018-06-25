
% Initializing
field_init(0);

% Generate the transducer apertures for send and receive
f0=1e6;                  %  Transducer center frequency [Hz]
M=8;                     %  Number of cycles in emitted pulse
fs=100e6;                %  Sampling frequency [Hz]
c=1540;                  %  Speed of sound [m/s]
lambda=c/f0;             %  Wavelength [m]
width=lambda/2;          %  Width of element
element_height=5/1000;   %  Height of element [m]
kerf=0.05/1000;          %  Kerf [m]
focus=[0 0 60]/1000;     %  Fixed focal point [m]
N_elements=64;           %  Number of physical elements

% notice this number is different -- can be changed
% Nshoots=5000;            %  Number of shots to be processed: default
Nshoots = 50; 

% Do not use triangles
set_field('use_triangles',0);

% Set the sampling frequency
set_sampling(fs);

% Generate aperture for emission
emit_aperture = xdc_linear_array (N_elements, width, element_height, kerf, 1, 1,focus);

% Set the impulse response and excitation of the emit aperture
impulse_response=sin(2*pi*f0*(0:1/fs:2/f0));
impulse_response=impulse_response.*hanning(max(size(impulse_response)))';
xdc_impulse (emit_aperture, impulse_response);

excitation=sin(2*pi*f0*(0:1/fs:M/f0));
xdc_excitation (emit_aperture, excitation);

% Generate aperture for reception
receive_aperture = xdc_linear_array (N_elements, width, element_height, kerf, 1, 1,focus);

% Set the impulse response for the receive aperture
xdc_impulse (receive_aperture, impulse_response);

% Set a Hanning apodization on the apertures
apo=hanning(N_elements)';
xdc_apodization (emit_aperture, 0, apo);
xdc_apodization (receive_aperture, 0, apo);

%% Calculate scatter signal for all positions

i=1;
lines_done=0;

while (i<=Nshoots)

  i
    
  % Check if the file already exits
  file_name = ['sim_flow_data/rf_data/rf_ln',num2str(i),'.mat'];
  cmd = ['fid = fopen(file_name,''r'');'];
  eval(cmd);
  
  % Do the processing if the file does not exits
  if (fid == -1)
    cmd=['save sim_flow_data/rf_data/rf_ln',num2str(i),'.mat i']
    eval(cmd);
    
    % Load the data
    cmd = ['load sim_flow_data/scat_data/scat_',num2str(i),'.mat']
    eval(cmd);

    % Calculate the received response
    % The positions and amp information are important
    [rf_data, tstart]=calc_scat(emit_aperture, receive_aperture, positions, amp);
    cmd=['save sim_flow_data/rf_data/rf_ln',num2str(i),'.mat rf_data tstart']
    eval(cmd)
    lines_done=lines_done+1;

  else
     fclose (fid);
  end
     i=i+1;

end




