function f = sigmoid(x)

argument = -1 .* x;
denom = 1 + exp(argument);
f = 1 ./ denom;