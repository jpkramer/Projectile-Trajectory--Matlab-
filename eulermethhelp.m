% Jonathan Kramer

% Long Assignment 3

% ----------------------------Function----------------------------------

function [x1,z1,x2,z2,v_x1,v_z1] = eulermethhelp(x1,z1,v_x1,v_z1,w,k,m,dt)
% eulermethhelp takes the parameters and initial conditions for a given angle of catapult launch and outputs the position of the projectile at the various timesteps. 
%
% Inputs:
%   x1, z1     - initial position components of projectile
%   v_x1, v_z1 - initial velocity components of projectile
%   w          - wind speed in m/s
%   k          - drag coefficient in kg/m
%   m          - mass in kg
%   dt         - time step
%
% Outputs:
%   x1, z1     - initial position components of projectile for next
%                rotation of euler's method
%   
%   x2, z2     - final position components of projectile after this round
%                of euler's method
%
%   v_x1, v_z1 - initial velocity components of projectile for next
%                rotation of euler's method
%
%

            g = 9.81;

            v_eff = sqrt((v_x1 - w)^2 + v_x1^2);
            a_x = (-k / m) * (v_x1 - w) * v_eff;
            a_z = (-g) - ((k/m) * v_z1 * v_eff);
            v_x2 = v_x1 + ((dt) * (a_x)); 
            v_z2 = v_z1 + ((dt) * (a_z));
            x2 = x1 + ((dt) * (v_x1));
            z2 = z1 + ((dt) * (v_z1));
          
            x1 = x2;
            z1 = z2;
            v_x1 = v_x2;
            v_z1 = v_z2;
            
            
            