%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Monte Carlo Simulation of the Ising Model                              %
% 1D Ising model                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all

%Parameters
row_number = 10; %Number of rows
column_number = 10; %number of columns 
J = 1000; %Exchange constant. Energy is in units of J
kB = 1; 
T = 0; %Temperature is in units of J/kB. kBT is in units of J
MC_sweeps = 100; %Total number of Monte Carlo sweeps
row_a_1 = [-1,-1,-1,-1,1,1,-1,-1,-1,-1];
row_a_2 = [-1,-1,-1,1,1,1,1,-1,-1,-1];
row_a_3 = [-1,-1,1,1,-1,-1,1,1,-1,-1];
row_a_4 = [-1,1,1,-1,-1,-1,-1,1,1,-1];
row_a_5 = [-1,1,1,1,1,1,1,1,1,-1];
row_a_6 = [1,1,1,1,1,1,1,1,1,1];
row_a_7 = [1,1,1,-1,-1,-1,-1,1,1,1];
row_a_8 = [1,1,-1,-1,-1,-1,-1,-1,1,1];
row_a_9 = [1,1,-1,-1,-1,-1,-1,-1,1,1];
row_a_10 = [1,1,-1,-1,-1,-1,-1,-1,1,1];

row_1 = [1,1,-1,-1,1,-1,-1,-1,1,1];
row_2 = [-1,1,-1,1,1,1,1,-1,1,-1];
row_3 = [-1,-1,1,1,-1,-1,1,1,-1,-1];
row_4 = [-1,1,1,-1,-1,1,-1,1,1,-1];
row_5 = [-1,1,1,-1,1,1,1,1,1,-1];
row_6 = [1,1,1,1,1,1,1,-1,1,1];
row_7 = [1,-1,1,-1,1,-1,-1,1,1,1];
row_8 = [1,1,-1,-1,-1,1,1,-1,1,1];
row_9 = [1,1,-1,1,-1,-1,-1,-1,-1,1];
row_10 = [1,1,-1,-1,-1,-1,1,-1,1,1];

%Initial spin configuration
%s = ones(column_number,row_number);

%Monte Carlo Simulation
E=zeros(1,MC_sweeps*row_number); %Energy system as a function of Monte Carlo sweep

%base letter configuration without changes to its structure
base_letter = [row_1; row_2; row_3; row_4; row_5; row_6; row_7; row_8; row_9; row_10;];

%calculates base iteraction energy

E_original_base = 0;
for i = 1:column_number * row_number - 1
        %total interaction energy or the spin configuration
        for j = i + 1:column_number * row_number
                E_original_base = E_original_base - (J) * base_letter(i) * base_letter(j);
            if i == 1
                latice_energy = E_original_base;
            else
                if E_original_base < latice_energy
                    latice_energy = E_original_base;
                end    
            end
            %returns configuration to how it was before this loop
        base_letter(i) = base_letter(i) * -1;
        end
end
J = E_original_base;
   
%reassign initialized values
s = [row_a_1; row_a_2; row_a_3; row_a_4; row_a_5; row_a_6; row_a_7; row_a_8; row_a_9; row_a_10;];

MC_step = 0;
for k = 1:MC_sweeps
    %assigns number indexes describing initial matrix of spins
    count = 0;
    ss = 1:column_number * row_number;
    for y = 1:row_number
        % through every row
        for x = 1:column_number
            % throught every column
            count = count + 1;
            ss(count) = s(column_number,row_number);
        end
    end
        E_original = 0;
    for i = 1:column_number * row_number - 1
        %total interaction energy or the spin configuration
        for j = i + 1:column_number * row_number
                E_original = E_original - (J) * ss(i) * ss(j);
            if i == 1
                latice_energy = E_original;
                lowest_energy_index = i;
            else
                if E_original < latice_energy
                    latice_energy = E_original;
                    lowest_energy_index = i;
                end    
            end
            %returns configuration to how it was before this loop
        ss(i) = ss(i) * -1;
        end
    end
    %changing the index that makes the matrix have the lowest energy
    ss(lowest_energy_index) = ss(lowest_energy_index) * -1;
end

final_configuration = reshape(ss, row_number, column_number);
% disp(final_configuration)

% final_configuration = ss;

%convert the matrix to a cell array of characters
%final_configuration(final_configuration == -1) = 10;
disp(final_configuration)
convertedmatrix = char(final_configuration);

% for q = 1:numel(convertedmatrix)
%     disp(convertedmatrix(i));
% end

for q = 1:numel(convertedmatrix)
    if strcmp(convertedmatrix(i) , '-1')
        convertedmatrix(i) = ' ';
    end
    if strcmp(convertedmatrix(i), '1')
        convertedmatrix(i) = '+';
    end
end

disp(convertedmatrix)
% % conver matix 1's to +'s and -1's to spaces
% convertedmatrix(convertedmatrix == '1') = '+';
% convertedmatrix(convertedmatrix == '-1') = ' ';



%disp(convertedmatrix)
%     %Sweep through 2D spin lattice
%     for row_sweep = 1:column_number
%         for column = 1:row_number
%             %sweeps through each row with column number changing
%             if column == 1
%                 E_flip = J * (2 * s(row_sweep,1) * s(row_sweep,row_number) + 2 * s(row_sweep,1) * s(row_sweep,2));
%             elseif column == row_number
%                 E_flip = J * (2 * s(row_sweep,row_number) * s(row_sweep,row_number - 1) + 2 * s(row_sweep,row_number) * s(row_sweep,1));
%             else
%                 E_flip = J * (2 * s(row_sweep,column) * s(row_sweep,column-1) + 2 * s(row_sweep,column) * s(row_sweep,column + 1));
%             end
%         end 
%     end
%      for column_sweep = 1:row_number
%          for row = 1:column_number
%              %sweeps through each column by changing row
%             if row == 1
%                 E_flip = J * (2*s(1,row) * s(row_number,row) + 2 * s(1,row) * s(2,row));
%             elseif row == row_number
%                 E_flip = J * (2 * s(row_number,row) * s(row_number,row - 1) + 2 * s(row_number,row) * s(1,row));
%             else
%                 E_flip = J * (2 * s(column,row) * s(column,row - 1) + 2 * s(column,row) * s(column,row + 1));
%             end
%          end 
%      if E_flip <= 0
%              s(column,row) = -s(column,row);
%          else
%              r = rand;
%              if exp(-E_flip/(kB*T)) >= r
%                  s(column,row) = -s(column,row);
%             end
%      end
%     MC_step = MC_step + 1;
%      end
%         %Calculate total energy after each MC step
%         for j = 1:row_number - 1
%             for u = 1:column_number - 1
%                 E(MC_step) = E(MC_step) - J * s(u,j) * s(u,j + 1);
%             end
%         end
%         %Apply periodic boundary conditions
%         E(MC_step) = E(MC_step) - J * s(column_number,row_number) * s(column_number,1) - J * s(column_number,row_number) * s(1,row_number); 
%         %Total energy after current sweep of nearset neighbor interactions
    
% end
% disp(s);
% 
% 
% 
% %Plot simulation results
% figure
% plot((1:MC_step),E,'.')
% %axis([1,MC_step,-1.5*L,L])
% xlabel('Monte Carlo Time Step')
% ylabel('Energy (in units of exchange constant J')

