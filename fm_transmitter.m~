function modulated_sig = fm_transmitter(message,Fc,Fs,freq_dev)
    rh = 1;
    syms f(t)
    f(t) = 20*t+Fc;
    t = 1:rh:5;
    f = f(t);
    modulated_sig = [];
    for i = 1:length(t)
        modulated_sig(i) = fmmod(message,f(i),Fs,freq_dev);
    end
end