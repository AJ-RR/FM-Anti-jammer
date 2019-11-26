function demodulated_sig = fm_receiver(fm_signal,fc,fs,freq_dev,s)
    rng(s);
    hop_sequence = randi(5,[1,5])
    hop_duration = 2*fs;
    demodulated_sig = [];
    m_length = length(fm_signal);
    %Demodulate sequentially
    for i = 1:length(hop_sequence)
        if m_length <= hop_duration
            demodulated = fmdemod(fm_signal((i-1)*hop_duration:length(fm_signal)),hop_sequence(i)*fc, fs, freq_dev);
            %removing spikes caused by frequency deviation
            demodulated(1:1000) = 0;
            demodulated(end - 1000 : end) = 0;
            demodulated(1:1000) = awgn(demodulated(1:1000), 50);
            demodulated(end - 1000 : end) = awgn(demodulated(end - 1000 : end), 50);
%             b = 1;
%             a = [1 -0.95];
%             demodulated = filter(b, a, demodulated);
            demodulated_sig = [demodulated_sig,demodulated,zeros(hop_duration - length(fm_signal))];
        else
            if i == 1
                demodulated = fmdemod(fm_signal(1:i*hop_duration + 1),hop_sequence(i)*fc,fs,freq_dev);
                demodulated(1:1000) = 0;
                demodulated(end - 1000 : end) = 0;
                demodulated(1:1000) = awgn(demodulated(1:1000), 50);
                demodulated(end - 1000:end) = awgn(demodulated(end - 1000 : end), 50);
                m_length = m_length - hop_duration;
            else           
                demodulated = fmdemod(fm_signal(((i-1))*hop_duration :(i)*hop_duration),hop_sequence(i)*fc,fs,freq_dev);
                demodulated(1:1000) = 0;
                demodulated(end - 1000 : end) = 0;
                demodulated(1:1000) = awgn(demodulated(1:1000), 50);
                demodulated(end - 1000:end) = awgn(demodulated(end - 1000 : end), 50);
                m_length = m_length - hop_duration;
            end
%             b = 1;
%             a = [1 -0.95];
%             demodulated = filter(b, a, demodulated);
            demodulated_sig = [demodulated_sig,demodulated];
        end
    end
%     demodulated_invert = demodulated_sig(end:-1:1);
%     [demodulated_sig, t] = contconv(demodulated_sig, demodulated_invert,0,0,1/fs);
%     figure(7);
%     plot(t, demodulated_sig);
%     disp(length(t))
%     disp(length(demodulated_sig))
end