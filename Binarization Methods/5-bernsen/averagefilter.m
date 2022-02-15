function image=averagefilter(image, varargin)

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

if ~mod(m,2) m = m-1; end       % check for even window sizes
if ~mod(n,2) n = n-1; end

if (ndims(image)~=2)            % check for color pictures
    display('The input image must be a two dimensional array.')
    display('Consider using rgb2gray or similar function.')
    return
end

% Initialization.
[rows columns] = size(image);   % size of the image

% Pad the image.
imageP  = padarray(image, [(m+1)/2 (n+1)/2], padding, 'pre');
imagePP = padarray(imageP, [(m-1)/2 (n-1)/2], padding, 'post');

% Always use double because uint8 would be too small.
imageD = double(imagePP);

% Matrix 't' is the sum of numbers on the left and above the current cell.
t = cumsum(cumsum(imageD),2);

% Calculate the mean values from the look up table 't'.
imageI = t(1+m:rows+m, 1+n:columns+n) + t(1:rows, 1:columns)...
    - t(1+m:rows+m, 1:columns) - t(1:rows, 1+n:columns+n);

% Now each pixel contains sum of the window. But we want the average value.
imageI = imageI/(m*n);

% Return matrix in the original type class.
image = cast(imageI, class(image));
