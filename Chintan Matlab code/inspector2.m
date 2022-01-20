% ********************** ****************
% For Deliverable 1
% Student Name: Chintan Jayeshkumar Kharadi
% Subject: Simulation and Modeling SYSC5001
% Student ID Number: 101169771
% Date: 05-02-2020
% This file is written to find mean and variance of each component's inspection time and each workstation's processing time % ********************** ***************
%*****************************************
function [output1,output2,tc2,tc3,idle,c2count,c3count] = inspector2(bufferc2w2,bufferc3w3,component2,component3,time_c2,time_c3,idle_insp2,c2_count,c3_count)
output1=bufferc2w2;
output2=bufferc3w3;
idle=idle_insp2;
tc2=time_c2;
tc3=time_c3;
c2count=c2_count;
c3count=c3_count;
if ((bufferc2w2 < 2) || (bufferc3w3 < 2) )
    if (bufferc2w2 < 2)
        bufferc2w2 = bufferc2w2 + 1;
        output1=bufferc2w2;
        if(c2_count<300)
            c2_count = c2_count + 1;
        end
        c2count=c2_count;
        time_c2 = component2(c2_count);
        tc2=time_c2;
    else
        bufferc3w3 = bufferc3w3 + 1;
        output2=bufferc3w3;
        if(c3_count<300)
            c3_count = c3_count + 1;
        end
        c3count=c3_count;
        time_c3 = component3(c3_count);
        tc3=time_c3;
    end
else
    idle_insp2 = idle_insp2 + 1;
    idle=idle_insp2;
end

end