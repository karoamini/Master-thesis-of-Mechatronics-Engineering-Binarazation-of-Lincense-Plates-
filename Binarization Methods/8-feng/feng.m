
function output=feng(image, varargin)
% Initialization
numvarargs = length(varargin);      % only want 3 optional inputs at most
if numvarargs > 7
    error('myfuns:somefun2Alt:TooManyInputs', ...
     'Too many parameters was passed to the function.');
end
 
optargs = {[3 3] [5 5] 0.12 2 0.25 0.04 'replicate'}; % set defaults
 
optargs(1:numvarargs) = varargin;   % use memorable variable names
[window, windowBig, alpha, gamma, k1, k2, padding] = optargs{:};

if ndims(image) ~= 2
    error('The input image must be a two-dimensional array.');
end

% Convert to double
image = double(image);

% Standard deviation (big window)
[meanBig, iNormal] = averagefilter(image, windowBig, padding);
[meanSquareBig, iSquare] = averagefilter(image.^2, windowBig, padding);
deviationBig = (meanSquareBig - meanBig.^2).^0.5;

% Standard deviation and mean (small window), reuse the integral images
mean = averagefilter(image, window, iNormal);
meanSquare = averagefilter(image.^2, window, iSquare);
deviation = (meanSquare - mean.^2).^0.5;

% Minimum
minimum = minfilt2(image, window);

% Feng
alpha2 = k1*(deviation./deviationBig).^gamma;
alpha3 = k2*(deviation./deviationBig).^gamma;
threshold = (1-alpha)*mean + alpha2.*(deviation./deviationBig).*(mean-minimum) + alpha3.*minimum;
output = (image > threshold);
