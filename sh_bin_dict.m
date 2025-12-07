function [codebook_sh_bin, len_avg_Sh_Bin, alpha]= sh_bin_dict(prob, I)
  % Sort probabilities descendingly
  % desc_prob = sort(prob, 'descend');
  % desc_prob = desc_prob(desc_prob > 0);

  L = length(prob);
  % alpha is a Cumulative probability factor
  % Defining 1st (row) alpha as 0 and computing the following alphas
  alpha = zeros(L, 1);
  alpha(1) = 0;
  for i = 2 : length(alpha)
    alpha(i) = alpha(i-1) + prob(i-1);
  end
  % Reserving a vector for Symbol /Color values lengths
  l = zeros(L, 1);
  % Encoding part
  for i = 1:length(l)
      l(i) = ceil(I(i));
  end
  s = alpha;
  v = zeros(L, 1);
  % codebook_sh_bin = cell(L, 1);
  codebook_sh_bin = strings(L, 1);
  for j = 1:L
    sym_interm = s(j);
    symbol_length = l(j);
    for i = 1:symbol_length
        sym_interm = sym_interm * 2;
        v(i) = floor(sym_interm);
        sym_interm = sym_interm - v(i);
    end
    v = v(1 : symbol_length);
    % codebook_sh_bin(j) = num2str(v);
    codebook_sh_bin(j) = join(string(v), "");
  end

  len_avg_Sh_Bin = sum(prob .* l);