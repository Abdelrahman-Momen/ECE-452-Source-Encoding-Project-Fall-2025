function [codebook_sh_bin, len_avg_Sh_Bin, alpha]= sh_bin_dict(prob, I, H_2)

  L = length(prob);

  % 1. Calculate Cumulative probability factor (alpha)
  alpha = zeros(L, 1);
  alpha(2:end) = cumsum(prob(1:end-1));

  % 2. Calculate Codeword Lengths (l)
  l = ceil(I);

  % 3. Calculate Average Codeword Length
  len_avg_Sh_Bin = sum(prob .* l);
  efficiency_sh_bin = H_2 / len_avg_sh_bin;
  fprintf("Shannon Binary Efficiency equals %.3f \n", efficiency_sh_bin);
  % -------------------------------------------------------------------
  %                   BINARY CODEWORD GENERATION
  % -------------------------------------------------------------------
  
  % A. Set up the matrix for multiplication
  % Max length needed for the matrix
  max_l = max(l);
  
  % Create the matrix of powers of 2 (1/2, 2/2, 4/2, 8/2, ... = 2^1, 2^2, 2^3, ...)
  % Size: L x max_l. Each column is [2^1; 2^1; ...] for the first bit, 
  % then [2^2; 2^2; ...] for the second bit, etc.
  P = 2.^(1:max_l);

  % B. Calculate the Intermediate Values
  % Matrix multiplication/element-wise product:
  % P(j, i) = alpha(j) * 2^i
  S_scaled = alpha .* P; % Size L x max_l

  % C. Extract the bits (floor and mod 2 equivalent)
  % The bit is found by: floor(alpha * 2^i) - 2 * floor(alpha * 2^(i-1))
  % Which is equivalent to the difference method or bit extraction.
  
  % Calculate V_floor: floor(alpha * 2^i)
  V_floor = floor(S_scaled); % Size L x max_l

  % Calculate the bit (the fractional part * 2)
  % V(j, i) = floor(alpha(j) * 2^i) - 2 * floor(alpha(j) * 2^(i-1))
  % A simpler way is to use bit shift logic on the scaled numbers:
  % V_bits(j, i) = V_floor(j, i) - 2 * V_floor(j, i-1)
  
  % Use diff to find the change between floor values (which gives the bit)
  % We need V_floor(j, 0) = 0 for the first bit, so prepend a column of zeros
  V_padded = [zeros(L, 1), V_floor]; % Size L x (max_l + 1)
  
  % The difference calculates V_floor(i) - V_floor(i-1)
  % But we need the difference *modulo 2*
  V_bits = mod(diff(V_padded, 1, 2), 2); % Size L x max_l
  
  % D. Convert bits to strings
  codebook_sh_bin = cell(L, 1);
  for j = 1:L
      % Trim to the required length l(j) and convert to character array
      v_char = char(V_bits(j, 1:l(j)) + '0'); 
      % Join the characters into a string (codeword)
      codebook_sh_bin{j} = join(v_char, "");
  end
  

end
