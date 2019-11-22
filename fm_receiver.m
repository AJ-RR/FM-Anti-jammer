function demodulated_sig = fm_receiver(fm_signal,fc,fs,freq_dev)
    rh = 1;
    syms f(t);
    f(t) = 200*t+fc;
    t = 1:rh:5;
    f = double(f(t));
    demodulated_sig = [];
    for i = 1:length(t)
        demodulated = fmdemod(fm_signal(i,:),f(i),fs,freq_dev);
        demodulated_sig = [demodulated_sig;demodulated];
    end
end