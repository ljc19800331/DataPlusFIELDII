function [] = viz_particles(x,y,z,xlimit,ylimit,zlimit,color) 
% visualize the particles in the tube
plot3(x,y,z,color);grid on;
xlabel('x');ylabel('y');zlabel('z');
xlim([-xlimit,xlimit]);ylim([-ylimit,ylimit]);zlim([-zlimit,zlimit]);