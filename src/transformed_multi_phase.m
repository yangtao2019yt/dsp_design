function [yi_downsampled_fired, Fs2] = transformed_multi_phase(y, Fs, h, D)
    % Notice: this fucntion do downsampling as well (and also at first)!!
    % move array y, h to gpu
    y = gpuArray(y); h = gpuArray(h);
    % do multi-phase convolution
    N = length(y); L = length(h); M = N+D-1;
    n = floor(N/D); mm = floor(M/D)+1; l_max = floor(L/D)+1;
    yi_downsampled_fired = zeros(D, mm+l_max-1, 'gpuArray');
    Fs2 = ceil(Fs/D);
    for i = 1:D
        % step1: get hi
        ind = i:D:L; hi = zeropadding(h(ind), l_max);   
        % length(hi) is at max l_max, so we padding it to l_max
   
        % step2: get yi(delay)
        yi = [zeros(1, i-1), y, zeros(1, D-i)];  
        % length(yi) is always N+D-1
        
        % step3: do downsampling
        [yi_downsampled, ~] = my_downsample(yi, Fs, D);
        % length(yi_downsampled) is always nn
        
        % step3: do convlution
        yi_downsampled_fired(i, :) = conv(yi_downsampled, hi);
        % Notice that length(yi_downsampled_fired) is always nn+l_max-1
    end
    % convlution result with a length(L) filter should
    % always be delayed L/2+1
    yi_downsampled_fired = delay_helper(yi_downsampled_fired, l_max);
    yi_downsampled_fired = gather(sum(yi_downsampled_fired(:, 1:n)));
end