function gradient = thetaUpdate(theta, X, y, ind)
gradient = [0; 0];

sum = 0;
for i = 1:ind,
    h = sigmoid(X(i, :) * theta);
    difference = h - y(i);
    sumTerm = difference * X(i, :);
    sum = sum + sumTerm;
end;
gradient = (sum ./ ind)';