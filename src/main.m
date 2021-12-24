clc; close all; clear all;
% pre-settings
figpath = './fig';
audiopath = './audio';
I = 1; D = 30;                    % sample rate control
Nn = 10; L = 2*Nn*max(I, D)+1;    % FIR length
h = filter_helper(I, D);

% Q1: load audio file
start_sec = 0; length_sec = 10;
audioname = [audiopath, '/', 'piano.mp3'];
[y, Fs] = load_audio(audioname, start_sec, length_sec);
sound(y, Fs);

fprintf('==============TIME COST===============\n\n');
% Q2: resample
tic;
[y1, Fs1] = resample_helper(y, Fs, I, D, h);
disp('Matlab Resample:'); toc; fprintf('\n');

% Q3: my_resample
tic;
[y2, Fs2] = my_downsample(y, Fs, D);
disp('My Downsample function:'); toc; fprintf('\n');

% Q4: FIR before my_resample
tic;
y_fired = conv(y, h);
y_fired = delay_helper(y_fired, L);  % Notice: this function delay L//2
[y3, Fs3] = my_downsample(y_fired, Fs, D);
disp('FIR then myDownsample:'); toc; fprintf('\n');

% Q5: multi-phase FIR before my downsample
% serial version
tic;
y_multiphase_fired = multi_phase_conv(y, h, D);
y_multiphase_fired = delay_helper(y_multiphase_fired, L);  % Notice: this function delay L//2
[y4, Fs4] = my_downsample(y_multiphase_fired, Fs, D);
disp('Muti-phase FIR then myDownsample:'); toc; fprintf('\n');
% parallel version (only for testing speed)
tic;
y_multiphase_fired = multi_phase_conv_par(y, h, D);
y_multiphase_fired = delay_helper(y_multiphase_fired, L);  % Notice: this function delay L//2
[~, ~] = my_downsample(y_multiphase_fired, Fs, D);
disp('Muti-phase FIR then myDownsample(parallel version):'); toc; fprintf('\n');

% EXTRA2: downsample before multi-phase FIR

% Q6: check time domain & frequecy domain features
all_series = {y1, y2, y3, y4}; all_fs = {Fs1, Fs2, Fs3, Fs4};
% time domain
% time_domain_analyzer(all_series);
% frequecy domain
% frequency_domain_analyzer(all_series, all_fs);

% Q7: time cost and compute speed
% SEE ABOVE!

% Error checking
error_checking(all_series);