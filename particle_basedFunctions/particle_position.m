function  [data] = particle_position(x_in,y_in,z_in,x_out,y_out,z_out)
data_in(:,1) = x_in; data_in(:,2) = y_in; data_in(:,3) = z_in; 
data_out(:,1) = x_out; data_out(:,2) = y_out; data_out(:,3) = z_out; 
data(1:length(x_in),1) = x_in; data(1:length(y_in),2) = y_in; data(1:length(z_in),3) = z_in;
data((length(x_in)+1):(length(x_in)+1)+length(x_out)-1,1) = x_out;
data((length(y_in)+1):(length(y_in)+1)+length(y_out)-1,2) = y_out;
data((length(z_in)+1):(length(z_in)+1)+length(z_out)-1,3) = z_out;