function y_resampled = my_resample(y, I, D, varargin)
    % get filter
    if length(varargin) > 1
        h = varargin{1};
    else
        Nn = 10;
        h = filter_helper(I, D, Nn, 0);
    end
    L = length(h);
    % do upsample
    [y_upsampled, ~] = my_upsample(y, 1, I);
    % do conv
    y_fired = conv(y_upsampled, h);
    y_fired = delay_helper(y_fired, L);
    % do downsample
    [y_resampled, ~] = my_downsample(y_fired, 1, D);
end
