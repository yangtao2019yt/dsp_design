function [y_cut, Fs] = load_audio(filename, start_sec, length_sec)
    % load series from audio file
    info = audioinfo(filename)
    [y, Fs] = audioread(filename);
    left = Fs*start_sec + 1;
    right = Fs*(start_sec+length_sec);
    y_cut = y(left:right, 1)';
end