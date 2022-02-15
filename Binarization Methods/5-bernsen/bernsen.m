

function output = bernsen(image, varargin)
% Initialization
numvarargs = length(varargin);      % only want 3 optional inputs at most
if numvarargs > 3
    error('myfuns:somefun2Alt:TooManyInputs', ...
     'Possible BERNSEN parameters are: (image, [m n], contrast, padding)');
end
 
optargs = {[3 3] 15 'replicate'};   % set defaults
 
optargs(1:numvarargs) = varargin;   % use memorable variable names
[window, contrast_threshold, padding] = optargs{:};

if ndims(image) ~= 2
    error('The input image must be a two-dimensional array.');
end

if sum(mod(window,2))~=2
    error('Sorry, only odd valued window dimensions are supported');
end

% Convert to double
image = double(image);

% Mean value
mean = averagefilter(image, window, padding);

% Local contrast
local_contrast = maxfilt2(image, window) - minfilt2(image, window);

% Initialize the output
output = zeros(size(image));

% Whenever contrast in the window is low assume homogenous area
mask = local_contrast < contrast_threshold;
output(mask & image>=128) = 1;

% Otherwise compare to the mean value
output(~mask) = (image(~mask) >= mean(~mask));

