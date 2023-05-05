%%
%--------------part2--------------------------------- 
% reconstruction from oversampling 
t=0:0.001:1;% time signal Ts = 0.001 then fs =1000;
y=2*cos(2*pi*5*t); %fm = 5  
[B,A] = butter(3,1000/100000,'low'); % normalized cutoff frequency = 0.01
zero_added_signal=zeros(1,length(y)*10); 
for i=1:length(y) 
zero_added_signal(i*10)=y(i); 
end 
zero_added_signal(1:9)=[];

% Adding zeros enhances the signal display and don't change the 
%spectrum,it changes sampling freq. only 
t=linspace(0,1,length(zero_added_signal)); 
filtered_signal = filter(B,A,zero_added_signal); 
figure(1)

subplot(2,1,1)
plot(t,filtered_signal,'r' ) 
xlabel('time') 
ylabel('oversampled signals') 
s=fft(filtered_signal); 
s=fftshift(s); 
fs=10000;
freq=linspace(-fs/2,fs/2,length(s)); 

subplot(2,1,2)
plot(freq,abs(s)) 
xlabel('freq') 
ylabel('magnitude of over sampled signals') 
% construction from minimum sampling 
t=0:1/10:1; % fs = 2fm =10 (critical sampling )
y=2*cos(2*pi*5*t); 
[B,A] = butter(10,0.1,'low' ); 
zero_added_signal=zeros(1,length(y)*10); 
for i=1:length(y) 
zero_added_signal(i*10)=y(i); 
end 
zero_added_signal(1:9)=[]; 


t=linspace(0,1,length(zero_added_signal)); 
filtered_signal = filter(B,A,zero_added_signal);
figure(2)

subplot(2,1,1)
plot(t,filtered_signal,'r' ) 
xlabel('time') 
ylabel('minimum sampled signals') 
s=fft(filtered_signal); 
s=fftshift(s); 
fs=100; % why 100?? By adding zeros between each sample of the original signal,
                    % the minimum sampled signal has a higher sampling rate than
                    % the original signal which is equal 10*10
freq=linspace(-fs/2,fs/2,length(s)); 
subplot(2,1,2)
plot(freq,abs(s)) 
xlabel('freq') 
ylabel('magnitude of minimum sampled signals') 
% construction from undersampling sampling 
t=0:0.2:1; %fs = 5 less than nyquest rate (fN=10); 
y=2*cos(2*pi*5*t); 
[B,A] = butter(10,0.2,'low' ); 
% complete this part as shown in the construction from minimum sampling 
%and do the necessary changes , you have to do low pass filtering and 
% displays the spectrum 
zero_added_signal=zeros(1,length(y)*10); 
for i=1:length(y) 
zero_added_signal(i*10)=y(i); 
end 
zero_added_signal(1:9)=[]; 


t=linspace(0,1,length(zero_added_signal)); 
filtered_signal = filter(B,A,zero_added_signal);
figure(3)
subplot(2,1,1)

plot(t,filtered_signal,'r' ) 
xlabel('time')
ylabel('undersampling signals') 
s=fft(filtered_signal); 
s=fftshift(s); 
fs=50;
freq=linspace(-fs/2,fs/2,length(s)); 
subplot(2,1,2)
plot(freq,abs(s)) 
xlabel('freq') 
ylabel('magnitude of undersampled signals') 
% Figure 6: This shows the spectrum of the undersampled signal. 
% It suffers from aliasing, as seen by the presence of additional frequency 
% components that were not present in the original signal.