function [y_upsampled, Fs2] = my_upsample(y, Fs, I)
    % extract seires yn by every D point
    N = length(y); IN = I*N;
    n = 1:N;
    y_upsampled = zeros(1, IN);
    y_upsampled((n-1)*I+1) = y(:);
    Fs2 = ceil(Fs*I);
end