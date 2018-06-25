function [x_in,y_in,z_in,x_out,y_out,z_out,N_in,N_out,data_array_in,data_array_out] = particle_gen_mesh(N,x,y,z, x_pipe, y_pipe, z_pipe)
%% Generate the particles based on the mesh 
%ratio_pipe_blood = input('The ratio between blood wall and blood flow is ');
ratio_pipe_blood = 0.85;

N_in = round(N.*ratio_pipe_blood);
data_array_in = round(rand(1,N_in).*(length(x))+0.5);
x_in = x(data_array_in)'; 
y_in = y(data_array_in)'; 
z_in = z(data_array_in)';

N_out = round(N.*(1-ratio_pipe_blood));
data_array_out = round(rand(1,N_out).*length(x_pipe)+0.5);
x_out = x_pipe(data_array_out)'; 
y_out = y_pipe(data_array_out)'; 
z_out = z_pipe(data_array_out)';