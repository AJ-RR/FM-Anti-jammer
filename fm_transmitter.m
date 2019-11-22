function modulated_sig = fm_transmitter(message,Fc,Fs,freq_dev)
    rh = 1;
    syms f(t)
    f(t) = 200*t+Fc;
    t = 1:rh:5;
    f = double(f(t));
    disp(f);
    modulated_sig = [];
  for i = 1:length(t)
        modulated = fmmod(message,f(i),Fs,freq_dev);
        modulated_sig = [modulated_sig;modulated];
  end  
end