function [outputArg] = encoding(G, Kc, input_seq)

    encoded_msg = [];

    % Initialize the shift register with the first element of the input sequence
    arr = [input_seq(1)]; 

    % Pad the shift register array with Kc-1 zeros
    for i = 1:Kc - 1
        arr = [arr 0];
    end

    % Obtaining the encoded sequence for each input bit by multiplying 
    % shift register array with G matrix
    for i = 1:length(input_seq)
        arr1 = arr';
        arr2 = G * arr1; 
        arr2 = mod(arr2, 2); 
        encoded_msg = [encoded_msg arr2'];

        % Shift the shift register to the right by one position
        for j = Kc:-1:2
            arr(j) = arr(j - 1);
        end

        % Update the first element of the shift register with the next input
        if(i ~= length(input_seq))
            arr(1) = input_seq(i + 1);
        end
    end

    outputArg = encoded_msg;
end
