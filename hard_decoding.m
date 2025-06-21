function [outputArg] = hard_decoding(s, Kc, n, demod_seq, inp_len)

    % Calculating the number of rows and columns in the trellis
    rows = 2^(Kc - 1); 
    cols = inp_len + 1;

    % Initialize 2-D arrays for storing the path metric, previous states and previous inputs
    val_arr = 1000 * ones(rows, cols);
    prev_state = -1 * ones(rows, cols);
    prev_inp = -1 * ones(rows, cols);

    % Setting the branch metric and previous state (path metric) for the initial state
    val_arr(1, 1) = 0;
    prev_state(1, 1) = -1;

    % Iterate over each column of the trellis
    for j = 1:cols - 1 
        x = [];

        % Extracting n bits from the demodulated sequence corresponding to the current column
        for i = n * j - (n - 1):n * j 
            x = [x demod_seq(i)];
        end

        % Iterate over each state of the trellis
        for i = 1:rows

            % Check whether the state has a valid path metric
            if(val_arr(i, j) ~= 1000)

                % Calculation for input bit 0
                op0 = s(i, 1);
                ns0 = s(i, 3) + 1;
                op0_bin = int2bit(op0, n);
                op0_bin = op0_bin';

                % Calculating the Hamming distance for transition 0
                hd0 = 0;
                for k = 1:length(x)
                    if(x(k) ~= op0_bin(k))
                        hd0 = hd0 + 1;
                    end
                end

                % Update values in branch metric if the transition improves the metric
                if(hd0 + val_arr(i, j) < val_arr(ns0, j + 1))
                    val_arr(ns0, j + 1) = hd0 + val_arr(i, j);
                    prev_state(ns0, j + 1) = i;
                    prev_inp(ns0, j + 1) = 0;
                end

                % Calculation for input bit 1
                op1 = s(i, 2);
                ns1 = s(i, 4) + 1;
                op1_bin = int2bit(op1, n);
                op1_bin = op1_bin';

                % Calculating the Hamming distance for transition 1
                hd1 = 0;
                for k = 1:length(x)
                    if(x(k) ~= op1_bin(k))
                        hd1 = hd1 + 1;
                    end
                end

                % Update values if the transition improves the metric
                if(hd1 + val_arr(i, j) < val_arr(ns1, j + 1))
                    val_arr(ns1, j + 1) = hd1 + val_arr(i, j);
                    prev_state(ns1, j + 1) = i;
                    prev_inp(ns1, j + 1) = 1;
                end
            end
        end
    end

    i = 1;
    decoded_seq = [];

    % Backtrack through the trellis to find the most likely sequence
    for j = cols:-1:2
        decoded_seq = [decoded_seq prev_inp(i, j)];
        i = prev_state(i, j);
    end

    % Return the decoded sequence
    outputArg = fliplr(decoded_seq);
end
