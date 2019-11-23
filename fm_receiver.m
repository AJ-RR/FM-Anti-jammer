function demodulated_sig = fm_receiver(fm_signal,fc,fs,freq_dev, message_duration)
    hop_sequence = [1,2,3,4,5];    
    demodulated_sig = [];
    
    %Demodulate sequentially
    for i = hop_sequence
        if i == 1
            demodulated = fmdemod(fm_signal(1:i*fs*message_duration + 1),i*fc,fs,freq_dev);
            demodulated_sig = [demodulated_sig,demodulated];
        else           
            demodulated = fmdemod(fm_signal(((i-1)*fs)*message_duration :(i)*fs*message_duration),i*fc,fs,freq_dev);
            demodulated_sig = [demodulated_sig,demodulated];
        end
    end
    
end