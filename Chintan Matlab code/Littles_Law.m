% ********************** ****************
% For Deliverable 3
% Student Name: Chintan Jayeshkumar Kharadi
% Subject: Simulation and Modeling SYSC5001
% Student ID Number: 101169771
% Date: 06-04-2020
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




%% Display All necessary outputs:
inspector1_time = sprintf('Inspection time of Inspector 1 = %d ',insp1_time);
disp(inspector1_time);
idletime_i1 = sprintf('Idle time of Inspector 1 = %d \n',insp1_idle);
disp(idletime_i1);

blocked_time=insp1_idle/t;
block_time_i1=sprintf('Probability of Inspector 1 sitting Idle over span of Total Simulation time= %d \n',blocked_time);
disp(block_time_i1);

Inspector2_time = sprintf('Inspection time of Inspector 2 = %d ',insp2_time-1);
disp(Inspector2_time);

idletime_i2 = sprintf('Idle time of Inspector 2 = %d \n',insp2_idle);
disp(idletime_i2);

block_time_i2=sprintf('Probability of Inspector 2 sitting Idle over span of Total Simulation time=%d \n',insp2_idle/t);
disp(block_time_i2);

product1_counter = sprintf('Products from Workstation 1 = %d ',product1_count-1);
disp(product1_counter);
workstation1_time = sprintf('Service time of Workstation 1 = %d ',work1_time-1);
disp(workstation1_time);
idletime_w3 = sprintf('Idle time of Workstation 1 = %d \n',work1_idle);
disp(idletime_w3);
p1 = sprintf('Throughput from Workstation 1 = %d \nProducts = %d',(product1_count - 1)/t,product1_count-1);
disp(p1);
b_work1 = work1_idle/t;
b3 = sprintf('Blocking Probability of Workstation 1 = %d \n',b_work1);
disp(b3);


product2_counter = sprintf('Products from Workstation 2 = %d ',product2_count );
disp(product2_counter);
workstation2_time = sprintf('Service time of Workstation 2 = %d ',work2_time);
disp(workstation2_time);
idletime_w2 = sprintf('Idle time of Workstation 2 = %d \n',work2_idle-1);
disp(idletime_w2);
b_work2 = work2_idle/t;
b4 = sprintf('Blocking Probability of Workstation 2 = %d \n',b_work2);
disp(b4);
p2 = sprintf('Throughput from Workstation 2 = %d \nProducts = %d',(product2_count - 1)/t,product2_count-1);
disp(p2);

product3_counter = sprintf('Products from Workstation 3 = %d ',product3_count - 1);
disp(product3_counter);
workstation3_time = sprintf('Service time of Workstation 3 = %d ',work3_time);
disp(workstation3_time);
idletime_w3 = sprintf('Idle time of Workstation 3 = %d \n',work3_idle-1);
disp(idletime_w3);
p3 = sprintf('Throughput from Workstation 3 = %d \nProducts = %d',(product3_count - 1)/t,product3_count-1);
disp(p3);
b_work3 = work3_idle/t;
b5 = sprintf('Blocking Probability of Workstation 3 = %d \n',b_work3);
disp(b5);

totalsimulationtime = sprintf('Run time of Simulation = %d ',t);
disp(totalsimulationtime);



% %% Little's Law
w_insp1 = (insp1_time)/(component1_count - 1);
y_insp1 = (component1_count - 1)/t; %Arrival rate = Departure rate
l_insp1 = w_insp1*y_insp1;%(insp1_time)/t;
l_insp2 = insp2_time/t;


l_work1 = (work1_time)/t;

l_work2 = (work2_time)/t;
l_work3 = (work3_time )/t;



%For Black Box : Litttle's Law
%Here we have component 1,2,3 as an input and output is Product1,
%Product2 and Product3. Main Parameter is total simulation time and based
%on that I calculated Average number of products from system
Total_component_in_system=component1+component2+component3;
%T is large enough to follow little's formula.
L_product1=product1_count/Total_component_in_system;
L_product2=product2_count/Total_component_in_system;
L_product3=product3_count/Total_component_in_system;
L_total= (L_product1+L_product2+L_product3)*(Total_component_in_system)/t;

total_1 = sprintf('\nAverage Number of products for the black box system (L_Total) = %d',L_total);
disp(total_1);

l1 = sprintf('\nAverage Number of Items  for:\nInspector 1 = %d\nInspector 2 = %d\nWorkstation 1 = %d\nWorkstation 2 = %d\nWorkstation 3 = %d',l_insp1,l_insp2,l_work1,l_work2,l_work3);
disp(l1);