function Y = minfilt2(X,varargin)

% Initialization
[S, shape] = parse_inputs(varargin{:});

% filtering
Y = vanherk(X,S(1),'min',shape);
Y = vanherk(Y,S(2),'min','col',shape);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [S, shape] = parse_inputs(varargin)
shape = 'same';
flag = [0 0]; % size shape

for i = 1 : nargin
   t = varargin{i};
   if strcmp(t,'full') & flag(2) == 0
      shape = 'full';
      flag(2) = 1;
   elseif strcmp(t,'same') & flag(2) == 0
      shape = 'same';
      flag(2) = 1;
   elseif strcmp(t,'valid') & flag(2) == 0
      shape = 'valid';
      flag(2) = 1;
   elseif flag(1) == 0
      S = t;
      flag(1) = 1;
   else
      error(['Too many / Unkown parameter : ' t ])
   end
end

if flag(1) == 0
   S = [3 3];
end
if length(S) == 1;
   S(2) = S(1);
end
if length(S) ~= 2
   error('Wrong window size parameter.')
end

