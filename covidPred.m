disp("Loading Data...");
theta = [0; 0];
load day.dat;
smallX = day;
X = zeros(size(smallX), 2);
X(:, 1) = 1;
X(:, 2) = smallX;
load CaseCount.dat;
y = CaseCount;
yesterday = y(size(y, 1) - 1);
today = y(size(y, 1));
ind = size(y, 1);
disp("Estimating Inflection Point...");
difY = zeros(ind - 1, 1);
for i = 2:ind,
    difY(i - 1) = y(i) - y(i-1);
end;
difY;
avgY = zeros(ind - 14, 1);
for i = 14:(ind - 1),
    avgY(i - 13) = (difY(i - 13) + difY(i - 12) + difY(i - 11) + difY(i - 10) + difY(i - 9) + difY(i - 8) + difY(i - 7) + difY(i - 6) + difY(i - 5) + difY(i - 4) + difY(i - 3) + difY(i - 2) + difY(i - 1) + difY(i)) / 14;
end;
avgY;
ind2 = 0;
maxi = 0;
for i = 1:size(avgY),
    if (avgY(i) > maxi),
        maxi = avgY(i);
        ind2 = i;
    end;
end;
limit = 2 * y(ind2 + 14);
X(:, 2) = X(:, 2) - ind2;
y = y ./ limit;

J1 = 1;
J2 = 0;
status = 0;
printf("Running Logistic Regression: ");
for i = 1:1000,
    if(mod(i, 100) == 0),
        printf("|");
    end;
    J1 = costFunction(theta, X, y, ind);
    theta = theta - (0.00003 * thetaUpdate(theta, X, y, ind));
    J2 = costFunction(theta, X, y, ind);
    difference = J1 - J2;
end;
printf("|\n");

disp("Making Predictions...")

minD = today;
minI = 0;
for i = 1:size(X, 1),
    pred = sigmoid(theta' * X(i, :)') * limit;
    d2 = abs(today - pred);
    if (d2 < minD),
        minD = d2;
        minI = i;
    end;
end;

printf("Yesterday, there were: %d cases. \n", yesterday);

printf("Today, there were: %d cases. \n", today);

x3 = [1; (X(minI, 2))];

x = [1; (X(minI, 2) + 1)];

pred1 = (sigmoid(theta' * x) * limit) - (sigmoid(theta' * x3) * limit) + today;
printf("Tommorow, we predict: %d cases. \n", round(pred1));

x = [1; (X(minI, 2) + 10)];

pred10 = (sigmoid(theta' * x) * limit) - (sigmoid(theta' * x3) * limit) + today;
printf("In 10 days, we predict: %d cases. \n", round(pred10));

x = [1; (X(minI, 2) + 50)];

pred50 = (sigmoid(theta' * x) * limit) - (sigmoid(theta' * x3) * limit) + today;
printf("In 50 days, we predict: %d cases. \n", round(pred50));