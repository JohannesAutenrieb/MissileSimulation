% This is the Code for the use-case example of the flight dynamic class

%Step 1: Loading of the linearization solution

load Llinear_Model.mat;


% %------longitudinal movement

%computing of eigenvalues
eigenvalues_longitudinal_movement=eig(A_long)
longitudinal_sys = ss(A_long, B_long, C_long, D_long)
figure(1);
plot(eigenvalues_longitudinal_movement, '*')
title('Longitudinal Mode')
xlabel('Real Axis') 
ylabel('Imaginary Axis')
grid on

% comuting damping and natrual frequency
damp(longitudinal_sys)

%------lateral movement

%computing of eigenvalues
eigenvalues_lateral_movement=eig(A_lat)
lateral_sys = ss(A_lat, B_lat, C_lat, D_lat)
figure(2);
plot(eigenvalues_lateral_movement, '*')
title('Lateral Mode')
xlabel('Real Axis') 
ylabel('Imaginary Axis')
grid on

% comuting damping and natrual frequency
damp(lateral_sys)

% --------- END OF CODE -------------------------------------------------