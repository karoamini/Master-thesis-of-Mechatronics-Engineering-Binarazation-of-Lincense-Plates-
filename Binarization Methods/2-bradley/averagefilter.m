function [image, t] = averagefilter(image, varargin)

%   Example
%   -------
%       I = imread('eight.tif');
%       J = averagefilter(I, [5 5], 'replicate');
%       figure, imshow(I), figure, imshow(J)
%
% Parameter checking.
numvarargs = length(varargin);
if numvarargs > 2
    error('myfuns:somefun2Alt:TooManyInputs', ...
        'requires at most 2 optional inputs');
end
 
optargs = {[3 3] 0};            % set defaults for optional inputs
optargs(1:numvarargs) = varargin;
[window, padding] = optargs{:}; % use memorable variable names
m = window(1);
n = window(2);

if (ndims(image)~=2)            % check for color pictures
    display('The input image must be a two dimensional array.')
    display('Consider using rgb2gray or similar function.')
    return
end

% Initialization.
[rows columns] = size(image);

% If we have to calculate the integral image, calculate it.
if ischar(padding) || isscalar(padding)
    % Pad the image.
    imageP  = padarray(image, [floor((m+1)/2) floor((n+1)/2)], padding, 'pre');
    imagePP = padarray(imageP, [ceil((m-1)/2) ceil((n-1)/2)], padding, 'post');

    % Always use double because uint8 would be too small.
    imageD = double(imagePP);

    % Calculate the integral image - the sum of numbers above and left.
    t = cumsum(cumsum(imageD),2);
else
    % Cut the integral image from the potentionally bigger integral image.
    intm = size(padding, 1) - rows;
    intn = size(padding, 2) - columns;

    deltaMPre = floor((intm+1)/2) - floor((m+1)/2) + 1;
    deltaMPost = ceil((intm-1)/2) - ceil((m-1)/2);
    
    deltaNPre = floor((intn+1)/2) - floor((n+1)/2) + 1;
    deltaNPost = ceil((intn-1)/2) - ceil((n-1)/2);
        
    t = padding(deltaMPre : end-deltaMPost, deltaNPre : end-deltaNPost); 
end

% Calculate the mean values from the look up table 't'.
imageI = t(1+m:rows+m, 1+n:columns+n) + t(1:rows, 1:columns)...
    - t(1+m:rows+m, 1:columns) - t(1:rows, 1+n:columns+n);

% Now each pixel contains sum of the window. But we want the average value.
imageI = imageI/(m*n);

% Return matrix in the original type class.
image = cast(imageI, class(image));
