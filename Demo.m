%% demo exp 3 -- healthy model
clc;close all;clear all; 
%% Initialize
field_init(0); 
%% Load the data from ANSYS, velocity, x-y-z position field
Ansys2MATLAB; 
%% Get the scatter data
MakeScatter;
%% Get the rf data
MakeRFdata;
%% Make the audio signal
ShowData;