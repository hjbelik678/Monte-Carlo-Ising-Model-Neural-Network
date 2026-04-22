%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Monte Carlo Simulation of the Ising Model                              %
% 1D Ising model                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all

%Parameters
L = 10; %Number of rows
H = 10; %number of columns 
J = 1; %Exchange constant. Energy is in units of J
kB = 1; 
T = 1.5; %Temperature is in units of J/kB. kBT is in units of J
MC_sweeps = 100; %Total number of Monte Carlo sweeps

%Initial spin configuration
s = ones(H,L);

%Monte Carlo Simulation
E=zeros(1,MC_sweeps*L); %Energy system as a function of Monte Carlo sweep

MC_step = 0;
for k = 1:MC_sweeps
    %Sweep through 1D spin lattice
    for row_sweep = 1:H
        for column = 1:L
            %sweeps through each row with column number changing
            if column == 1
                E_flip = J * (2 * s(row_sweep,1) * s(row_sweep,L) + 2 * s(row_sweep,1) * s(row_sweep,2));
            elseif column == L
                E_flip = J * (2 * s(row_sweep,L) * s(row_sweep,L - 1) + 2 * s(row_sweep,L) * s(row_sweep,1));
            else
                E_flip = J * (2 * s(row_sweep,column) * s(row_sweep,column-1) + 2 * s(row_sweep,column) * s(row_sweep,column + 1));
            end
        end 
    end
     for column_sweep = 1:L
         for row = 1:H
             %sweeps through each column by changing row
            if row == 1
                E_flip = J * (2*s(1,row) * s(L,row) + 2 * s(1,row) * s(2,row));
            elseif row == L
                E_flip = J * (2 * s(L,row) * s(L,row - 1) + 2 * s(L,row) * s(1,row));
            else
                E_flip = J * (2 * s(column,row) * s(column,row - 1) + 2 * s(column,row) * s(column,row + 1));
            end
         end 
     if E_flip <= 0
             s(column,row) = -s(column,row);
         else
             r = rand;
             if exp(-E_flip/(kB*T)) >= r
                 s(column,row) = -s(column,row);
            end
     end
    MC_step = MC_step + 1;
     end
        %Calculate total energy after each MC step
        for j = 1:L - 1
            for u = 1:H - 1
                E(MC_step) = E(MC_step) - J * s(u,j) * s(u,j + 1);
            end
        end
        %Apply periodic boundary conditions
        E(MC_step) = E(MC_step) - J * s(H,L) * s(H,1) - J * s(H,L) * s(1,L); %Total energy after current sweep
    
end

   

%Plot simulation results
figure
plot((1:MC_step),E,'.')
%axis([1,MC_step,-1.5*L,L])
xlabel('Monte Carlo Time Step')
ylabel('Energy (in units of exchange constant J')

