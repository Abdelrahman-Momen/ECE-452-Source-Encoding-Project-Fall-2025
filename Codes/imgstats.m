function [prob, I, H_2] = imgstats(image)
  % Check and store image size
  [r, c] = size(image);

  [counts, lvlz] = imhist(image);

  % Display the input image
  imshow(image);

  % Representing Histogram / Frequency analysis of gray-scale values
  figure;
  imhist(image)
  title("Histogram")
  xlabel("Image Levels")
  ylabel("Total Number of occurences")
  ylim([-max(counts)*0.01, max(counts)*1.1])
  grid on

  prob = counts ./ (r*c);

  % Reserve a column vector for Info Gained

  I = zeros(length(prob),1);

  % Calculate Info Gained and Entropy

  for i = 1:length(prob)
    if prob(i) > eps
      I(i) = -log2(prob(i));
    end
  end
  H_2 = sum(prob .* I);

  fprintf('\n\n--- Stats Table ---\n');
  T = table(lvlz, prob, I, ...
      'VariableNames', {'Levels', 'Probability', 'Information (bits)'});
  disp(T);

  fprintf("Entropy equals %.3f \n", H_2);
