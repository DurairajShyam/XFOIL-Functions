function [xb,yb] = readAerofoil(file)
% This function takes in a .dat file consisting of the coordinates of an aerofoil and outputs an
% array of x and y boundary coordinates

fidAerofoil = fopen(file);
dataBuffer = textscan(fidAerofoil, '%f %f', 'HeaderLines', 1, ...
    'CollectOutput', 1,...
    'Delimiter', '');
fclose(fidAerofoil);

xb = dataBuffer{1,1}(:,1);
yb = dataBuffer{1,1}(:,2);

end