%function [Vx_in,Vy_in,Vz_in] = particle_node_vec(x,y,z,vx,vy,vz,x_in,y_in,z_in)

for j = 1:length(x_in)

sample_x = x_in(j);
sample_y = y_in(j);
sample_z = z_in(j);

delta_pos(:,1) = (x - sample_x).^2; % delta_x vector
delta_pos(:,2) = (y - sample_y).^2; % delta_y vector
delta_pos(:,3) = (z - sample_z).^2; % delta_z vector

% Find the first 8 nearest control points
delta_pos(:,4) = sqrt( delta_pos(:,1) + delta_pos(:,2) + delta_pos(:,3) ); 
pos_distance = delta_pos(:,4);
[B,I] = sort(pos_distance);  % Here I is the position number of the near 8 points

% The number of closest 8 points
data_array = I(1);

% assign the velocity to the each particle
Vx_in(j,1) = mean( vx(data_array) );
Vy_in(j,2) = mean( vy(data_array) ); 
Vz_in(j,3) = mean( vz(data_array) );

end