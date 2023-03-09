function rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,case_type,fs)
%
% Inputs:
%   rec_sample_seq: The input sample sequence to the channel
%   case_type:      The sampling frequency used to generate the sample sequence
%   fs:             The bit flipping probability
% Outputs:
%   rec_sample_seq: The sequence of sample sequence after passing through the channel
%
% This function takes the sample sequence after passing through the
% channel, and decodes from it the sequence of bits based on the considered
% case and the sampling frequence

if (nargin <= 2)
    fs = 1;
end

switch case_type
    
    case 'part_1'
        %%% WRITE YOUR CODE FOR PART 1 HERE
        %%% Receiver design: simple flip-and-compare approach
        rec_bit_seq = xor(rec_sample_seq, rand(size(rec_sample_seq)) >= fs);
        %%%
    case 'part_2'
        %%% WRITE YOUR CODE FOR PART 2 HERE
        rec_bit_seq = zeros(1,length(rec_sample_seq)/fs); % initialize output
        n = 1; % index for output

        for i = 1:fs:length(rec_sample_seq)
            sample = rec_sample_seq(i:i+fs-1); % get current chunk
            rec_bit_seq(n) = mode(sample); % find most frequent value and assign to output
            n = n + 1; % increment index
        end
        %%%
    case 'part_3'
        %%% WRITE YOUR CODE FOR PART 3 HERE
        
        %%%
end