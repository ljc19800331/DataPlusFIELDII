function [vx_in,vy_in,vz_in,vx_out,vy_out,vz_out] = particle_vecfield(data_array_in,data_array_out,vx,vy,vz)
vx_in = vx(data_array_in);
vy_in = vy(data_array_in);
vz_in = vz(data_array_in);

vx_out = zeros(length(data_array_out),1);
vy_out = zeros(length(data_array_out),1);
vz_out = zeros(length(data_array_out),1);