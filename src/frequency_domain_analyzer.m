function frequency_domain_analyzer(all_series, all_fs)
    num = length(all_series);
    figure; set(gcf,'outerposition',get(0,'screensize'));
    figname = 'Frequency domain analyze'; sgtitle(figname); 
    for i=1:num
        yi = all_series{i}; N = length(yi);
        Yik = fftshift(abs(fft(yi)));
        % calculate the analogy frequency f
        Fsi = all_fs{i}; F0 = Fsi/N;
        f = -ceil((Fsi-F0)/2):F0:ceil((Fsi-F0)/2);
        f = f(1:N); % Notice: the left half is 1 bit longer if N is even
        labely = sprintf('Y_{%d}(k)', i);
        subplot(num, 1, i); plot(f, Yik); ylabel(labely);
    end
    xlabel('f(Hz)');
    
    % save figure
    figpath = './fig'; figtype = 'jpg'; 
    savename = strrep(figname, ' ', '_');
    fullpath = [figpath, '/', savename, '.', figtype];
    print(gcf, '-djpeg', '-r600', fullpath); % save figure
end

