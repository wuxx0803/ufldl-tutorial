function [cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, data, labels)

% numClasses - the number of classes 
% inputSize - the size N of the input vector
% lambda - weight decay parameter
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
% labels - an M x 1 matrix containing the labels corresponding for the input data
%

% Unroll the parameters from theta
% 10, 784
theta = reshape(theta, numClasses, inputSize);

numCases = size(data, 2);

% 10, 60000
groundTruth = full(sparse(labels, 1:numCases, 1));
cost = 0;


thetagrad = zeros(numClasses, inputSize);

%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute the cost and gradient for softmax regression.
%                You need to compute thetagrad and cost.
%                The groundTruth matrix might come in handy.




exponent = theta * data;
exponent = exp(bsxfun(@minus, exponent, max(exponent, [], 1)));
denominator = sum(exponent, 1);

% 10, 60000
h = bsxfun(@rdivide, exponent, denominator);

cost = (sum((groundTruth .* log(h))(:)) * (-1 / numCases)) + (lambda / 2 * sum(theta(:) .** 2));

thetagrad = (-1/numCases) * (groundTruth - h) * data' + lambda * theta;



% ------------------------------------------------------------------
% Unroll the gradient matrices into a vector for minFunc
grad = [thetagrad(:)];
end

