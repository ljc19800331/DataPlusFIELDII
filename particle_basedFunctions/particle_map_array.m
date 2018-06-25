%% Map the positions to the array
xnew(1:length(x_in)) = x_in*cos(theta)+z_in*sin(theta);
xnew(length(x_in)+1:length(x_in)+length(x_out)) = x_out*cos(theta) + z_out*sin(theta); 
znew(1:length(z_in)) = z_in*cos(theta)-x_in*sin(theta) + z_offset;
znew(length(z_in)+1:length(z_in)+length(z_out)) = z_out*cos(theta)-x_out*sin(theta) + z_offset;
ynew(1:length(y_in)) = y_in; 
ynew(length(y_in)+1:length(y_in)+length(y_out)) = y_out;
positions=[xnew; ynew; znew;]';