theta = [0; 0];
load day.dat;
X = day;
load CACaseCount.dat;
y = CACaseCount;
ind = size(y, 1);
max = y(ind);
diff1 = y(ind) - y(ind - 1);
diff2 = y(ind - 1) - y(ind - 2);
diff3 = y(ind - 2) - y(ind - 3);
ratio1 = diff1/diff2;
ratio2 = diff2/diff1;
diff = abs(ratio2-ratio1) / 20;
iters = 0;
ratio = (ratio1 + ratio2) / 2;
while(ratio > 1),
    ratio = ratio - (diff);
    max = max + (diff1 * ratio);
    iters = iters + 1;
end;
max = 2 * max;
y = y ./ max;

X(:, 2) = X(:, 2) - (ind + iters);

J1 = 1;
J2 = 0;

disp("Running Logistic Regression (this will take 30-40 seconds).");

while ((J1 - J2) > 0.000000001),
    J1 = costFunction(theta, X, y, ind);
    theta = theta - (0.00003 * thetaUpdate(theta, X, y, ind));
    J2 = costFunction(theta, X, y, ind);
    difference = J1 - J2;
end;
theta;

x = [1; (1 - iters)];

pred1 = sigmoid(theta' * x) * max;
con1 = strcat("Tomorrow, we predict: ", num2str(round(pred1)), " cases.");
disp(con1);

x = [1; (10 - iters)];

pred10 = sigmoid(theta' * x) * max;
con10 = strcat("In 10 days, we predict: ", num2str(round(pred10)), " cases.");
disp(con10);

x = [1; (50 - iters)];

pred50 = sigmoid(theta' * x) * max;
con50 = strcat("In 50 days, we predict: ", num2str(round(pred50)), " cases.");
disp(con50);