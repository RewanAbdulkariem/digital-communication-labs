% Simulation parameters
clear all;  clc;
NumBits = 1e5;     % Number of bits to transmit
SNRrange = 0:2:30; % Range of SNR values to test
NumSamples = 20;   % Number of samples to represent each bit waveform
SamplingInstant = 20; % Sampling instant for matched filter
filter = ones(NumSamples,1);

% Generate random binary data vector
Bits = randi([0 1], NumBits, 1);

% Initialization
MfBer = zeros(1,length(SNRrange));
corrBer = zeros(1,length(SNRrange));
detectorBer =  zeros(1,length(SNRrange));

for n = 1:length(SNRrange)
    % Represent each bit with proper waveform
    dataTransmitted = reshape(repmat(Bits,1,NumSamples)',NumBits*NumSamples,1);
        
    % Add noise
    SNR = SNRrange(n);
    dataRecieved = awgn(dataTransmitted,SNR,'measured');
    
    %% Matched filter
    MF_Out = conv(dataRecieved,filter);
    samples = MF_Out(SamplingInstant:NumSamples:end);
    
    % Perform thresholding
    threshold = mean(dataRecieved);

    MFdetectedBit = samples >= threshold;

    % Calculate BER
    bitErrors = xor(MFdetectedBit,Bits);
    MfBer(n) = sum(bitErrors)/NumBits;
    
    %% correlator
    % reshape the received signal into NumBits rows and 20 columns
    recieved_corr = reshape(dataRecieved,20,NumBits)';
    corrData = recieved_corr * filter;
    CorrdetectedBit = corrData >= threshold;
    CorrDifference  = xor(CorrdetectedBit,Bits);    %xor between Received signal after comparator with bits
    corrBer(n) =  sum(CorrDifference)/NumBits;
    %% simple detector
     samples = dataRecieved(NumSamples:SamplingInstant:end);
     detectedBit = samples >= threshold;
     bitErrors = xor(detectedBit,Bits);
     detectorBer(n) = sum(bitErrors)/NumBits;
end
figure
% Plot BER vs SNR
tansmisttedPower = (1/NumBits) * sum(Bits.^2);
display(tansmisttedPower);
semilogy(SNRrange,MfBer,'linewidth', 2,'color','b','marker','o');
hold on;
semilogy(SNRrange,corrBer,'linewidth', 2,'color','r');
semilogy(SNRrange,detectorBer,'linewidth', 2,'color','k');

xlabel('SNR (dB)');
ylabel('Bit Error Rate');
title('BER vs SNR Correlator and Matched Filter');
legend('Matched filter','Correlator')
grid on;

hold off;