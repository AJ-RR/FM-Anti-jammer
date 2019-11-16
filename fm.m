function modulated_sig = modulate(message,Fc,Fs,freq_dev)
modulated_sig = fmmod(message,Fc,Fs,freq_dev)
end