
%   Example
%   -------
%       imshow(bradley(imread('eight.tif'), [125 125], 10));
%

function output = bradley(image, varargin)
% Initialization
numvarargs = length(varargin);      % only want 3 optional inputs at most
if numvarargs > 3
    error('myfuns:somefun2Alt:TooManyInputs', ...
     'Possible parameters are: (image, [m n], T, padding)');
end
 
optargs = {[15 15] 10 0 'replicate'}; % set defaults
 
optargs(1:numvarargs) = varargin;   % use memorable variable names
[window, T, padding] = optargs{:};


% Convert to double
image = double(image);

% Local mean
mean = averagefilter(image, window, padding);

% Initialize the output to white color
output = true(size(image));

% Set a pixel to black if the image brightness 
% is below (100-T)% of the average neighbourhood brightness
output(image <= mean*(1-T/100)) = 0;

