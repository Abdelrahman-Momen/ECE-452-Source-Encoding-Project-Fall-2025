-----

# 📡 ECE 452s — Source Encoding Project (Fall 2025)

*Ain Shams University — Faculty of Engineering* *Course: ECE 452s — Information Theory and Coding* *Instructor:Dr. Bassant Abdelhamid*

## 👥 Team Members

  - [Abdelrahman Momen](https://github.com/Abdelrahman-Momen)
  - [Iyad Wael](https://github.com/IyadWael)
  - [Abdelrahman Mohamed](https://github.com/crash1218)
  - [Mostafa Medhat](https://github.com/MostafaMedhatM)
  - [Ahmed Tamer]()

-----

## 📝 Project Overview

This project focuses on the implementation of lossless source coding algorithms using **MATLAB/GNU-Octave**. The primary goal is to compress discrete data by exploiting statistical redundancies.
You will:

1.  Define a discrete memoryless source with specific symbol probabilities.
2.  Implement **Shannon Binary Coding** based on cumulative probabilities.
3.  Implement **Huffman Coding** using the binary tree reduction method.
4.  Compare the resulting code lengths and efficiencies against the source Entropy.

All results, codeword tables, and efficiency metrics are analyzed in the final report.

-----

## 📂 Repository Structure

```
.
├── README.md
├── shannon_binary.m      # Function: Implements Shannon coding logic
├── huffman_coding.m      # Function: Implements Huffman tree & coding
├── main_project.m        # Main script to run both algorithms & compare
└── report/
    └── ECE452_Project_Report.pdf
```

-----

## 📋 Project Tasks

### **Task 1 — Source Analysis & Entropy 📊**

  - Define the source alphabet symbols and their associated probabilities $P(x_i)$.
  - Ensure the sum of probabilities equals 1.
  - Compute the theoretical **Source Entropy** $H(X)$:
    $$H(X) = - \sum_{i} P(x_i) \log_2 P(x_i) \quad [\text{bits/symbol}]$$

-----

### **Task 2 — Shannon Binary Coding 0️⃣1️⃣**

  - **Step 1:** Sort probabilities in descending order.
  - **Step 2:** Calculate cumulative probabilities $\alpha_i$ (where $\alpha_1 = 0$).
  - **Step 3:** Determine codeword length $l_i$:
    $$l_i = \lceil -\log_2 P(x_i) \rceil$$
  - **Step 4:** Generate codewords by converting $\alpha_i$ to binary and truncating to $l_i$ bits.
  - **Output:** specific binary codewords for every symbol.

-----

### **Task 3 — Huffman Coding 🌲**

  - **Step 1:** Sort probabilities in descending order.
  - **Step 2:** Combine the two lowest probabilities into a new node.
  - **Step 3:** Re-sort and repeat until a single root node (probability 1.0) remains.
  - **Step 4:** Trace back from root to leaves (assign `0` to upper branch, `1` to lower branch) to form codewords.
  - **Output:** Optimal prefix-free codewords.

-----

### **Task 4 — Performance Comparison 📈**

Compare the two techniques by calculating:

1.  **Average Code Length ($L_{avg}$)**:
    $$L_{avg} = \sum_{i} P(x_i) \cdot l_i$$
2.  **Coding Efficiency ($\eta$)**:
    $$\eta = \frac{H(X)}{L_{avg}} \times 100\%$$
3.  **Redundancy ($R$)**: $1 - \eta$

*Conclusion:* Analyze why Huffman generally provides a shorter average length (or equal) compared to Shannon Binary coding.

-----

## 🚀 Running the Code

1.  Clone the repository.
2.  Open `main_project.m` in MATLAB or Octave.
3.  Adjust the `probabilities` array if you wish to test different source data.
4.  Run the script to see the generated codewords and efficiency stats in the Command Window.

-----

## 📦 Final Deliverables

Submit a single compressed file containing:

  - The `.m` source files (`shannon_binary.m`, `huffman_coding.m`, `main_project.m`).
  - The final PDF report containing the problem statement, derivations, and comparison results.
