[signal, Fs] = audioread('whatareyou2.wav');
signal = transpose(signal(:,1));
disp(Fs);
dt = 1/Fs;
snr = 75;
t = 0:dt:length(signal)/Fs;
message_duration = length(signal)/Fs;
signal = lowpass(signal, 4000, Fs);

[audio_spectrum, audio_freq, dfreq] = contFT(signal, t(1), dt, 10);
figure(1);
plot(audio_freq, abs(audio_spectrum));
    grid on;
    title('Message Spectrum');
    xlabel('f(Hz)');
    ylabel('M(f)');

fc = 4000;
%random number seed
s = rng;
modulated_signal = fm_transmitter(signal,fc,Fs,50,s);

% %Passing modulated signal through channel
% modulated_signal = channel(modulated_signal, snr);
% 
%Defining the time axis
time = 0:dt:(length(modulated_signal) - 1)/Fs;
disp(length(time));
disp(length(modulated_signal));
figure(2);
plot(time, modulated_signal);
[spectrum, freq, df] = contFT(modulated_signal, t(1), dt, 1);

figure(3);
plot(freq, abs(spectrum));
% 
 %Passing modulated signal through channel
 modulated_signal = channel(modulated_signal, snr);
 [spectrum, freq, df] = contFT(modulated_signal, t(1), dt, 1);
% 
 figure(8);
 plot(freq, abs(spectrum));



%Demodulate the signal
demodulated_signal = fm_receiver(modulated_signal,fc,Fs,50,s);
disp(length(demodulated_signal));
demodulated_signal = lowpass(demodulated_signal, 4000, Fs);
[spectrum, freq, df] = contFT(demodulated_signal, t(1), dt, 10);
figure(4);
plot(freq, abs(spectrum));
% demodulated_signal = medfilt1(demodulated_signal,200);
% %figure(5);
% %[spectrum, freq, df] = contFT(demodulated_signal, t(1), dt, 10);
% %plot(freq, abs(spectrum));
% figure(6);
% plot(t(1:end-1), signal);

figure(10);
plot(t(1:end-1), demodulated_signal(1:end-9));
title('Received Noisy signal');
xlabel('t(seconds)')
ylabel('r(t)')

s_noisy = spectrogram(demodulated_signal);
spectrogram(demodulated_signal,'yaxis');
ylim([0,0.3])
demod_sig = noiseReduction_YW(transpose(demodulated_signal),Fs);
figure(7);
plot(t(1:end-1), demod_sig(1:end-9));
title('Retrieved signal')
xlabel('t(seconds)');
ylabel('m(t)');
spectrogram(demodulated_signal,'yaxis');
ylim([0,0.3])
% disp(length(t))
% disp(length(demodulated_signal))
%demodulated_signal = medfilt1(demodulated_signal,200);
%figure(5);
%[spectrum, freq, df] = contFT(demodulated_signal, t(1), dt, 10);
%plot(freq, abs(spectrum));

figure(6);
plot(t(1:end-1), signal);
    grid on;
    title('Message Signal');
    xlabel('t(seconds)');
    ylabel('m(t)');
% figure(7);
% plot(demodulated_signal);



disp(length(t));
disp(length(demodulated_signal));

audiowrite('final.wav',demod_sig,Fs);






