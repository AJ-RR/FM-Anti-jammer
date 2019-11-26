function modulated_sig = fm_transmitter(message,Fc,Fs,freq_dev,s)
  rng(s);
  hop_sequence = randi(5,[1,5])
%   hop_sequence = [1,2,3,4,5]
  hop_duration = 2*Fs;
  modulated_sig = [];
   m_length = length(message);
    b = [1 -0.95];
    a = 1;
    message = filter(b,a,message);
  %Modulate sequentially
  for i = 1:length(hop_sequence)
    if m_length <= hop_duration
          modulated = fmmod(message((i-1)*hop_duration  : length(message)),hop_sequence(i)*Fc, Fs, freq_dev);
%           modulated = modulated.*transpose(hamming(length(modulated)));
          modulated_sig = [modulated_sig,modulated, zeros(hop_duration - length(message))];
      else
        if(i == 1)
            modulated = fmmod(message(1:hop_duration),hop_sequence(i)*Fc,Fs,freq_dev);
%             modulated = modulated.*transpose(hamming(length(modulated)));
            modulated_sig = [modulated_sig,modulated];
            m_length = m_length - hop_duration;
        else
            modulated = fmmod(message((i - 1)*hop_duration : i*hop_duration) , hop_sequence(i)*Fc, Fs, freq_dev);
%             modulated = modulated.*transpose(hamming(length(modulated)));
            modulated_sig = [modulated_sig,modulated];
            m_length = m_length - hop_duration;
        end
      end
  end
  end  