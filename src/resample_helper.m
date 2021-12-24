function [y_resampled, Fs2] = resample_helper(y, Fs, I, D, h)
    % do resample in a easier and cleaner way
%     y_resampled = resample(y, I, D, h);
    y_resampled = resample(y, I, D);    % different filter can cause err
    Fs2 = ceil(Fs*I/D);
    % Notice: resample do I interpolation at first and then D extract
end