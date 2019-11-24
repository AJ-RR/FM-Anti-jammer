
[signal, Fs] = audioread('success.wav');
signal = transpose(signal(:,1));
disp(Fs);
dt = 1/Fs;
t = 0:dt:length(signal)/Fs;
message_duration = length(signal)/Fs;

[audio_spectrum, audio_freq, dfreq] = contFT(signal, t(1), dt, 10);
figure(1);
plot(audio_freq, abs(audio_spectrum));

fc = 4000;

modulated_signal = fm_transmitter(signal,fc,Fs,5);

%Defining the time axis
time = 0:dt:(length(modulated_signal) - 1)/Fs;
disp(length(time));
disp(length(modulated_signal));
figure(2);
plot(time, modulated_signal);
[spectrum, freq, df] = contFT(modulated_signal, t(1), dt, 1);

figure(3);
plot(freq, abs(spectrum));

%Demodulate the signal
demodulated_signal = fm_receiver(modulated_signal,fc,Fs,5, message_duration);
disp(length(demodulated_signal));
[spectrum, freq, df] = contFT(demodulated_signal, t(1), dt, 10);
figure(4);
plot(freq, abs(spectrum));
y = lowpass(demodulated_signal, 5000, Fs);
figure(5);
[spectrum, freq, df] = contFT(y, t(1), dt, 10);
plot(freq, abs(spectrum));
audiowrite('final.wav',demodulated_signal,Fs);
