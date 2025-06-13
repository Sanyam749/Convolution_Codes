% Simulation parameters
rate = 1/2;
Kc = 3;

% Function to create random binary message
function ip = create_msg(input_bits_length)
    ip = zeros(1, input_bits_length);
    for i = 1:input_bits_length
        ip(i) = randn > 0.5;
    end
end

% Eb/N0 range in dB
EbN0_dB_values = 0:0.5:10;
[~, col_EbNo] = size(EbN0_dB_values);

% Number of simulations per Eb/N0 value
Nsim = 10000;

% Initialize arrays to store error rates
PDE1_hard = zeros(1, col_EbNo);  % Packet Detection Error for hard decoding
PDE1_soft = zeros(1, col_EbNo);  % Packet Detection Error for soft decoding

% Loop over each Eb/N0 value
for idx = 1:length(EbN0_dB_values)
    error_cnt_hard_pde = 0;
    error_cnt_soft_pde = 0;

    for i = 1:Nsim
        % Generate random input message
        ip = create_msg(100);

        % Encode using convolutional encoder
        [en_msg, G] = convolutional_encode(rate, Kc, ip);

        % Transmit through BPSK over AWGN channel
        [rec_msg, ~] = bpsk_awgn_channel(en_msg, EbN0_dB_values(idx), rate);

        % Decode using hard and soft Viterbi algorithms
        dec_msg_hard = viterbi_hard(G, rec_msg);
        dec_msg_soft = viterbi_soft(G, rec_msg);

        % Count errors for packet error detection
        error_cnt_hard_pde = error_cnt_hard_pde + (sum(dec_msg_hard(1:length(ip)) ~= ip) > 0);
        error_cnt_soft_pde = error_cnt_soft_pde + (sum(dec_msg_soft(1:length(ip)) ~= ip) > 0);
    end

    % Compute average error rate for current Eb/N0
    PDE1_hard(1, idx) = error_cnt_hard_pde / Nsim;
    PDE1_soft(1, idx) = error_cnt_soft_pde / Nsim;
end

% Plotting results
figure(1);
semilogy(EbN0_dB_values, PDE1_hard, 'x-.', EbN0_dB_values, PDE1_soft, 'x-.');
xlabel('Eb/N0 (dB)');
ylabel('Packet Error Rate (PDE)');
grid on;
legend('PDE Hard', 'PDE Soft');
title('Error Rates vs. SNR for rate = 1/2, K = 3');
