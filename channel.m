function [noise] = channel(modulated_signal, snr)
    noise = awgn(modulated_signal, snr);
end