snr = 0 : 2 : 30; %snr ranges from 0 to 30 dB with 2 dB step size
numbit = 1e6; %num of bits for each SNR value is 1e6
tx = randi([0 1], [1 numbit]); %generating random sequence of bits
Ptx = mean(tx.^2); %computing power signal
for i = 1 : length(snr)
    current_snr = 10^(snr(i)/10); %converting snr from dB to volt
    noise = sqrt(Ptx / (2 * current_snr)) * ( randn(size(tx)) + 1j * randn(size(tx)) ); %simulating noise
    rx = tx + noise; %adding noise to signal
    drx = real(rx) >= 0.5; %deciding whether 1 was sent or 0
    [numerr, ber(i)] = biterr(tx, drx); %computing ber
end
semilogy(snr, ber); %plotting ber vs snr
grid;
xlabel('SNR (dB)');
ylabel('Bit Error Rate');