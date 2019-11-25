[signal, Fs] = audioread('whatareyou2.wav');
signal = transpose(signal(:,1));
disp(Fs);
dt = 1/Fs;
snr = 100;
t = 0:dt:length(signal)/Fs;
message_duration = length(signal)/Fs;
signal = lowpass(signal, 10000, Fs);

[audio_spectrum, audio_freq, dfreq] = contFT(signal, t(1), dt, 10);
figure(1);
plot(audio_freq, abs(audio_spectrum));

fc = 4000;

modulated_signal = fm_transmitter(signal,fc,Fs,5);

%Passing modulated signal through channel
modulated_signal = channel(modulated_signal, snr);

%Defining the time axis
time = 0:dt:(length(modulated_signal) - 1)/Fs;
disp(length(time));
disp(length(modulated_signal));
figure(2);
plot(time, modulated_signal);
[spectrum, freq, df] = contFT(modulated_signal, t(1), dt, 1);

figure(3);
plot(freq, abs(spectrum));

%Passing modulated signal through channel
modulated_signal = channel(modulated_signal, snr);
[spectrum, freq, df] = contFT(modulated_signal, t(1), dt, 1);

figure(8);
plot(freq, abs(spectrum));

%Demodulate the signal
demodulated_signal = fm_receiver(modulated_signal,fc,Fs,5);
disp(length(demodulated_signal));
[spectrum, freq, df] = contFT(demodulated_signal, t(1), dt, 10);
figure(4);
plot(freq, abs(spectrum));
% demodulated_signal = lowpass(demodulated_signal, 10000, Fs);
demodulated_signal = medfilt1(demodulated_signal,200);
%figure(5);
%[spectrum, freq, df] = contFT(demodulated_signal, t(1), dt, 10);
%plot(freq, abs(spectrum));
figure(6);
plot(t(1:end-1), signal);
figure(7);
plot(t(1:end-1), demodulated_signal(1:end-9));
disp(length(t))
disp(length(demodulated_signal))
audiowrite('final.wav',demodulated_signal,Fs);
