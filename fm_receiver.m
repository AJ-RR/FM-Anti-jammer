function demodulated_sig = fm_receiver(fm_signal,fc,fs,freq_dev)
    hop_sequence = [1,2,3,4,5];  
    %hop_sequence = 1:1/50:5;
    hop_duration = 2*fs;
    demodulated_sig = [];
    m_length = length(fm_signal);
    %Demodulate sequentially
    for i = hop_sequence
        if m_length < hop_duration
            demodulated = fmdemod(fm_signal((i-1)*hop_duration:length(fm_signal)),i*fc, fs, freq_dev);
            %demodulated = lowpass(demodulated, 10000, fs);
            demodulated_sig = [demodulated_sig,demodulated,zeros(hop_duration - length(fm_signal))];
        else
            if i == 1
                demodulated = fmdemod(fm_signal(1:i*hop_duration + 1),i*fc,fs,freq_dev);
                %demodulated= lowpass(demodulated, 10000, fs);
                demodulated_sig = [demodulated_sig,demodulated];
                m_length = m_length - hop_duration;
            else           
                demodulated = fmdemod(fm_signal(((i-1))*hop_duration :(i)*hop_duration),i*fc,fs,freq_dev);
                %demodulated = lowpass(demodulated, 10000, fs);
                demodulated_sig = [demodulated_sig,demodulated];
                m_length = m_length - hop_duration;
            end
        end
    end
     b = 1;
     a = [1 -0.95];
     demodulated_sig = filter(b, a, demodulated_sig);
end