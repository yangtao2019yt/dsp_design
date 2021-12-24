function y_fired = multi_phase_conv_par(y, h, D)
    % move array y, h to gpu
    y = gpuArray(y); h = gpuArray(h);
    % do multi-phase convolution
    N = length(y); L = length(h);
    y_fired = zeros(D, N+L+D-2, 'gpuArray');
    for i = 1:D
        % step1: get hi
        ind = i:D:L;
        hi = zeros(1, L, 'gpuArray');
        hi(ind-i+1) = h(ind);                    % length(hi) is always L
        % step2: get yi(delay)
        yi = [zeros(1, i-1), y, zeros(1, D-i)];  % length(yi) is always N+D-1
        % step3: do convlution
        y_fired(i, :) = conv(yi, hi);            % length(yi_fired) = N+L-i
    end
    y_fired = sum(y_fired(:, 1:N+L-1));
end

