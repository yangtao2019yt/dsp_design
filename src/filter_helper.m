function  filter = filter_helper(I, D, varargin)
    if isempty(varargin)
        N = 10;  var = 1E-13;
    else
        N = varargin{1}; var = varargin{2};
    end
    beta = 5;
    pqmax = max(I, D);
    L = 2*N*pqmax + 1;
    fc = 1/2/pqmax;
    win = kaiser(L, beta+var*rand);
    filter = fir1(L-1, fc*2, win);
    filter = I * filter / sum(filter);
%     filter = fir2(N, [0 wc 1], [D, 0, 0]);
end
