function [ber] = BER (bits, mod, SNR)
switch(mod) %generating random sequence of bits
    case 'OOK'
        tx = bits;
    case 'PRK'
        tx = 2 * (bits) - 1;
    case 'FSK'
        tx = (1j - 1) * (bits) + 1;
end
Ptx = mean(abs(tx).^2); %computing power signal
for i = 1 : length(SNR)
    current_snr = 10^(SNR(i)/10); %converting snr from dB to volt
    noise = sqrt(Ptx / (2 * current_snr)) * ( randn(size(tx)) + 1j * randn(size(tx)) ); %simulating noise
    rx = tx + noise; %adding noise to signal
    switch (mod)
        case 'OOK' 
            drx = real(rx) >= 0.5;
        case 'PRK'
            drx = real(rx) >= 0;
        case 'FSK'
            drx = (real(rx) - imag(rx)) < 0;
    end
     %deciding whether 1 was sent or 0
    [numerr, ber(i)] = biterr(bits, drx); %computing ber
end

semilogy(SNR, ber); %plotting ber vs snr
grid;
xlabel('SNR (dB)');
ylabel('Bit Error Rate');