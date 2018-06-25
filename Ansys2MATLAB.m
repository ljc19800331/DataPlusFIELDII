%%  Load the data file
% n1 and n2 are the index of the node number in the data file
n1 = 8;  
n2 = 27343;

% Assign the data to the variable ([n1,n2] is first to last number)
filename = 'stenosis_pos_x.dat'; 
x = dlmread(filename,' ',[n1 1 n2 1]); 
filename = 'stenosis_pos_y.dat';
y = dlmread(filename,' ',[n1 1 n2 1]); 
filename = 'stenosis_pos_z.dat';
z = dlmread(filename,' ',[n1 1 n2 1]); 

% Save x,y,z to a matrix for easy operation
position_xyz(:,1) = x;
position_xyz(:,2) = y;
position_xyz(:,3) = z;

% Move the original center to the (0,0) to make it symmetic such that the
% origin is (0,0) and not (0.02,0)
% This is based on the parameter of the ultrasound simulation
x = x - 0.02;       % unit:m

%% Read the position values for the vessel wall (referred as pipe)

n3 = 8; 
n4 = 5836; % sometimes this is the same as n1 and n2, but not necessarily

% pipe information
filename = 'stenosis_pipe_x.dat'; 
x_pipe = dlmread(filename,' ',[n3 1 n4 1]); 
filename = 'stenosis_pipe_y.dat'; 
y_pipe = dlmread(filename,' ',[n3 1 n4 1]); 
filename = 'stenosis_pipe_z.dat'; 
z_pipe = dlmread(filename,' ',[n3 1 n4 1]); 

% similar oepration as the previous section
x_pipe = x_pipe - 0.02;

%% Read the velocity data

% in this case, n_file is 50 since we only test 50 files
n_file = input('The number of time step is (prefer 50)');  

for i = 1: n_file   
    
    filename = ['stenosis_vec_x_(',num2str(i),').dat']; 
    Vx{i} = dlmread(filename,' ',[n1 1 n2 1]); 
    filename = ['stenosis_vec_y_(',num2str(i),').dat']; 
    Vy{i} = dlmread(filename,' ',[n1 1 n2 1]); 
    filename = ['stenosis_vec_z_(',num2str(i),').dat']; 
    Vz{i} = dlmread(filename,' ',[n1 1 n2 1]); 

end

