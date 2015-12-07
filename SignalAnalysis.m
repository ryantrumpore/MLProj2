function SignalAnalysis(Add)
%Author: Ryan Trumpore
%Date: 4/18/2015
%Add = Add Noise or Filter
%       0-3 = Noise Addition
%       4-9 = Filter Addition
%       else = Speech Analysis
if ischar(Add);
    waveform = Add;
    Add = 10;
elseif Add>9;
    error('input must be a .wav file, or an integer between 0 and 9')
end
addpath('WAV')
addpath('MATLAB')
addpath('DOC')
if (Add<4) %Adding Noise
    if Add==0
        [x,fs] = audioread('wave1.wav');
        noise = 'gaussian';
        filename = 'wave1_gaissian.wav';
        figuredir = 'DOC/Pictures/Noise Pictures/Wave1_gaussian';
    elseif Add==1
        [x,fs] = audioread('wave1.wav');
        noise = 'poisson';
        filename = 'wave1_poisson.wav';
        figuredir = 'DOC/Pictures/Noise Pictures/Wave1_poisson';
    elseif Add==2;
        [x,fs] = audioread('wave1.wav');
        noise = 'salt & pepper';
        filename = 'wave1_sndp.wav';
        figuredir = 'DOC/Pictures/Noise Pictures/Wave1_salt_and_pepper';
    elseif Add==3;
        [x,fs] = audioread('wave1.wav');
        noise = 'speckle';
        filename = 'wave1_speckle.wav';
        figuredir = 'DOC/Pictures/Noise Pictures/Wave1_speckle';
    end
    x = imnoise(x, noise);
end
if Add >3 %Adding Filters
    if Add==4
        [x,fs] = audioread('wave1.wav');
        x = Lowpass_filter(x);
        filename = 'wave1_lowpass.wav';
        figuredir = 'DOC/Pictures/Filters/Wave1/Wave1_lowpass';
    elseif Add==5
        [x,fs] = audioread('wave1.wav');
        x = Highpass_Filter(x);
        filename = 'wave1_highpass.wav';
        figuredir = 'DOC/Pictures/Filters/Wave1/Wave1_highpass';
    elseif Add==6
        [x,fs] = audioread('nsp0.wav');
        x = nsp0_bandstop1(x);
        x = nsp0_bandstop2(x);
        %x = smooth(x);
        filename = 'nsp0_filtered.wav';
        figuredir = 'DOC/Pictures/Filters/nsp0/nsp0_filtered';
    elseif Add==7
        [x,fs] = audioread('nsp1.wav');
        x = nsp1_filter(x);
        filename = 'nsp1_filtered.wav';
        figuredir = 'DOC/Pictures/Filters/nsp1/nsp1_filtered';
    elseif Add==8
        [x,fs] = audioread('nsp2.wav');
        x = smooth(x,'sgolay');
        filename = 'nsp2_filtered.wav';
        figuredir = 'DOC/Pictures/Filters/nsp2/nsp2_filtered';
    elseif Add==9
        [x,fs] = audioread('nsp3.wav');
        x = medfilt1(x,10);
        filename = 'nsp3_filtered.wav';
        figuredir = 'DOC/Pictures/Filters/nsp3/nsp3_filtered';
    else
        [x,fs] = audioread(waveform);
        figuredir = 'DOC/Pictures/Speech Pictures/';
        [~, file, ~] = fileparts(waveform);
        filename = waveform;
        figuredir = strcat(figuredir, file);
        
    end
end
soundsc(x);
currentfig = figure;
specgram(x, 512, fs);
figurelocation = strcat(figuredir,'_specgram');
saveas(currentfig, figurelocation, 'jpg');
currentfig = figure;
plot(x)
figurelocation = strcat(figuredir,'_waveform');
saveas(currentfig, figurelocation, 'jpg');
filename = strcat('WAV/',filename);
audiowrite(filename,x,8000)