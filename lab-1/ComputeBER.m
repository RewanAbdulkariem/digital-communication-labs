function BER = ComputeBER(bit_seq,rec_bit_seq)
%
% Inputs:
%   bit_seq:     The input bit sequence
%   rec_bit_seq: The output bit sequence
% Outputs:
%   BER:         Computed BER
%
% This function takes the input and output bit sequences and computes the
% BER

%%% WRITE YOUR CODE HERE
count=0;
for x=1:length(bit_seq)
    if (rec_bit_seq(x) ~= bit_seq(x))
        count=count+1;
    else 
        count =count+0;
    end
end
BER= count / (length(bit_seq));
%%%
