
%------------------------Pulse Code Modulation-------------------- 
clear 
clc
%%
%_____(1) Generate a sinusoidal wave of the following parameters:___%
amplitude = 1; 
frequency = 2; 
sampling_frequency = 4000; 
time = 0:1/sampling_frequency:1; 
sinusoid = amplitude * sin(2*pi*frequency*time);
figure(1)

subplot(2,1,1)
plot(time,sinusoid)
ylabel('Amplitude');
xlabel('time');
legend('Signal before quantization')

fftsinusoid=fft(sinusoid); 
fftsinusoid=fftshift(fftsinusoid); 
fs=4000;
freq=linspace(-fs/2,fs/2,length(fftsinusoid)); 

subplot(2,1,2)
plot(freq,abs(fftsinusoid)) 
xlabel('freq') 
ylabel('magnitude');
legend('magnitude of Signal before quantization')
%%
%_____(2) Quantize the sampled signal by m bits where m= 2n+1 and n is the
%number of bits that will represents the integer value and the fraction part
% and the last bit is the sign bit %
n = [3,4,5,10]; % number of bits for integer and fraction part
m = 2.*n+1; % total number of bits (including sign bit)
figure(2)
mean_square_error = zeros(size(n));
for i=1:length(n)
%   the fi function is being used to quantize a sinusoidal signal, 
%   resulting in a fixed-point data object that represents the quantized signal.
%   The double function is then used to convert this fixed-point data object to 
%   a double precision floating-point format, which can be used with other MATLAB 
%   functions and operations that work with floating-point data types.
    
    quantized_signal = double(fi(sinusoid,1,m(i),n(i)));
    quantization_error = mean((quantized_signal - sinusoid).^2);   %qe from the equation
    mean_square_error(i) = quantization_error;
    subplot(2,2,i)
    plot(time,quantized_signal,'b')
    ylabel('Amplitude'); xlabel('time');
    legend(['qe= ',num2str(quantization_error)])
    title(['at n= ',num2str(n(i)),'bit'])
    binary_signal = dec2bin(abs(quantized_signal));
%     % Display the quantized and binary signals for n=3
     if n(i) == 3
%         disp('Quantized signal:')
%         disp(quantized_signal')
%         disp('Binary signal:')
%         disp(binary_signal')
   end
end
figure(3)
plot(n,mean_square_error);
ylabel('Quantization Error'); 
xlabel('n bits');
%%
figure(4)
mean_square_error = zeros(size(n));

for i=1:length(n)
   q = quantizer('fixed', [m(i) n(i)]); 
   %a quantizer object with properties set to its inputs.
   
   quantized_signal=quantize(q, sinusoid);
   quantization_error = mean((quantized_signal - sinusoid).^2);  %--> quantization error from eqn
   mean_square_error(i) = quantization_error;
   subplot(2,2,i)
   plot(time,quantized_signal,'b')
   legend(['qe= ',num2str(quantization_error)])
    ylabel('Amplitude');
    xlabel('time');
   title(['at n= ',num2str(n(i)),'bit'])

end
figure(5)
plot(n,mean_square_error);
ylabel('Quantization Error'); 
xlabel('n bits');
%%
compressed = compand(sinusoid,255,max(sinusoid),'mu/compressor');
% Non-uniform quantization is achieved by, first passing the input signal through a compressor. 
% The output of the compressor is then passed through a uniform quantizer.
% The combined effect of the compressor and the uniform quantizer is that of a non-uniform quantizer.
% At the receiver the signal is restored to its original form by using an expander. 

%*******************
figure(6)
mean_square_error = zeros(size(n));
for i=1:length(n)
   q = quantizer('fixed', [m(i) n(i)]);
   
   quantized_signal=quantize(q, compressed);     %Non uniform quantization
   quantization_error = mean((quantized_signal - sinusoid).^2);  %--> quantization error from eqn
   mean_square_error(i) = quantization_error;

   subplot(2,2,i)
   plot(time,quantized_signal,'b')
   legend(['qe= ',num2str(quantization_error)])
   ylabel('Amplitude'); xlabel('time');
   title(['at n= ',num2str(n(i)),'bit'])


end
figure(7)
plot(n,mean_square_error);
ylabel('Quantization Error'); 
xlabel('n bits');
