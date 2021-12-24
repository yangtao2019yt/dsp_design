function y_delayed = delay_helper(y, L)
    % y is the conv result and L is the length of FIR
    % notice defualt there is length(y) = N+L-1, 
    % when N is the original audio length
    delay = floor(L/2);                    % delay = (L-1)/2, since L is odd
    y_delayed = y(:, delay+1:end-delay);   % length(y_delayed) = N
end

