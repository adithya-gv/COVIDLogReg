theta = [0; 0];
load day.dat;
X = day;
load CACaseCount.dat;
y = CACaseCount;
ind = size(y, 1);
max = 2 * y(ind);
y = y ./ max;

X(:, 2) = X(:, 2) - 110;

J1 = 1;
J2 = 0;

while ((J1 - J2) > 0.000000001),
    J1 = costFunction(theta, X, y, ind);
    theta = theta - (0.00003 * thetaUpdate(theta, X, y, ind));
    J2 = costFunction(theta, X, y, ind);
    difference = J1 - J2
end;
theta