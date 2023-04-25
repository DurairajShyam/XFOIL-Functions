%% read xfoil output and take the last alfa to generate an aseq up to stall

function [data]       = readxfoil(file)
fid = fopen(file);


if fid ==-1
    warning('could not find the file named %s',file)
end

for i=1:12
    fgetl(fid);             % we do not need the first lines as they contain the header
end

cntr =1;
while ~feof(fid)
    line                = fgetl(fid);
    data(cntr,:)     = str2num(line);   
    cntr                = cntr +1;
end

data = [data(:,1:3) data(:,5)]; 
    % contains alfa Cl Cd Cm
 i1 = strfind(file,'Re');
 Re = num2str(file(i1+2:end));
 