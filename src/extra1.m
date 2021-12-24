clc; close all; clear all;
% pre-settings
figpath = './fig';
audiopath = './audio';
I = 6; D = 30;                    % sample rate control
Nn = 10; L = 2*Nn*max(I, D)+1;    % FIR length
h = filter_helper(I, D, Nn, 0);

% Q1: load audio file
start_sec = 0; length_sec = 10;
audioname = [audiopath, '/', 'piano.mp3'];
[y, Fs] = load_audio(audioname, start_sec, length_sec);
sound(y, Fs);

fprintf('==============TIME COST===============\n\n');
% EXTRA1: resample
tic;
[y1, Fs1] = resample_helper(y, Fs, I, D, h);
disp('Matlab Resample:'); toc; fprintf('\n');

% Q3: my_resample
tic;
y2 = my_resample(y, I, D, h);
disp('My Downsample function:'); toc; fprintf('\n');


% Q6: check time domain & frequecy domain features
all_series = {y1, y2}; all_fs = {Fs1, Fs1};
% time domain
time_domain_analyzer(all_series);
% frequecy domain
frequency_domain_analyzer(all_series, all_fs);

% Q7: time cost and compute speed
% SEE ABOVE!

% Error checking
y1 = all_series{1}; y2 = all_series{2};
s = sum(y1.^2);
sigma21 = sum((y2-y1).^2);
SNR2 = todB(s, sigma21);
fprintf('==============RESULT===============\n\n');
fprintf('SNR2 = %f dB\n\n', SNR2);