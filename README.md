# 📡 Convolutional Codes

This project demonstrates the complete simulation chain of a digital communication system using **convolutional codes**, including encoding, modulation, channel noise, and decoding techniques. Implemented entirely in MATLAB, it includes both **hard** and **soft decision Viterbi decoding** and a **Monte Carlo simulation** to evaluate performance under noisy conditions.

## 📁 Components Implemented

- ✅ **Source Encoder**: Generates binary data stream to be transmitted.
- ✅ **Convolutional Encoder**: Encodes data using rate 1/2 convolutional code with configurable constraint length.
- ✅ **BPSK Modulator**: Maps binary bits to BPSK symbols (+1, -1).
- ✅ **AWGN Channel Simulation**: Adds Gaussian noise to simulate real-world channel conditions.
- ✅ **Viterbi Decoder (Hard & Soft)**: Decodes the received signal using the Viterbi algorithm.
- ✅ **Monte Carlo Simulation**: Performs multiple iterations to compute BER (Bit Error Rate) vs SNR.

