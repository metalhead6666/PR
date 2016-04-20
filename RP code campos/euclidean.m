function [gk] = euclidean(mk,x)

wk = mk';
bias =mk'*mk;% norm(mk)*norm(mk);

gk = (wk*x') -0.5* bias;

end