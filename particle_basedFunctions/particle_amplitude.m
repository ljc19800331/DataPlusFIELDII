function [amp] = particle_amplitude(N_in,N_out,x_in,x_out)
blood_to_stationary= 10;   % Ratio between amplitude of blood to stationary tissue
amp_out = randn(1,N_out).*1;
amp_in = randn(1,N_in).*blood_to_stationary;
amp(1:length(x_in)) = amp_in;
amp(length(x_in)+1:length(x_in)+length(x_out)) = amp_out; 
amp = amp';