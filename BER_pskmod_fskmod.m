function [] = BER_pskmod_fskmod(bits, mod, SNR)
switch(mod) %generating random sequence of bits
    case 'PSK'
        tx = pskmod(bits, 2);
    case 'FSK'
        tx = fskmod(bits, 2, 1, 2, 2);
end
Ptx = mean(abs(tx).^2); %computing power signal
for i = 1 : length(SNR)
    current_snr = 10^(SNR(i)/10); %converting snr from dB to volt
    noise = sqrt(Ptx / (2 * current_snr)) * ( randn(size(tx)) + 1j * randn(size(tx)) ); %simulating noise
    rx = tx + noise; %adding noise to signal
    switch (mod)
        case 'PSK'
            drx = pskdemod(rx, 2);
        case 'FSK'
            drx = fskdemod(rx, 2, 1, 2, 2);
    end
     %deciding whether 1 was sent or 0
    [numerr, ber(i)] = biterr(bits, drx); %computing ber
end

semilogy(SNR, ber); %plotting ber vs snr
xlabel('SNR (dB)');
ylabel('Bit Error Rate');
end

