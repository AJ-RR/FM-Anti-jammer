function [spectrum,freq,dfreq] = get_spectrum(signal, tstart, dt, df_desired)
spectrum = [];
freq = [];
dfreq = [];
for i = 1 : length(signal(:,1))
    [spec,f,df] = contFT(signal(i,:), tstart, dt, df_desired);
    spectrum = [spectrum;spec];
    freq = [freq;f];
    dfreq = [dfreq;df];
end
end