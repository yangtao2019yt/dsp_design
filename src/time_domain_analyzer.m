function time_domain_analyzer(all_series)
    num = length(all_series);
    figure; set(gcf,'outerposition',get(0,'screensize'));
    figname = 'Time domain analyze'; sgtitle(figname); 
    for i=1:num
        yi = all_series{i};
        labely = sprintf('y_{%d}(n)', i);
        subplot(num, 1, i); plot(yi); ylabel(labely);
    end
    xlabel('n');
    
    % save figure
    figpath = './fig'; figtype = 'jpg'; 
    savename = strrep(figname, ' ', '_');
    fullpath = [figpath, '/', savename, '.', figtype];
    print(gcf, '-djpeg', '-r600', fullpath); % save figure
end