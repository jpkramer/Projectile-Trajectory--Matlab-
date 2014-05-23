% Jonathan Kramer

% Long Assignment 3

% ----------------------------Parameters----------------------------------

% Using file parameters.txt
% m = 10; % mass in kg
% k = .05; % drag coefficient in kg/m
% v = 40; % initial velocity in m/s
% d = 50; % distance to target in m
% dw = 30; % distance to wall in m
% hw = 5; % height of wall in m
% w = 5; % wind speed in m/s
% eps = 0.01; % tolerance in m
% dt = .001; % time step

file = input('Enter the name of the file containing your desired parameters.\n>>> ','s');
ifile = fopen(file);
parameters = fscanf(ifile, '%f %f %f %f %f %f %f %f %f');

m = parameters(1);
k = parameters(2);
v = parameters(3);
d = parameters(4);
dw = parameters(5);
hw = parameters(6);
w = parameters(7);
eps = parameters(8);
dt = parameters(9);


% ---------------------------Initializing---------------------------------

g = 9.81;
accepted_theta = 0;

time = (0:dt:50);
len_time = length(time);
x = zeros(1,len_time);

angle = (0:1:54);
len_angle = length(angle);
acc_theta = zeros(1,len_angle);
acc_range = zeros(1,len_angle);
f = 1;

clearwall_first = 0;

% ------------------------Scanning Range of Angles------------------------

for (theta = 0:1:90)
    
    v_x1 = v * cosd(theta);
    v_z1 = v * sind(theta);
  
    e = 2;
    z2 = 1;
    x1 = 0;
    z1 = 0;
    clearwall = 0;
    
    while (z2 > 0)
    
            [x1,z1,x2,z2,v_x1,v_z1] = eulermethhelp(x1,z1,v_x1,v_z1,w,k,m,dt);
            
            % sets up conditions for clearing wall
            if (((x2 < (dw+.01)) && (x2 > (dw-.01))) && (z2 > hw))
                clearwall = 1;
            end
            
            x(e) = x2;
            e = e + 1;
            
    end
    
    % only considers ranges and angles in which trajectory clears the wall
    if (clearwall)
       acc_range(f) = max(x); 
       acc_theta(f) = theta;
       f = f + 1;
        
    end
    
end

% ----------------Finding angles that give max/min range-------------------

maxrange = max(acc_range);
minrange = min(acc_range);

m = 1;
while (acc_range(m) ~= maxrange)
    m=m+1;
end

theta_maxdist = acc_theta(m);

n = 1;
while (acc_range(n) ~= minrange)
    n=n+1;
end

theta_mindist = acc_theta(n);
     
    
% ------------------------Performing Bisection----------------------------

% requires that min range path is between wall and target 
% and max range path is beyond target
if ((maxrange > d) && ((minrange > dw) && (minrange < d)))
 
  max_theta = theta_maxdist; 
  min_theta = theta_mindist; 
  Done = 1;
    
    while (Done)
     
        mid_theta = (max_theta + min_theta) / 2;
    
        v_x1 = v * cosd(mid_theta);
        v_z1 = v * sind(mid_theta);
   
        z2 = 1;
        x1 = 0;
        z1 = 0;
        
    while (z2 > 0)
    
            [x1,z1,x2,z2,v_x1,v_z1] = eulermethhelp(x1,z1,v_x1,v_z1,w,k,m,dt);
            
    end
    
    
    if ((x2 < (d+eps)) && (x2 > (d-eps)))
        accepted_theta = mid_theta;
        Done = 0;
        
    elseif (x2 > d) 
        max_theta = mid_theta;
        
    else
        min_theta = mid_theta;
    end    
    
    
    end
    
end

% ----------------------------Printing------------------------------------

if (accepted_theta == 0)
    fprintf('This combination of parameters does not yield an acceptable angle!\n')
else
    fprintf('The correct angle is %7.6f degrees.\n', accepted_theta)
end

% ----------------------------Plotting------------------------------------

    v_x1 = v * cosd(accepted_theta);
    v_z1 = v * sind(accepted_theta);
   
    z2 = 1;
    x1 = 0;
    z1 = 0;
  
    while (z2 > 0)
      
    plot(x1,z1,'.b')
    
           [x1,z1,x2,z2,v_x1,v_z1] = eulermethhelp(x1,z1,v_x1,v_z1,w,k,m,dt);
            
            hold on
           
    end
    
   
    plot([d,d],[0,100],'-r')
    plot([dw,dw],[0,hw],'-r')
    plot([0,(150)],[0,0],'-k')
    title('Correct Trajectory')
    xlabel('x-position')
    ylabel('z-position')
    
    