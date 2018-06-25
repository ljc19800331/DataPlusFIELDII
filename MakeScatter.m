% This file aims at making scatter data

%% Basic setting and data procesing
% Basic paremeter setting
c = 1540;  %  Ultrasound speed of sound [m/s]
f0 = 2e6;  %  Center frequency of transducer [Hz] 
R = 0.0042 %  Radius of the tube [m] 

% Set the seed of the random number generator
randn('seed',sum(100*clock))    % normal distribution random particle data

%  Set the number of scatterers. It should be roughly 10 scatterers per cubic wavelength
z_range = 2*R       %[m]
y_range = 2*R       %[m]
x_range = 0.040     %[m] 
z_offset = 0.06;    %[m]

% Design the number of scatter in each wavelength
% c is the ultrasound speed of sound
% f0 is center frequency of transducer [Hz] 
lambda=c/f0;  
N=floor(10*x_range/(5*lambda)*y_range/(5*lambda)*z_range/(lambda*2));
disp([num2str(N),' Scatterers'])

% Generate the particles in the tube based on the mesh volume
[x_in,y_in,z_in,x_out,y_out,z_out,...
N_in,N_out,data_array_in,data_array_out] = ...
particle_gen_mesh(N,x,y,z,x_pipe, y_pipe, z_pipe);

% Visualize all the x,y,z in the vessel
figure(1);clf
viz_particles(x,y,z,0.02,0.01,0.01,'rx');
hold on;
viz_particles(x_pipe,y_pipe,z_pipe,0.02,0.01,0.01,'bx');
title('The 3D model of vessel');
set(gca,'Fontsize',16);
rotate3d on;

% Visualize the generated particles inside the vessel (particles only)
figure(2);clf
viz_particles(x_in,y_in,z_in,0.02,0.01,0.01,'rx');

% Viz the particles in the wall 
hold on;
viz_particles(x_out,y_out,z_out,0.02,0.01,0.01,'bx');
title('The particles of the vessel model');
set(gca,'Fontsize',16);
rotate3d on;

%% Find the particles within the vessel and assign amplitude

% The positions of all the particles -- this might not be important
[data] = particle_position(x_in,y_in,z_in,x_out,y_out,z_out); 

% The amplitude -- recommend to look into the function itself
[amp] = particle_amplitude(N_in,N_out,x_in,x_out);

%% Generate the velocity field for each time step

time_step = 50; % shoud be self-defined, in this case is 50

f = 1./time_step; % Time frequency based on the time step

for t = 1:n_file  % n_file -- number of each time step

% velocity field in each time step
vx = Vx{1,t}; % x velocity
vy = Vy{1,t}; % y velocity
vz = Vz{1,t}; % z velocity

% The velocity field for each particle for this time step
[vx_in,vy_in,vz_in,vx_out,vy_out,vz_out] = particle_vecfield(data_array_in,data_array_out,vx,vy,vz);

% Generate the rotated and offset block of sample, for particle
theta=60/180*pi; % 60 degree by default

% Change the coordinate and map to the aperature array
particle_map_array;

% visualize the whole process
figure(3);clf
n_3 = 1:length(x_in); 
plot3(xnew(n_3),ynew(n_3),znew(n_3),'rx');grid on;
hold on
n_4 = length(x_in)+1:(length(x_in)+length(x_out));
plot3(xnew(n_4),ynew(n_4),znew(n_4),'bx');grid on;
hold on
plot3(x_in,y_in,z_in,'rx');
xlabel('x');ylabel('y');zlabel('z');
zlim([-0.01,0.08]);xlim([-0.02,0.02]);ylim([-0.01,0.01]);
hold on
plot3(x_out,y_out,z_out,'gx');grid on;
xlabel('x');ylabel('y');zlabel('z');
drawnow;
title('The particles of healthy vessel blood flow'); 
set(gca,'Fontsize',16);

% Save the matrix with the values
cmd = ['save sim_flow_data/scat_data/scat_',num2str(t),'.mat positions amp']
eval(cmd);

% Create the control volume and get the velocity based on the 'Near' algorithm
particle_node_vec;

% Update the particle positions for each time step
x_in = x_in + (Vx_in(:,1).*f)';  % f is the time interval
y_in = y_in + (Vy_in(:,2).*f)';
z_in = z_in + (Vz_in(:,3).*f)';

% If the particle is out of vessel, then move to the begining and continue moving
outside_range= (x_in > x_range/2);
x_in = x_in - x_range*outside_range;

% viz the velocity and the particles in the tube
viz_particle_timestep(t,Vx_in,Vy_in,Vz_in,x_in,y_in,z_in,x_out,y_out,z_out);

end
