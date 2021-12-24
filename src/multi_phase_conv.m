function y_fired = multi_phase_conv(y, h, D)
    % do multi-phase convolution
    N = length(y); L = length(h);
    y_fired = zeros(1, N+L+D-2);
    for i = 1:D
        % step1: get hi
        ind = i:D:L;
        hi = zeros(1, L);
        hi(ind-i+1) = h(ind);                    % length(hi) is always L
        % step2: get yi(delay)
        yi = [zeros(1, i-1), y, zeros(1, D-i)];  % length(yi) is always N+D-1
        % step3: do convlution
        yi_fired = conv(yi, hi);                 % length(yi_fired) = N+L-i
        % setp3: sum up
        y_fired = y_fired + yi_fired;
    end
    y_fired = y_fired(1:N+L-1);
end