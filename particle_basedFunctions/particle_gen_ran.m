function [x_p,y_p,z_p] = particle_gen_ran( x_range, y_range, z_range,N)
%% Generate the particles based on random distribution 
x_p=x_range*(rand(1,N)-0.5); % rand(1,N)-0.5 is the random distribution
y_p=y_range*(rand(1,N)-0.5);
z_p=z_range*(rand(1,N)-0.5);
