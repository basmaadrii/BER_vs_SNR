function [] = BER_16QAM(bits, SNR)
tbitsMatrix = reshape(bits, length(bits)/4, 4);
tdata = bi2de(tbitsMatrix);
tx = qammod(tdata, 16, 0);
Ptx = mean(abs(tx).^2); %computing power signal
for i = 1 : length(SNR)
    current_snr = 10^(SNR(i)/10); %converting snr from dB to volt
    noise = sqrt(Ptx / (2 * current_snr)) * ( randn(size(tx)) + 1j * randn(size(tx)) ); %simulating noise
    rx = tx + noise; %adding noise to signal
    rdata = qamdemod(rx, 16);
    rbitsMatrix = de2bi(rdata);
    rbits = rbitsMatrix(:).';
    %deciding whether 1 was sent or 0
    [numerr, ber(i)] = biterr(bits, rbits); %computing ber
end
semilogy(SNR, ber); %plotting ber vs snr
grid;
xlabel('SNR (dB)');
ylabel('Bit Error Rate');
x = (0:15)';
y = qammod(x, 16, 'bin');
scatterplot(y);
text(real(y)+0.1, imag(y), dec2bin(x));
title('16-QAM, Constellation Diagram');
axis([-4 4 -4 4]);
end