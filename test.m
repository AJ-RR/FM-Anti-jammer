[signal, Fs] = audioread('whatareyou2.wav');
b = [1 -0.95];
a = 1;
signal = filter(b,a,signal);
snr = 50;
mod_w_noise = awgn(signal, snr);
b = 1;
a = [1 -0.95];
demodulated_sig = filter(b, a, mod_w_noise);
audiowrite('final_test.wav',demodulated_sig,Fs);

