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
iters = 0;
ind = size(y, 1);
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
maxi = 0;
indY = 0;
disp("Estimating Inflection Point...");
for i = 1:size(avgY),
    if (y(i) > maxi),
        maxi = avgY(i);
        indY = i;
    end;
end;
if (indY == size(avgY, 1)),
    max = y(ind);
    diff1 = y(ind) - y(ind - 1);
    diff2 = y(ind - 1) - y(ind - 2);
    diff3 = y(ind - 2) - y(ind - 3);
    ratio1 = diff1/diff2;
    ratio2 = diff2/diff1;
    diff = abs(ratio2-ratio1) / 20;
    ratio = (ratio1 + ratio2) / 2;
    while(ratio > 1),
        ratio = ratio - (diff);
        max = max + (diff1 * ratio);
        iters = iters + 1;
    end;
    max = 2 * max;
    y = y ./ max;
    X(:, 2) = X(:, 2) - (ind + iters);
else,
    max = 2 * y(indY + 14);
    X(:, 2) = X(:, 2) - (indY);
end;

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

plotX = [];
plotY = [];
printf("Graphing Cases: ");
counter = 1;
for i = 1:(size(day, 1) * 2),
    if (i == round(counter * (size(day, 1) * 2) / 10)),
        printf("|");
        counter = counter + 1;
    end;
    plotInd = i - size(day, 1) - iters;
    x = [1; plotInd];
    pred = sigmoid(theta' * x) * max;
    plotX = [plotX; plotInd];
    plotY = [plotY; pred];
end;
printf("|\n");
day = day .- day(size(day, 1));
plotX = [day; plotX];
plotY = [CaseCount; plotY];
scatter(plotX, plotY);

disp("Making Predictions...")


printf("Yesterday, there were: %d cases. \n", yesterday);

printf("Today, there were: %d cases. \n", today);

x = [1; (2 - iters)];

pred1 = sigmoid(theta' * x) * max;
printf("Tommorow, we predict: %d cases. \n", round(pred1));

x = [1; (11 - iters)];

pred10 = sigmoid(theta' * x) * max;
printf("In 10 days, we predict: %d cases. \n", round(pred10));

x = [1; (51 - iters)];

pred50 = sigmoid(theta' * x) * max;
printf("In 50 days, we predict: %d cases. \n", round(pred50));