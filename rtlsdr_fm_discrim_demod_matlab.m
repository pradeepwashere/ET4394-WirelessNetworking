function rtlsdr_fm_discrim_demod_matlab
offline          = 0;                           % 0 = use RTL-SDR, 1 = import data
rtlsdr_id        = '0';                         % stick ID
rtlsdr_fc        = 106.3e6;                      % tuner centre frequency in Hz
rtlsdr_gain      = 10;                          % tuner gain in dB
rtlsdr_fs        = 2.4e6;                       % tuner sampling rate
rtlsdr_ppm       = 0;                           % tuner parts per million correction
rtlsdr_frmlen    = 256*25;                      % output data frame size (multiple of 5)
rtlsdr_datatype  = 'single';                    % output data type
audio_fs         = 48e3;                        % audio output sampling rate
sim_time         = 60;                          % simulation time in seconds

rtlsdr_frmtime = rtlsdr_frmlen/rtlsdr_fs;       % calculate time for 1 frame of data (EU)
    [num,den] = butter(1,3183.1/(audio_fs/2));

    obj_rtlsdr = comm.SDRRTLReceiver(...
        rtlsdr_id,...
        'CenterFrequency', rtlsdr_fc,...
        'EnableTunerAGC', false,...
        'TunerGain', rtlsdr_gain,...
        'SampleRate', rtlsdr_fs, ...
        'SamplesPerFrame', rtlsdr_frmlen,...
        'OutputDataType', rtlsdr_datatype,...
        'FrequencyCorrection', rtlsdr_ppm);
    
    % fir decimator - fs = 2.4MHz downto 48kHz
    obj_decmtr = dsp.FIRDecimator(...
        'DecimationFactor', 50,...
        'Numerator', firpm(350,[0,15e3,48e3,(2.4e6/2)]/(2.4e6/2),...
        [1 1 0 0], [1 1], 20));
% iir de-emphasis filter
obj_deemph = dsp.IIRFilter(...
    'Numerator', num,...
    'Denominator', den);

% delay
obj_delay = dsp.Delay;

% audio output
obj_audio = dsp.AudioPlayer(audio_fs);

% spectrum analyzers
% obj_spectrummod   = dsp.SpectrumAnalyzer(...
%    'Name', 'Spectrum Analyzer Modulated',...
%    'Title', 'Spectrum Analyzer Modulated',...
%    'SpectrumType', 'Power density',...
%     'FrequencySpan', 'Full',...
%     'SampleRate', rtlsdr_fs);
% obj_spectrumdemod = dsp.SpectrumAnalyzer(...
%   'Name', 'Spectrum Analyzer Demodulated',...
%    'Title', 'Spectrum Analyzer Demodulated',...
%    'SpectrumType', 'Power density',...
%     'FrequencySpan', 'Full',...
%     'SampleRate', audio_fs);

%% SIMULATION

% if using RTL-SDR, check first if RTL-SDR is active
%if offline == 0    
 %   if ~isempty(sdrinfo(obj_rtlsdr.RadioAddress))
  %  else
   %     error(['RTL-SDR failure. Please check connection to ',...
    %        'MATLAB using the "sdrinfo" command.']);
    %end
%end

% reset run_time to 0 (secs)
run_time = 0;

% loop while run_time is less than sim_time
while run_time < sim_time
    
    % fetch a frame from obj_rtlsdr 
    rtlsdr_data = step(obj_rtlsdr); %takes amplitude
    
    % update 'modulated' spectrum analyzer window with new data
    %step(obj_spectrummod, rtlsdr_data);
    
    % implement frequency discriminator
    discrim_delay = step(obj_delay,rtlsdr_data);
    discrim_conj  = conj(rtlsdr_data);
    discrim_pd    = discrim_delay.*discrim_conj; %product 
    discrim_arg   = angle(discrim_pd);
    
    % decimate + de-emphasis filter data
    data_dec = step(obj_decmtr,discrim_arg);
    data_deemph = step(obj_deemph,data_dec);
    
    % update 'demodulated' spectrum analyzer window with new data
    %step(obj_spectrumdemod, data_deemph);
    % output demodulated signal to speakers
    step(obj_audio,data_deemph);
    
    % update run_time after processing another frame
    run_time = run_time + rtlsdr_frmtime;
    
end
end