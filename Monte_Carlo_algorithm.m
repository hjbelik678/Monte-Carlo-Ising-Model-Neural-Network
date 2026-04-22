%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Monte Carlo algorithml                              %
% Henry Belik                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global flip_energy;
flip_energy = 0;
global list_value_best;
list_value_best = 0;
global saved_list_item;
saved_list_item = 0;

L=10;
s=-1*ones(1,L);

original_configuration = (1:L);
% at the end of each sweep of the Monte Carlo Simulation, this is what the
% sweep determines as the best configuration at the time

changing_configuration = (1:L);
% this list gets changed within the possiilities loop

Temperature = 293; %K
Boltzman_constant = 1.380649 * 10 ^ -23; %J/K
J = 1; %but reall 2.3 Exchange Constant for 2D Ising model

%Calculate interaction energy involving interior spins only

for n=1:15

    for list_item = 1:L
        %purpose is to go through the possibility of flipping each
        %componenet's spin and calculating the energy associated with that
        %specific arrangement
        total_energy_previous = 0;
        E_interior=0;
        changing_configuration(list_item) = original_configuration(list_item) * -1;

        for changing_configuration = 2:L
            %calculates the energy of a specific configuration
            E_interior = E_interior + s(changing_configuration) * s(changing_configuration-1);
        end
        total_energy = E_interior + s(1) * s(L);

        if total_energy <= total_energy_previous
            % if total energy is less than the previous lowest energy,
            % reassign it as the best energy configuration
            total_energy = total_energy_previous;
            saved_list_item = list_item;
        end

        if list_item == L
            %on the last time through the loop, assign the lowest calcuated
            %energy state as the best energy of that sweep
            flip_energy = total_energy;
            list_value_best = saved_list_item;
        end
    end

    if flip_energy <= 0
        %flips list item that would give lowest calculated energy
        original_configuration(list_item) = original_configuration(list_value_best) * -1;
    else
        r = rand(0,1);
        %generates random number [0,1]
        if r <= exp(-flip_energy / (Boltzman_constant * Temperature))
            original_configuration(list_item) = original_configuration(list_value_best) * -1;
        end
    end
    disp(flip_energy)
    disp(list_value_best)
end







% for n = s
%     E(calculated)= 0;
%     for s(i)
%         if s(i = 2:L)
%             E(calculated) += s(i) * s(i-1)
%         else 
%             E(calculated) += s(L) * s(1)
%         end
%     end
%     E(flip) = E(calculated) * -J;
%     if E(flip) <= 0
%         s(n) *= -1
%     else
%         r = rand(0,1);
%         if r >= - E(flip)/(Boltamen(constant) * Temperature)
%             s(n) *= -1
%         else
%             pass
%         end
%     end
% end;
% disp s(i)
%    
%        
