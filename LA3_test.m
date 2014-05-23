 
   
m = 10; % mass in kg
k = .05; % drag coefficient in kg/m
v = 40; % initial velocity in m/s
d = 50; % distance to target in m
dw = 30; % distance to wall in m
hw = 5; % height of wall in m
w = 5; % wind speed in m/s
% theta = 38.; launch angle

g = 9.81;

%for (theta = 0:10:90) %(theta = 0:(pi/500):(pi/2))
    theta = 38

    v_x1 = v * cosd(theta);
    v_z1 = v * sind(theta);
    %e=2;
    z2 = 1;
    x1 = 0;
    z1 = 0;
    clearwall = 0;
    
    while (z2 > 0)
    
            v_eff = sqrt((v_x1 - w)^2 + v_x1^2);
            a_x = (-k / m) * (v_x1 - w) * v_eff;
            a_z = (-g) - ((k/m) * v_z1 * v_eff);
            v_x2 = v_x1 + ((.01) * (a_x)); 
            v_z2 = v_z1 + ((.01) * (a_z));
            x2 = x1 + ((.01) * (v_x1));
            z2 = z1 + ((.01) * (v_z1));
            
            if (((x2 <= (dw+.1)) && (x2 >= (dw-.1))) && (z2 > hw))
                clearwall = 1;
            end
            
            %x(e) = x2;
            %e = e + 1;
            
            x1 = x2;
            z1 = z2;
            v_x1 = v_x2;
            v_z1 = v_z2;
            
            hold on
            scatter(x2,z2,'.b')
    end
    
%end
    
    plot([50,50],[0,100],'-r')
    plot([30,30],[0,5],'-r')
    plot([0,(150)],[0,0],'-k')