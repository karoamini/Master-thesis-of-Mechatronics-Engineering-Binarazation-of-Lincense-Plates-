function [A, T] = EntropyThresholding(img)
 
[h, ~] = imhist(img);
h = h/sum(h); % Normalize the histogram so that it sums to 1.
entropies = zeros(256, 1); % Intialize array for storing entropies.
for t = 1:254
    White = h(1:t);
    Black = h(t+1:255);
    % Add 0.001 to prevent division by zero(nan) and log of zero(-inf).
    HB =  sum((Black/(0.001+sum(Black))).*log((Black+0.001)/(0.001 +sum(Black))));
    HW =  sum((White/(0.001+sum(White))).*log((White+0.001)/(0.001 +sum(White))));
    entropies(t) = HB+HW; 
end
[~, T] = max(abs(entropies)); % The Maximal entropy determines the threshold.
T = T - 1;
A = img > T;