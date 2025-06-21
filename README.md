# 📡 Convolutional Codes Simulation in MATLAB

This project simulates the full digital communication chain using **convolutional codes**, demonstrating the process of encoding, modulation, transmission over a noisy channel, and decoding using both **hard** and **soft Viterbi decoding**.

It performs a Monte-Carlo Simulation and evaluates the **Bit Error Rate (BER)** performance over varying signal-to-noise ratios (Eb/N0) and compares simulated results with theoretical bounds.

---

## 🧠 Concepts Used

- Convolutional Encoding using generator polynomials
- State diagram construction for trellis decoding
- BPSK (Binary Phase Shift Keying) modulation
- AWGN (Additive White Gaussian Noise) channel simulation
- Hard & Soft decision **Viterbi decoding**
- Monte Carlo simulation to estimate BER
- BER vs. Eb/N0 performance comparison

---

## 📁 Project Structure

```bash
📦 convolutional-codes/
 ┣ 📄 main.m                  # Main simulation file
 ┣ 📄 encoding.m              # Convolutional encoder
 ┣ 📄 hard_decoding.m         # Hard decision Viterbi decoder
 ┣ 📄 soft_decoding.m         # Soft decision Viterbi decoder
 ┗ 📄 state_diagram.m         # State diagram (trellis) generator

```

---

## ⚙️ Parameters Simulated

The project includes simulations for the following convolutional coding configurations:

| k | n | Kc | r     | Generator Matrix (Octal)     |
|---|---|----|-------|-------------------------------|
| 1 | 2 | 3  | 1/2   | `[5, 7]`                      |
| 1 | 3 | 4  | 1/3   | `[13, 15, 17]`                |
| 1 | 3 | 6  | 1/3   | `[117, 127, 155]`             |

The appropriate generator matrix is automatically selected in `main.m` using a `switch` statement based on the values of `k`, `n`, `Kc`, and `r`.

---

## 🚀 How to Run This Project

1. Open **MATLAB**.
2. Clone or download this repository.
3. Ensure all `.m` files are in the same working directory.
4. Open `main.m` and modify the parameters `k`, `n`, `Kc` if needed.
5. Run the script:
   ```matlab
   >> main
   ```
6. A BER vs. Eb/N0 plot will appear, comparing hard and soft decoding performance.
- Hard decision Viterbi decoding
- Soft decision Viterbi decoding
- Theoretical error rate

---

## 📊 Sample Output

- A semi-logarithmic plot (`semilogy`) displaying BER vs. Eb/N0
- Observations include:
  - Soft decoding significantly outperforms hard decoding at low SNRs
  - Higher constraint lengths yield lower BER but at greater computational cost

---

## ✅ Dependencies

- MATLAB R2019 or later (or GNU Octave with adjustments)
- No external toolboxes required

---

## 📌 Learnings

- Fundamentals of convolutional codes and Viterbi decoding
- Differences between hard and soft decision decoding
- Role of constraint length in code performance
- Practical understanding of BER analysis via Monte Carlo simulation

---

## 👨‍💻 Author

**Sanyam Shah**  
B.Tech – Information and Communication Technology  
Email: sanyamshah749@gmail.com
