[signal, Fs] = audioread('whatareyou2.wav');
signal = transpose(signal(:,1));
signal = resample(signal, 3, 1);
Fs = 3*Fs;
disp(Fs);
dt = 1/Fs;
snr = 20;
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

fc = 10000;
%random number seed
s = rng;
modulated_signal = fm_transmitter(signal,fc,Fs,50,s);

% %Passing modulated signal through channel
% modulated_signal = channel(modulated_signal, snr);
% 
%Defining the time axis
time = 0:dt:(length(modulated_signal) - 1)/Fs;

figure(2);
plot(time, modulated_signal);
[spectrum, freq, df] = contFT(modulated_signal, t(1), dt, 1);

figure(3);
plot(freq, abs(spectrum));

 %Passing modulated signal through channel
  [jam, fs] = audioread('jamming.wav');
  disp(fs);
  jam = transpose(jam(:,1)) * 1;
  jam = resample(jam,3, 1);
  fs = 3*fs;
     jam = lowpass(jam, 4000, fs);
  jamming_signal = fmmod(jam,20000,fs,50);
  jamming_signal(end+1:end+(length(modulated_signal)-length(jamming_signal))) = 0;
  modulated_signal = modulated_signal +jamming_signal;
  
  % uncomment to add noise to channel
%      modulated_signal = channel(modulated_signal, snr);


%Demodulate the signal
demodulated_signal = fm_receiver(modulated_signal,fc,Fs,50,s);
disp(length(demodulated_signal));
demodulated_signal = lowpass(demodulated_signal, 5000, Fs);
[spectrum, freq, df] = contFT(demodulated_signal, t(1), dt, 10);
figure(4);
plot(freq, abs(spectrum));
    grid on;
    title('Spectrum of the Received Noisy Signal');
    xlabel('f(Hz)');
    ylabel('M(f)');

% uncomment to remove noise   
%  demodulated_signal = noiseReduction_YW(transpose(demodulated_signal),Fs);


%  figure(5);
%  [spectrum, freq, df] = contFT(demodulated_signal', t(1), dt, 10);
%  plot(freq, abs(spectrum));
%      grid on;
%      title('Spectrum of the Retrieved Signal');
%      xlabel('f(Hz)');
%      ylabel('M(f)');
 
% figure(7);
% plot(t(1:end-1), signal);
%     grid on;
%     title('Message Signal');
%     xlabel('t(seconds)');
%     ylabel('m(t)');
% 
%  figure(6);
%  plot(time(1:end-1), demodulated_signal(1:end-2));
%     grid on;
%     title('Retrieved Signal');
%     xlabel('t(seconds)');
%     ylabel('m(t)');
%  figure(7);
%      grid on;
%     title('Demodulated Signal');
%     xlabel('t(seconds)');
%     ylabel('m(t)');
%  plot(t(1:end-1),demodulated_signal(1:end-2));

% 
%  figure(5);
%  [spectrum, freq, df] = contFT(demodulated_signal', t(1), dt, 10);
%  plot(freq, abs(spectrum));
%      grid on;
%      title('Spectrum of the Retrieved Signal');
%      xlabel('f(Hz)');
%      ylabel('M(f)');

 
demodulated_signal = resample(demodulated_signal,1,3);
audiowrite('final.wav',demodulated_signal,Fs/3);






