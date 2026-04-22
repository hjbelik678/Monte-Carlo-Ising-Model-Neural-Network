%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Monte Carlo Simulation of the Ising Model                              %
% 1D Ising model                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all

%Parameters
L = 2; %Number of rows
H = 2; %number of columns 
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
            MC_step = MC_step + 1;
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
             MC_step = MC_step + 1;
            if column == 1
                E_flip = J * (2*s(1,row) * s(L,row) + 2 * s(1,row) * s(2,row));
            elseif column == L
                E_flip = J * (2 * s(L,row) * s(L,row - 1) + 2 * s(L,row) * s(1,row));
            else
                E_flip = J * (2 * s(column,row) * s(column,row - 1) + 2 * s(column,row) * s(column,row + 1));
            end
         end 
     if E_flip <= 0
             s(row) = -s(row);
         else
             r = rand;
             if exp(-E_flip/(kB*T)) >= r
                 s(row) = -s(row);
            end
        end
     end
        %Calculate total energy after each MC step
        for j = 1:L-1
            E(MC_step) = E(MC_step) - J*s(j)*s(j+1);
        end
        %Apply periodic boundary conditions
        E(MC_step) = E(MC_step) - J*s(L)*s(1); %Total energy after current sweep
    end
end

%Plot simulation results
figure
plot((1:MC_step),E,'.')
%axis([1,MC_step,-1.5*L,L])
xlabel('Monte Carlo Time Step')
ylabel('Energy (in units of exchange constant J')

