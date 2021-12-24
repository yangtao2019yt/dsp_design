function plot_helper(i, figname, labelx, labely)
    % figure(i); plot(x, y); 
    % Notice: do these 2 step in main function!
    figpath = './fig'; figtype = 'jpg'; 
    savename = strrep(figname, ' ', '_');
    fullpath = [figpath, '/', savename, '.', figtype];
    title(figname); xlabel(labelx); ylabel(labely);
    print(i, '-djpeg', '-r600', fullpath); % save figure
end
