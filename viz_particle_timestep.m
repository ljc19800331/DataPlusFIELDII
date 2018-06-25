function [] = viz_particle_timestep(t,Vx_in,Vy_in,Vz_in,x_in,y_in,z_in,x_out,y_out,z_out)

% mean velocity of all the particle -- vx,vy,vz -- z is the length
figure(4);
vx_mean = mean( Vx_in(:,1) ); plot(t,vx_mean,'bx'); hold on
vy_mean = mean( Vy_in(:,2) ); plot(t,vy_mean,'gx'); hold on
vz_mean = mean( Vz_in(:,3) ); plot(t,vz_mean,'rx'); hold on
drawnow

% position viz of all the in-tube particles
% figure(3);hold on
% plot3(x_in,y_in,z_in,'rx'); grid on
% xlabel('x');ylabel('y');zlabel('z');
% zlim([-0.01,0.01]);xlim([-0.02,0.02]);ylim([-0.01,0.01]);
% hold on
% plot3(x_out,y_out,z_out,'gx');grid on;
% xlabel('x');ylabel('y');zlabel('z');
% zlim([-0.01,0.01]);xlim([-0.02,0.02]);ylim([-0.01,0.01]);
% drawnow