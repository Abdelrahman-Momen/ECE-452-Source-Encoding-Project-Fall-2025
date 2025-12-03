# 📡 ECE 452s — Source Encoding Project

*Ain Shams University — Faculty of Engineering* *Course: ECE 452s — Information Theory and Coding* *Instructor: [Prof. Bassant Abdelhamid]*

## 👥 Team Members

  - [Abdelrahman Momen](https://github.com/Abdelrahman-Momen)
  - [Iyad Wael](https://github.com/IyadWael)
  - [Abdelrahman Mohamed](https://github.com/crash1218)
  - [Student 4]()
  - [Student 5]()

-----

## 📝 Project Overview

This project covers the implementation of fundamental source coding techniques using **MATLAB/GNU-Octave**. The goal is to design efficient encoding schemes to compress data by exploiting statistical redundancies.
You will:

1.  Analyze a discrete memoryless source (DMS) and compute information measures.
2.  Implement **Shannon Binary Coding**.
3.  Implement **Huffman Coding**.
4.  Compare the efficiency and performance of both coding schemes against the source entropy.

All algorithms, calculations, and performance comparisons are documented in the final report.

-----

## 📂 Repository Structure

```
.
├── README.md
├── task_1_entropy.m      # Source analysis & Entropy calculation
├── task_2_shannon.m      # Shannon Binary Coding implementation
├── task_3_huffman.m      # Huffman Coding implementation
├── task_4_compare.m      # Performance comparison & plots
├── data/
│   └── probabilities.mat # Source probability input (optional)
└── report/
    └── ECE452s_Project_Report_Group[Num].pdf
```

-----

## 📋 Project Tasks

### **Task 1 — Information Measures 📊**

  - Define the source alphabet and probability distribution $P(x_i)$.
  - Verify that $\sum P(x_i) = 1$.
  - Compute the **Self-Information** for each symbol: $I(x_i) = -\log_2(P(x_i))$.
  - Compute the **Source Entropy** $H(X)$ in bits/symbol.

-----

### **Task 2 — Shannon Binary Coding 0️⃣1️⃣**

  - Sort probabilities in descending order.
  - Calculate the cumulative probabilities $\alpha_i$.
  - Determine the codeword length $l_i$ for each symbol: $l_i = \lceil -\log_2 P(x_i) \rceil$.
  - Generate the binary codewords based on the binary expansion of $\alpha_i$.
  - Compute the **Average Code Length** $L_{avg}$ for Shannon coding.

-----

### **Task 3 — Huffman Coding 🌲**

  - Implement the Huffman algorithm (bottom-up tree construction).
  - Group the two least probable symbols and repeat until one root node remains.
  - Assign bits (0 and 1) to the branches to generate codewords.
  - Display the resulting unique codewords for each symbol.
  - Compute the **Average Code Length** $L_{avg}$ for Huffman coding.

-----

### **Task 4 — Performance Analysis & Comparison 📈**

For both Shannon and Huffman techniques, calculate and compare:

  - **Coding Efficiency**: $\eta = \frac{H(X)}{L_{avg}} \times 100\%$.
  - **Redundancy**: $R = 1 - \eta$.
  - **Compression Ratio**.
  - Discuss which method yields an $L_{avg}$ closer to the theoretical limit $H(X)$.

-----

## 🚀 Running the Code

1.  Clone the repository.
2.  Open **MATLAB** or **GNU-Octave**.
3.  Navigate to the project directory.
4.  Run the individual task scripts (e.g., `task_2_shannon.m`) to view the output codewords and calculations in the Command Window.

-----

## 📦 Final Deliverables

Submit a single compressed file containing:

  - All `.m` function and script files.
  - The final PDF report (including manual derivations, codeword tables, and efficiency comparisons).
