function sample_seq = GenerateSamples(bit_seq,fs)
%
% Inputs:
%   bit_seq:    Input bit sequence
%   fs:         Number of samples per bit
% Outputs:
%   sample_seq: The resultant sequence of samples
%
% This function takes a sequence of bits and generates a sequence of
% samples as per the input number of samples per bit

%%initializes a vector of zeros with a length equal to the product of
%the number of bits and the number of samples per bit.
sample_seq = zeros(size(bit_seq*fs));

%%% WRITE YOUR CODE FOR PART 2 HERE
n=1;
for i= 1:length(bit_seq)
    sample_seq(n:n+fs-1) = bit_seq(i); % creates a rectangular pulse of duration 1/fs seconds for each bit.
    n = n + fs ;
end 
%%%