Fs = 1000;
dt = 1/Fs;
hop_sequence = {1,2,3,4,5};
t = -5:dt:5;
f = 10;
signal = 10*sin(2*pi*f*t);
fc = 100;
signal_modulated = fm(signal,fc,Fs,1);
[signal_modulated_spectrum, f, df] = contFT(signal_modulated, -5, dt, 1);
plot(f,signal_modulated_spectrum);
plot(t,signal,'c',t,signal_modulated,'b--');
xlabel('time');
ylabel('amp');
figure(1);
% for i = 1:length(hop_sequence)
%     signal_modulated = fm(signal,i*fc,Fs,1);
%     [signal_modulated_spectrum,f,df] = contFT(signal_modulated,-5,dt,1);
%     plot(f,abs(signal_modulated_spectrum));
%     hold on;
% end
