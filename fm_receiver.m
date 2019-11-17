function demodulated_sig = fm_receiver(fm_signal,fc,fs,fDev)
    rh = 1;
    syms f(t)
    f(t) = 20*t+Fc;
    t = 1:rh:5;
    f = f(t);
    demodulated_sig = [];
    for i = 1:length(t)
        demodulated_sig(i) = fmdemod(fm_signal,f(i),Fs,freq_dev);
    end
end