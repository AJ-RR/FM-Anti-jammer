function modulated_sig = fm_transmitter(message,Fc,Fs,freq_dev)
  hop_sequence = [1,2,3,4,5];
  hop_duration = 1*Fs;
  overlap  = 100;
  modulated_sig = [];
  m_length = length(message);
%   b = [1 -0.95];
%   a = 1;
%   message = filter(b,a,message);
  %Modulate sequentially
  for i = hop_sequence
    if m_length <= hop_duration

          modulated = fmmod(message((i-1)*hop_duration - overlap : length(message)),i*Fc, Fs, freq_dev);
          modulated_sig = [modulated_sig,modulated, zeros(hop_duration - length(message))];
      else
        if(i == 1)
            w = hamming(length(message(1:hop_duration + overlap)),'periodic');
            modulated = fmmod(message(1:hop_duration + overlap).*(transpose(w)),i*Fc,Fs,freq_dev);
            modulated_sig = [modulated_sig,modulated];
            m_length = m_length - hop_duration;
        else
%             modulated = fmmod(message((i - 1)*hop_duration : i*hop_duration), i*Fc, Fs, freq_dev);
            w = hamming(length(message((i - 1)*hop_duration - overlap: i*hop_duration + overlap)),'periodic');
            modulated = fmmod(message((i - 1)*hop_duration - overlap: i*hop_duration + overlap).*(transpose(w)) , i*Fc, Fs, freq_dev);
            modulated_sig = [modulated_sig,modulated];
            m_length = m_length - hop_duration;
        end
      end
  end
%   Wo = 4000/(Fs/2);  BW = Wo/20;
%   [b,a] = iirnotch(Wo,BW);
%   modulated_sig = filter(b,a,modulated_sig);
%   
%   Wo = 8000/(Fs/2);  BW = Wo/20;
%   [b,a] = iirnotch(Wo,BW);
%   modulated_sig = filter(b,a,modulated_sig);
%   
%   Wo = 12000/(Fs/2);  BW = Wo/20;
%   [b,a] = iirnotch(Wo,BW);
%   modulated_sig = filter(b,a,modulated_sig);
  end  