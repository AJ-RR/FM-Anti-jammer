Fs = 10000;
dt = 1/Fs;
hop_sequence = {1,2,3,4,5};
t = -5:dt:5;
f = 10;
fc = 1000;
signal = 10*sin(2*pi*f*t);
modulated_signal = fm_transmitter(signal,fc,Fs,5);

[spectrum, freq, df] = get_spectrum(modulated_signal, t(1), dt, 1);

figure(1);
%Display the transmitted spectrum
for i = 1:length(spectrum(:,1))
    plot(freq(i,:),abs(spectrum(i,:)));
    hold on;
end

%Demodulate the signal
demodulated_signal = fm_receiver(modulated_signal,fc,Fs,5);

figure(2);
plot(t, demodulated_signal(1,:));

