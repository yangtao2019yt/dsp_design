function y_padded = zeropadding(y, L, varargin)
    % padding the shorter series to length of L using zero
    % default padding zero on the right side
    l = length(y);
    if isempty(varargin)
        side = 'right';
    else
        side = varargin{1};
    end
    if strcmp(side, 'right')
        y_padded = [y, zeros(1, L-l)]; 
    elseif strcmp(side, 'left')
    	y_padded = [zeros(1, L-l), y];
    else
        disp('wrong usuage');
    end
end

