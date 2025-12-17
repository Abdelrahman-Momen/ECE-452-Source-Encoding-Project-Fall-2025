function [codebook_huff,symbols,len_avg_huff] = huff_dict (sym,prob,H_2)
%% ============================
%  Huffman Coding
%  ============================

nodes = struct('symbol',{},'prob',{},'left',{},'right',{});
for i = 1:length(sym)
    nodes(i).symbol = sym(i);
    nodes(i).prob = prob(i);
    nodes(i).left = [];
    nodes(i).right = [];
end

while length(nodes) > 1
    [~, idx] = sort([nodes.prob]);   
    a = nodes(idx(1));
    b = nodes(idx(2));

    newNode.symbol = [];
    newNode.prob = a.prob + b.prob;
    newNode.left = a;
    newNode.right = b;

    nodes(idx(1:2)) = [];
    nodes(end+1) = newNode;
end

dict = struct2cell(generateHuffmanDict(nodes, []));
codebook_huff = dict(2,:)';
symbols = cell2mat(dict(1,:))';

% 1. Get lengths of the generated codes
l = strlength(codebook_huff);

% 2. CRITICAL STEP: Map original probabilities to the new symbol order
% 'sym' is the original symbol list, 'symbols' is the list from the tree
[~, loc] = ismember(symbols, sym); 

% 3. Reorder the probabilities to match the codebook perfectly
prob_aligned = prob(loc);

% 4. Now calculate the average length
len_avg_huff = sum(prob_aligned .* l);

efficiency_huff = H_2 / len_avg_huff;
fprintf("\nHuffman Efficiency equals %.3f \n", efficiency_huff);

end

function dict = generateHuffmanDict(node, prefix)

    if isempty(node.left) && isempty(node.right)
        % Leaf node → Final symbol
        dict = struct('symbol', node.symbol, 'code', prefix);
        return;
    end

    % Recursively assign 0 to left, 1 to right
    leftDict  = generateHuffmanDict(node.left,  strcat(prefix, '0'));
    rightDict = generateHuffmanDict(node.right, strcat(prefix, '1'));

    % Combine
    dict = [leftDict; rightDict];

end
