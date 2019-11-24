function [mod_w_noise] = channel(modulated_signal, snr)
    mod_w_noise = awgn(modulated_signal, snr);
end