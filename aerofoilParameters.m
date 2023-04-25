function [Cl_max,Cd_min,alpha0,a] = aerofoilParameters(data)
% This function takes in Nx4 matrix of aerofoil data from xFOIL (N rows of
% angles of attack and 4 columns: alpha, Cl, Cd, Cm) and outputs the
% maximum lift coefficient, minimum drag coefficient, zero-lift angle of
% attack and lift curve slope.

% Define columns as vectors
alpha = data(:,1);
Cl = data(:,2);
Cd = data(:,3);
%Cm = data(:,4);

%% Find Maximum Lift Coefficient
Cl_max = max(Cl);

%% Find Minimum Drag Coefficient
Cd_min = min(Cd);

%% Find zero-lift angle of attack

for i = 1:length(Cl)
    
    % Check if there is a zero-lift coefficient
    if Cl(i) == 0 || Cl(i) == -0
        alpha0 = alpha(i);
    
    % If not, find where it crosses from negative to positive and
    % interpolate to find zero-lift coefficient
    elseif Cl(i) < 0 && Cl(i+1) > 0
        
        % Linear interpolation
        m = (Cl(i+1) - Cl(i))/(alpha(i+1) - alpha(i));
        alpha0 = -(Cl(i)/m) + alpha(i);

    % If not, linearly extrapolate downwards
    elseif min(Cl) > 0

        m = (Cl(2) - Cl(1))/(alpha(2) - alpha(1));
        alpha0 = -(Cl(1)/m) + alpha(1);

    % If not, linearly extrapolate upwards
    elseif max(Cl) < 0

        m = (Cl(end) - Cl(end-1))/(alpha(end) - alpha(end-1));
        alpha0 = -(Cl(end)/m) + alpha(end);
        
    end 
end

%% Find the Lift Curve Slope

% Find linear portion of lift curve
for i = 1:length(Cl)
   
    if Cl(i) == min(Cl)
        negativeBound = i + 25;
    end
    
    if Cl(i) == max(Cl)
        positiveBound = i - 25;
    end
end

% Delete non-linear part of lift and angle of attack arrays
Cl(1:negativeBound)=[];
Cl(positiveBound-negativeBound:end)=[];
alpha(1:negativeBound)=[];
alpha(positiveBound-negativeBound:end)=[];

% Find the average gradient in the linear region
a = mean(gradient(Cl,alpha));

end

