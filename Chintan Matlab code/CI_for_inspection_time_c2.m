% ********************** ****************
% For Deliverable 3
% Student Name: Chintan Jayeshkumar Kharadi
% Subject: Simulation and Modeling SYSC5001
% Student ID Number: 101169771
% Date: 05-02-2020
% This file is written to Simulate the model and get the throughput.  ********************** ***************
%*****************************************

clc;
clear all;
close all;

%Load all  data files
component1 = load('servinsp1.dat');
component2 = load('servinsp22.dat');
component3 = load('servinsp23.dat');
workstation1 = load('ws1.dat');
workstation2 = load('ws2.dat');
workstation3 = load('ws3.dat');


%% 15 Replications
for n=1:15
%% Random Number Generation using Normal distribution


choose_value=randn(300,1);
c2=zeros(300,1);
 for i=1:1:300
     c2(1,i)=abs(component2(i,1)*choose_value(i,1));
 end


%%  Normal Distribution Generation based upon random numbers
m1 = mean(component2); %mean of the Random Inspection time (i.e. data)
Min1 = min(component2);
Max1 = max(component2);
n1= m1/(Max1-Min1);
x = 0:.00001:.99999;
z1=normcdf(x);


%Load inspection and service times
time_component1 = 0;
time_component2 = 0;
time_componen3 = 0;
time_workstation1 = 0;
time_workstation2 = 0;
time_workstation3 = 0;

%To check components count in buffers
bufferc1w1 = 0;
bufferc1w2 = 0;
bufferc1w3 = 0;
bufferc2w2 = 0;
bufferc3w3 = 0;



t = -1; %Total simulation time

%Variables of inspection and workstation times
insp1_time = 0;
insp2_time = 0;
work1_time = 0;
work2_time = 0;
work3_time = 0;
insp1_idle = 0;
insp2_idle = 0;
work1_idle = 0;
work2_idle = 0;
work3_idle = 0;


%Component and product count
component1_count = 1;
component2_count = 1;
component3_count = 1;
product1_count = 1;
product2_count = 1;
product3_count = 1;

%Logic to randomize C2 and C3 for inspector 2
x=[2,3];
n=1;
m=300;
C2orC3=zeros(300,1);
%%%%% if x=2 then I will select component2 in or else I will select
%%%%% component 3.
timer=1;
for timer= 1:300
    C2orC3(timer,1)=C2orC3(timer,1)+randi(x);
    timer=timer+1;
end

counter=1;
Loop_limit=size(component1,1);


% This while loop will be iterated 300 times(component size of c1)and will
% generate the inpsection or idle time and products and component count

while (component1_count < Loop_limit) 
    if(time_component1<0)
        %Calling Inspector1 function to calculate inspection time and
        %assign components to respective buffer
        [bufferc1w1,bufferc1w2,bufferc1w3,time_component1,insp1_idle,component1_count]=inspector1(bufferc1w1,bufferc1w2,bufferc1w3,component1,time_component1,insp1_idle,component1_count);
        insp1_time=insp1_time +1.00;
    elseif (time_component1 > 0)
        time_component1 = time_component1 - 1.00005999;
        insp1_time = insp1_time + 1.0000; 
    else
        time_component1= component1(component1_count);
        component1_count=component1_count+1;
        
        
    end
    % Workstation 1 logic and counting number of products created
    if(time_workstation1>0)
        time_workstation1 = time_workstation1 - 1;
        work1_time = work1_time + 1;
    else
        if(bufferc1w1~=0)
            bufferc1w1=bufferc1w1-1;
            work1_time = work1_time + 1;
            time_workstation1=workstation1(product1_count);
            if(product1_count<300)
                product1_count=product1_count+1;
            end
        else
            work1_idle = work1_idle + 1; %Idle Time for Workstation 1
        end
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%Code for component 2
    if(C2orC3(counter)==2)
        
        
        if(time_component2<0)
            %Calling inspector2 to assign component 2 to buffer b2c2.
            [bufferc2w2,bufferc3w3,time_component2,time_componen3,insp2_idle,component2_count,component3_count]=inspector2(bufferc2w2,bufferc3w3,component2,component3,time_component2,time_componen3,insp2_idle,component2_count,component3_count);
            
                      if(counter<300)
                           counter=counter+1;
                        end
        elseif (time_component2 > 0)
            time_component2 = time_component2 - 1.00005999;
            insp2_time = insp2_time + 1.0000; %Inspection Time for Inspector 1
        else
            time_component2= component2(component2_count);
            component2_count=component2_count+1;
            
            
        end
    else
        %%%%%%%%Code for component 3
        if(time_componen3<0)
             %Calling inspector2 to assign component 3 to buffer b3c3.
            [bufferc2w2,bufferc3w3,time_component2,time_componen3,insp2_idle,component2_count,component3_count]=inspector2(bufferc2w2,bufferc3w3,component2,component3,time_component2,time_componen3,insp2_idle,component2_count,component3_count);
           % time_insp2=time_insp2 +1.00;
            if(counter<300)
                counter=counter+1;
            end
        elseif (time_componen3 > 0)
            time_componen3 = time_componen3 - 1.00005999;
            insp2_time = insp2_time + 1.0000; %Inspection Time for Inspector 1
        else
            time_componen3= component3(component3_count);
            component3_count=component3_count+1;
            
            
        end
    end
    
    
    %%%%%%%%%%Workstation 2%%%%%%%
    if(time_workstation2>0)
        time_workstation2 = time_workstation2 - 1;
        work2_time = work2_time + 1;
    else
        if(bufferc2w2~=0 && bufferc1w2~=0)
            bufferc2w2=bufferc2w2-1;
            bufferc1w2=bufferc1w2-1;
            work2_time = work2_time + 1;
            
            time_workstation2=workstation2(product2_count);
            if(product2_count<300)
                product2_count=product2_count+1;
            end
        else
            work2_idle = work2_idle + 1; 
        end
    end
    
    %%%%%%%%%%Workstation 3%%%%%%%
    if(time_workstation3>0)
        time_workstation3 = time_workstation3 - 1;
        work3_time = work3_time + 1;
    else
        if(bufferc1w3~=0 && bufferc3w3~=0)
            bufferc1w3=bufferc1w3-1;
            bufferc3w3=bufferc3w3-1;
            work3_time = work3_time + 1;
            
            time_workstation3=workstation3(product3_count);
            if(product3_count<300)
                product3_count=product3_count+1;
            end
        else
            work3_idle = work3_idle + 1; %Idle Time for Workstation 3
        end
    end
    
    t = t + 1;
end




%% Variables for T Distribution 
time_avg(n) = insp2_time / (component2_count-1);


end




%% CI
pd_use = fitdist(component2,'Normal');
ci_Testing = paramci(pd_use,'Alpha',.07);

mean_avg = mean(time_avg);
std_avg = std(time_avg);
mean_upper=ci_Testing(1,1);
mean_lower=ci_Testing(1,2);
sigma_upper=ci_Testing(2,1);
sigma_lower=ci_Testing(2,2);

CI1 = mean_avg + (2.23*(std_avg/sqrt(n)));
CI2 = mean_avg - (2.23*(std_avg/sqrt(n)));
ci = sprintf('CI (95 percentage)for 15 replications :\t[%d,%d]',mean_lower,mean_upper);
disp(ci);
best_case = abs(m1 - mean_upper);
worst_case = abs(m1 - mean_lower);
bw = sprintf('Best Case Scenario for these replications = %d\nWorst Case Scenario for these replications= %d',best_case,worst_case);
disp(bw);
