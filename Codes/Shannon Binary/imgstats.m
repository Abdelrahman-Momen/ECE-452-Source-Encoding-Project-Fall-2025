function [prob, I, H_2, counts] = imgstats(image)
  % Check and store image size
  [r, c] = size(image);

  counts = imhist(image);

  % Display the input image
  figure;
  imshow(image);

  % Representing Histogram / Frequency analysis of gray-scale values
  figure;
  imhist(image)
  title("Histogram")
  xlabel("Image Levels")
  ylabel("Total Number of occurences")
  ylim([0 2e5]);
  xlim([-10 255]);
  % grid minor on
  grid on

  prob = double(counts ./ (r*c));
  prob = prob(prob > 0);
  L = length(prob);
  prob = sort(prob, 'descend');
  % Reserve a column vector for Info Gained

  I = zeros(length(prob),1);

  % Calculate Info Gained and Entropy

  for i = 1:L
      I(i) = -log2(prob(i));
  end
  H_2 = sum(prob .* I);

% ##  fprintf('\n\n--- Stats Table ---\n');
% ##  T = table(lvlz, prob, I, ...
% ##      'VariableNames', {'Levels', 'Probability', 'Information (bits)'});
% ##  disp(T);

  fprintf("Entropy equals %.3f \n", H_2);