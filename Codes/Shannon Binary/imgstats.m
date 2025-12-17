function [prob, I, H_2, counts, symbols] = imgstats(image)
  % Check and store image size
  [r, c] = size(image);

  % 1. Histogram counts (already optimized built-in)
  counts = imhist(image);

  % --- Display Code (Side Effect, not optimized) ---
  figure; imshow(image);
  figure; imhist(image)
  title("Histogram")
  xlabel("Image Levels")
  ylabel("Total Number of occurences")
  ylim([0 2e5]);
  xlim([-10 255]);
  grid on
  % -------------------------------------------------

  % 2. Calculate probabilities for all 256 levels (already vectorized)
  prob_full = double(counts ./ (r*c));
  
  % 3. Find unique symbols (levels) that actually exist in the image (Vectorized using find)
  valid_indices = find(prob_full > 0); % 1-based indices (1 to 256)
  
  % Corresponding probabilities
  prob_nonzero = prob_full(valid_indices);
  
  % Corresponding actual pixel values (symbols: 0 to 255)
  symbols_nonzero = valid_indices - 1; 

  % 4. Combine and Sort by Probability (Optimized via table/sortrows)
  T = table(prob_nonzero, symbols_nonzero, ...
      'VariableNames', {'P', 'S'});
      
  T_sorted = sortrows(T, 'P', 'descend');
  
  prob = T_sorted.P;       % Sorted probabilities
  symbols = T_sorted.S;    % Sorted original 0-255 pixel values
  
  L = length(prob);
  
  % ------------------------------------------------------------------
  % 5. VECTORIZATION / OPTIMIZATION (Information Content and Entropy)
  % ------------------------------------------------------------------
  
  % ORIGINAL CODE (Loop):
  % I = zeros(L,1);
  % for i = 1:L
  %     I(i) = -log2(prob(i));
  % end
  
  % OPTIMIZED (Vectorized):
  I = -log2(prob);
  
  % Entropy calculation (already vectorized)
  H_2 = sum(prob .* I);

  fprintf("Entropy equals %.3f \n", H_2);
end
