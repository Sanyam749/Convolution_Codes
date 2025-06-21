EbNodB = 0:0.5:10; % SNR values in dB
gamma = 10.^(EbNodB / 10); % Convert SNR from dB to linear scale
ES = 1; % Signal energy
nsim = 10000;
input_length = 50;
input = rand(1, input_length) > 0.5;

% Parameters (select as desired)
k = 1;
n = 2; % or 3
r = k / n;
Kc = 3; % or 4 or 6

% Generator matrix selection based on (k, n, Kc)
switch true
    case (k == 1 && n == 2 && Kc == 3 && r == 1/2)
        G = [[1 0 1]; [1 1 1]];

    case (k == 1 && n == 3 && Kc == 4 && r == 1/3)
        G = [[1 0 1 1]; [1 1 0 1]; [1 1 1 1]];

    case (k == 1 && n == 3 && Kc == 6 && r == 1/3)
        G = [[1 0 0 1 1 1]; [1,0,1,0,1,1]; [1,1,1,1,0,1]];

    otherwise
        error('No matching configuration for given k, n, Kc, r');
end

input_seq = input;
for i = 1:Kc - 1
    input_seq = [input_seq 0]; % Padding zeros
end

% Obtaining state diagram
s = state_diagram(G, Kc, n);

% Obtaining encoded sequence
encoded_seq = encoding(G, Kc, input_seq);

% BPSK modulation
modulated_signal = 1 - 2 * encoded_seq;

% For storing BER
error_rates_hard_1 = zeros(1, length(EbNodB));
error_rates_soft_1 = zeros(1, length(EbNodB));
theoratical_error_1 = zeros(1, length(EbNodB));
num_errors_hard = zeros(size(EbNodB));
num_errors_soft = zeros(size(EbNodB));

% Simulating errors for all values of EbNodB
for i = 1:length(EbNodB)
    % Generating noise
    noise_power = sqrt(1 / (r * gamma(i)));
    BER_th = 0.5 * erfc(sqrt(1 * gamma(i)));
    theoratical_error_1(i) = BER_th;

    for j = 1:nsim
        % SNR and noise simulation
        noise = noise_power * randn(size(modulated_signal)); % AWGN noise

        % Add noise to modulated signal
        received_signal = modulated_signal + noise;

        % For BPSK demodulation
        threshold = 0;

        % Calculating Demodulated signal
        demodulated_signal = zeros(size(received_signal));
        for k = 1:length(received_signal)
            if(received_signal(k) < threshold)
                demodulated_signal(k) = 1;
            end
        end

        % Hard Decoding
        decoded_seq_hard = hard_decoding(s, Kc, n, demodulated_signal, length(input_seq));

        % Soft Decoding
        decoded_seq_soft = soft_decoding(s, Kc, n, received_signal, length(input_seq));

        % Computing the number of error bits in the decoded sequence
        for k = 1:length(input_seq)
            if(decoded_seq_hard(k) ~= input_seq(k))
                num_errors_hard(i) = num_errors_hard(i) + 1;
            end
            if(decoded_seq_soft(k) ~= input_seq(k))
                num_errors_soft(i) = num_errors_soft(i) + 1;
            end
        end
    end
end

% Computing BER
error_rates_hard_1 = num_errors_hard / (nsim * length(input_seq));
error_rates_soft_1 = num_errors_soft / (nsim * length(input_seq));

% Plot error rates vs. Eb/N0
semilogy(EbNodB, error_rates_hard_1);
hold on;
semilogy(EbNodB, theoratical_error_1);
semilogy(EbNodB, error_rates_soft_1);
hold off;

xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate');
title('Bit Error Rate vs. Eb/N0 for Convolutional Coding with Viterbi Decoding');
legend('hard K=3 r=1/2', 'theoretical error', 'soft K=3 r=1/2');
grid on;

% This code will take time to run as Monte-Carlo simulation is done for Nsim = 10000 and input length = 50
% To speed up things reduce Nsim to 100 and input length = 20