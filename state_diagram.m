function [outputArg] = state_diagram(G, Kc, n)
    % Calculate the number of states based on the constraint length Kc
    no_of_states = 2^(Kc - 1);

    % Initialize an array to hold the binary representation of each state
    arr = zeros(no_of_states, Kc - 1);
    for i = 0:no_of_states - 1
        % Convert the state index to binary representation
        x = int2bit(i, Kc - 1);
        x1 = x';
        arr(i + 1, :) = x1;
    end

    % Initialize the output array to hold the state diagram
    outputArg = zeros(no_of_states, 4);

    % In the first and the second columns, we are storing the output from 
    % the corresponding state when the input bit is 0 and 1, respectively
    % And in third and fourth columns, we are storing the next states,
    % when the input bits are 0 and 1, respectively
    for i = 1:no_of_states
        % Compute the output and next states for input 0
        arr0 = arr(i, :);
        arr0 = [0 arr0]; % Add input 0 to the state
        op0 = mod(G * arr0', 2); % Compute the output
        outputArg(i, 1) = bit2int(op0, n); % Store the output

        next_state0 = [];
        for j = 1:Kc - 1
            next_state0 = [next_state0 arr0(j)]; % Compute the next state
        end
        x = bit2int(next_state0', Kc - 1); % Convert next state to integer
        outputArg(i, 3) = x; % Store the next state for input 0

        % Compute the output and next states for input 1
        arr1 = arr(i, :);
        arr1 = [1 arr1]; % Add input 1 to the state
        op1 = mod(G * arr1', 2); % Compute the output
        outputArg(i, 2) = bit2int(op1, n); % Store the output

        next_state1 = [];
        for j = 1:Kc - 1
            next_state1 = [next_state1 arr1(j)]; % Compute the next state
        end
        outputArg(i, 4) = bit2int(next_state1', Kc - 1); % Store the next state for input 1
    end
end
