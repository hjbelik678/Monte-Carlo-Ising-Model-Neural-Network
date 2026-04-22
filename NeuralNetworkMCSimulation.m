%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neural Network Memory Model Monte Carlo Simulation              %
%Memory Storage and Memory Retrieval                             %
%Henry Belik                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%Simulation parameter
MC_steps=1; %One MC Step = one complete sweep through the spin system

%Stored pattern: perfect A
s_stored=-1*ones(10,10);
s_stored(1,5:6)=1;
s_stored(2,4:7)=1;
s_stored(3,3:4)=1;
s_stored(3,7:8)=1;
s_stored(4,2:3)=1;
s_stored(4,8:9)=1;
s_stored(5,2:9)=1;
s_stored(6,:)=1;
s_stored(7,1:3)=1;
s_stored(7,8:10)=1;
s_stored(8,1:2)=1;
s_stored(8,9:10)=1;
s_stored(9,1:2)=1;
s_stored(9,9:10)=1;
s_stored(10,1:2)=1;
s_stored(10,9:10)=1;

% %Initial pattern: imperfect A (Fig. 12.25)
% s_i=s_stored;
% s_i(2,10)=1;
% s_i(3,3)=-1;
% s_i(5,3)=-1;
% s_i(6,4)=-1;
% s_i(6,7)=-1;
% s_i(7,2)=-1;
% s_i(8,9)=-1;
% s_i(9,2)=-1;
% s_i(9, 4)=1;

%Initial pattern: imperfect A (Fig. 12.26)
s_i=s_stored;
s_i(1,5)=-1;
s_i(2,5:6)=-1;
s_i(3,3)=-1;
s_i(3,8)=-1;
s_i(4,2)=-1;
s_i(4,8)=-1;
s_i(5,3:8)=-1;
s_i(6,1)=-1;
s_i(6,3:8)=-1;
s_i(6,10)=-1;
s_i(7,3)=-1;
s_i(7,8)=-1;
s_i(8,2)=-1;
s_i(8,9)=-1;
s_i(9,2)=-1;
s_i(9,4)=-1;

%Assign each spin in the stored and initial patterns a spin number
ss_stored=zeros(1,100); %Define a 1 by 100 array for the stored pattern
ss=zeros(1,100); %Define a 1 by 100 array for the initial pattern
for m=1:10
    for n=1:10
        i=10*(m-1)+n; %spin number assigned to spin at row m and column n
        ss_stored(i)=s_stored(m,n);
        ss(i)=s_i(m,n);
    end
end

%Calculate interaction energies J between all paris of spins i and j and
%the total energy of the initial spin system
J=zeros(100,100); %Define a 100 by 100 array for the interaction energies
E_0=0; %Initial total energy
for i=1:99
    for j=i+1:100
        J(i,j)=ss_stored(i)*ss_stored(j);
        J(j,i)=J(i,j); %Assume symmetric interaction energies
        E_0=E_0-J(i,j)*ss(i)*ss(j);
    end
end

%Apply Monte Carlo Simulation to determine the spin directions at later
%times
E=zeros(1,MC_steps); %Total energy after each Monte Carlo step
E_old=E_0;
for k=1:MC_steps
    E(k)=E_old;
    for i=1:100
        E_flip=0;
        for j=1:100
            E_flip=E_flip+2*J(i,j)*ss(i)*ss(j);
        end
        if E_flip<0
            ss(i)=-ss(i);
            E(k)=E(k)+E_flip;
        end
    end
    E_old=E(k);
end

%Convert the 1 by 100 arrary back to 2D spin array
s_f=ones(10,10);
for i=1:100
    for m=1:10
        s_f(m,1:10)=ss(1+(m-1)*10:m*10);
    end
end

%Dispaly the initial pattern and the final pattern after MC_steps
pA_i=char(s_i);
for m=1:10
    for n=1:10
        if pA_i(m,n)==1
            pA_i(m,n)='+';
        end
        if pA_i(m,n)==-1
            pA_i(m,n)=' ';
        end
    end
end
disp(pA_i)

pA_f=char(s_f);
for m=1:10
    for n=1:10
        if pA_f(m,n)==1
            pA_f(m,n)='+';
        end
        if pA_f(m,n)==-1
            pA_f(m,n)=' ';
        end
    end
end
disp(pA_f)

%Plot total energy vs. Monte Carlo steps
figure
plot([0:MC_steps],[E_0,E])
xlabel('Time (Monte Carlo Steps')
ylabel('Energy')
title('Energy versus Monte Carlo Steps')
