function [spectrum,freq,dfreq] = get_spectrum(signal, tstart, dt, df_desired)
[spectrum, freq, dfreq] = contFT(signal, tstart, dt, df_desired);
end