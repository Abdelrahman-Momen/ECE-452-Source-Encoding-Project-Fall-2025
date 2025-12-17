function [codebook_sh_bin, len_avg_sh_bin, alpha]= sh_bin_dict(prob, I, H_2)

  L = length(prob);

  % 1. Calculate Cumulative probability factor (alpha)
  alpha = zeros(L, 1);
  alpha(2:end) = cumsum(prob(1:end-1));

  % 2. Calculate Codeword Lengths (l)
  l = ceil(I);

  % 3. Calculate Average Codeword Length
  len_avg_sh_bin = sum(prob .* l);
  efficiency_sh_bin = H_2 / len_avg_sh_bin;
  fprintf("Shannon Binary Efficiency equals %.3f \n", efficiency_sh_bin);
  % -------------------------------------------------------------------
  %                   BINARY CODEWORD GENERATION
  % -------------------------------------------------------------------

  % A. Set up the matrix for multiplication
  max_l = max(l);

  P = 2.^(1:max_l);

  % B. Calculate the Intermediate Values
  % P(j, i) = alpha(j) * 2^i
  S_scaled = alpha .* P; % Size L x max_l

  % C. Extract the bits (floor and mod 2 equivalent)
  V_floor = floor(S_scaled); % Size L x max_l

  % Calculate the bit (the fractional part * 2)
  V_padded = [zeros(L, 1), V_floor]; % Size L x (max_l + 1)

  % The difference calculates V_floor(i) - V_floor(i-1)
  % But we need the difference modulo 2
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
