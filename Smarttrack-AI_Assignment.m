% MATLAB Code to plot a 3D model of a single-axis solar tracker
figure;
hold on;
axis equal;
view(30, 30); 

% Define module dimensions and number of modules
module_length = 2; % meters (length of each module)
module_width = 1; % meters (width of each module)
rows = 2; % Number of rows of modules
modules_per_row = 60; % Number of modules in each row

% Define the tracker beam height and tilt angle
ground_clearance = 0.5; % meters
beam_height = 3; % meters (height of tracker beam above ground)
tilt_angle = 15; % degrees (tilt of the tracker beam)

% Define foundation dimensions
foundation_width = 0.4; % meters (width of foundation supports)
foundation_height = 0.6; % meters (height of the foundation support)

% Define tracker beam dimensions (length and height)
beam_length = modules_per_row * module_length; % Total length of the tracker beam
beam_angle_rad = deg2rad(tilt_angle); % Convert tilt angle to radians

% Plot the tracker beam (3D)
beam_x = [0, beam_length];
beam_y = [0, 0]; % Base of the beam along the X-axis
beam_z = [ground_clearance, ground_clearance + beam_height * cos(beam_angle_rad)]; % Z-axis considering tilt
plot3(beam_x, beam_y, beam_z, 'k-', 'LineWidth', 3); % Tracker beam in black
hold on;

% Plot the solar modules (3D)
for row = 0:rows-1
    for col = 0:modules_per_row-1
        x_pos = col * module_length; % x-position of each module
        y_pos = row * (module_width + 0.2); % y-position of each module (space between rows)
        z_pos = ground_clearance; % Set modules at ground level
        
        % Plot each solar module as a 3D box
        plot3([x_pos, x_pos + module_length], [y_pos, y_pos], [z_pos, z_pos], 'b-', 'LineWidth', 2); % Bottom edge
        plot3([x_pos, x_pos + module_length], [y_pos + module_width, y_pos + module_width], [z_pos, z_pos], 'b-', 'LineWidth', 2); % Top edge
        plot3([x_pos, x_pos], [y_pos, y_pos + module_width], [z_pos, z_pos], 'b-', 'LineWidth', 2); % Left edge
        plot3([x_pos + module_length, x_pos + module_length], [y_pos, y_pos + module_width], [z_pos, z_pos], 'b-', 'LineWidth', 2); % Right edge
    end
end

% Plot the foundation support (3D)
for col = 0:modules_per_row-1
    x_pos = col * module_length + 0.5; % Slight offset for foundation support
    plot3([x_pos, x_pos], [0, 0], [0, -foundation_height], 'r-', 'LineWidth', 2); % Vertical foundation support
end

% Add drive system (motor, actuator, and pivot point in 3D)
drive_system_radius = 0.3; % Radius of motor/actuator assembly
motor_x_pos = beam_length / 2; % Place the motor at the center of the tracker beam
motor_y_pos = 0; % Centered in Y-axis
motor_z_pos = ground_clearance; % Height of the actuator's pivot point

% Plot the drive system motor as a sphere at the pivot point
[px, py, pz] = sphere(20); % Create a sphere to represent the motor
surf(motor_x_pos + drive_system_radius * px, ...
     motor_y_pos + drive_system_radius * py, ...
     motor_z_pos + drive_system_radius * pz, ...
     'EdgeColor', 'none', 'FaceColor', [0.5 1 0.5]);

% Plot connection bolts or pivot for the tracker beam (3D line)
plot3([motor_x_pos, motor_x_pos], [motor_y_pos, motor_y_pos], ...
      [motor_z_pos, ground_clearance + beam_height * cos(beam_angle_rad)], 'k--', 'LineWidth', 2);

xlim([-5, beam_length + 5]);
ylim([-5, module_width * rows + 5]);
zlim([-2, ground_clearance + beam_height + 2]); % Increase Z-limits to emphasize height
xlabel('Length (meters)', 'FontSize', 12);
ylabel('Width (meters)', 'FontSize', 12);
zlabel('Height (meters)', 'FontSize', 12);
title('3D Model of Single-Axis Solar Tracker', 'FontSize', 14);
grid on;

% Turn off hold for the plot
hold off;
