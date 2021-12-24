function error_checking(all_series)
    y1 = all_series{1}; y2 = all_series{2};
    y3 = all_series{3}; y4 = all_series{4};
    s = sum(y1.^2);
    sigma21 = sum((y2-y1).^2);
    sigma31 = sum((y3-y1).^2);
    sigma41 = sum((y4-y1).^2);
    SNR2 = todB(s, sigma21);
    SNR3 = todB(s, sigma31);
    SNR4 = todB(s, sigma41);
    goal1 = SNR3 - SNR2;
    goal2 = abs(SNR4 - SNR3);
    fprintf('==============RESULT===============\n\n');
    fprintf('SNR3 - SNR2 = %f dB\n\n', goal1);
    fprintf("|SNR4 - SNR3| = %f dB\n\n", goal2);
    % for extra
    if length(all_series) == 5
        y5 = all_series{5};
        sigma51 = sum((y5-y1).^2);
        SNR5 = todB(s, sigma51);
        goal3 = abs(SNR5 - SNR3);
        fprintf("|SNR5 - SNR3| = %f dB\n\n", goal3);
    end
end

