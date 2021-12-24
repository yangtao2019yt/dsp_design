function [y_downsampled, Fs2] = my_downsample(y, Fs, D)
    % extract seires yn by every D point
    N = length(y);
    n_downsampled = 1:D:N;
    y_downsampled = y(n_downsampled);
    Fs2 = ceil(Fs/D);
end