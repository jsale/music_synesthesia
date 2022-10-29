title_for_file = '4_instruments_c_major';
wav_file = sprintf('%s.wav', title_for_file);
xx = audioread(wav_file);
x = 10*xx;
title_for_plot = '4 Instruments C Major';
s = size(x);
epoch = 1024;
step = epoch;
output_epoch = 128;
maxinc = round(s(1,1)/step) - 2;
P4plot = ones(maxinc,output_epoch);
P4csv = ones(maxinc,output_epoch);

for k = 1:1:maxinc
    X = fft(x(k*step:(k*step)+epoch-1),epoch);
    Pxx = X.*conj(X)/epoch;
    f = 44100/epoch*(0:epoch-1);
    %plot(f,Pxx(1:256))
    %plot(f,Pxx)
    %pause
%     plot(f(1:128),Pxx(1:128))
%     Pxxx = Pxx + 0.0001*k;
    P4plot(k,1:output_epoch) = Pxx(1:output_epoch);
    P4csv(k,1:output_epoch) = 1000*Pxx(1:output_epoch);
%     title('Power spectral density of X')
%     xlabel('Frequency (Hz)')
    inc = k
    %pause
end
csv_outfile = sprintf('%s_fft_%d.csv', title_for_file, epoch)
csvwrite(csv_outfile,P4csv);
figure('Position', [0 0 1920 1080])
plot(f(1:output_epoch),P4plot)
title_str = sprintf('%s Epoch=%d', title_for_plot, epoch)
title(title_str)
outfile = sprintf('%s_fft_timeseries_%d.png', title_for_file, epoch)
saveas(gcf, outfile)
v = 0.0:0.01:0.5;
figure('Position', [0 0 1920 1080])
contour(P4plot,v);
title(title_str)
outfile = sprintf('%s_fft_contour_%d.png', title_for_file, epoch)
saveas(gcf, outfile)
figure('Position', [0 0 1920 1080])
surf_epoch = round(output_epoch/2);
s1 = surf(P4plot(:,1:surf_epoch));
s1.EdgeColor = 'none';
cb = colorbar;
caxis([0 1.5]);
title(title_str)
outfile = sprintf('%s_fft_surf_%d.png', title_for_file, epoch)
saveas(gcf, outfile)



