function modulated_sig = fm_transmitter(message,Fc,Fs,freq_dev)
  hop_sequence = [1,2,3,4,5];
  modulated_sig = [];
    
  %Modulate sequentially
  for i = hop_sequence
        modulated = fmmod(message,i*Fc,Fs,freq_dev);
        modulated_sig = [modulated_sig,modulated];
  end  
end