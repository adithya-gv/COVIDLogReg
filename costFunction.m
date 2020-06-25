function cost = costFunction(theta, X, y, ind)

sum = 0;
for i = 1:ind,
    h = sigmoid(X(i, :) * theta);
    leftLog = log(h);
    leftTerm = y(i) * leftLog;
    rightLog = log(1 - h);
    rightTerm = (1 - y(i)) * rightLog;
    sum = sum + leftTerm + rightTerm;
end;

newSum = -1 * sum;
cost = newSum / ind;