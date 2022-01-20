% ********************** ****************
% For Deliverable 1
% Student Name: Chintan Jayeshkumar Kharadi
% Subject: Simulation and Modeling SYSC5001
% Student ID Number: 101169771
% Date: 05-02-2020
% This file is written to send component C1 to buffer c1w2/c1w1/c1w3 % ********************** ***************
%*****************************************
function [output1,output2,output3,tc1,idle,c1count] = inspector1(bufferc1w1,bufferc1w2,bufferc1w3,component1,time_c1,idle_insp1,c1_count)

output1=bufferc1w1;
output2=bufferc1w2;
output3=bufferc1w3;
idle=idle_insp1;
tc1=time_c1;
c1count=c1_count;

if ((bufferc1w1 < 2) || (bufferc1w2 < 2) || (bufferc1w3 < 2))
    if (bufferc1w1 < 2 && (bufferc1w1<=bufferc1w2 || bufferc1w1<=bufferc1w3))
        bufferc1w1 = bufferc1w1 + 1;
        output1=bufferc1w1;
    elseif (bufferc1w2 < 2  || bufferc1w2<=bufferc1w3)
        bufferc1w2 = bufferc1w2 + 1;
        output2=bufferc1w2;
    else
        bufferc1w3 = bufferc1w3 + 1;
        output3=bufferc1w3;
    end
    c1_count = c1_count + 1;
    c1count=c1_count;
    time_c1 = component1(c1_count);
    tc1=time_c1;
else
    idle_insp1 = idle_insp1 + 1;
    idle=idle_insp1;
end

end