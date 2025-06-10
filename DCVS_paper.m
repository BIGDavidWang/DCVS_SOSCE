clear; clc;
addpath(genpath(pwd)); 
addpath('..\');
addpath('..\Videos');
addpath('..\key_frames');
yuvfilename = {'mobile_qcif.yuv'};
sequence_cnt = length(yuvfilename);
W = 1;
column = 176;
line = 144;
block_size = 16;
frame_No = 100;
ever_Mlist = zeros(frame_No/2,1);
ever_subrate = zeros(frame_No/2,1);
result_list_fast = zeros(frame_No/2,10);
fai = randn(round(column*line/2),column*line);
tao = 30; 
for n = 2:2:frame_No 
    current_estimate_points_No = 24;
    
    filename = yuvfilename{sequence_cnt};
    Y1 = ReadMultiFrames(filename,'qcif',[0,100]);
    
    Y = zeros(size(Y1));
    load([filename,'.key.mat']);
    Y(:,:,2:2:end) = Y1(:,:,2:2:end);
    Y(:,:,1:2:end) = Key_frames;     
    orig_frame = Y(:,:,n);
    imwrite(uint8(orig_frame),['...\nonkey_frames\','Recon_NonKeyF_',num2str(n),'.jpeg']);
    if n == 2
        [dec_frame, psnr_temp] = IntraCoding_BlockSPL(orig_frame, block_size, 0.7);
        Y(:,:,n) = dec_frame;
    else
        Ref1 = Y(:,:,n-2);
        Ref2 = Y(:,:,n-1);
        Ref4 = Y(:,:,n+1);
        Inter_frame = (Ref2 + Ref4) / 2;
        Yn_sub = orig_frame - Ref2;
        Ref_KeyFra = Ref2;
        Yn_sub_dct = dct2(Yn_sub);
        Yn_sub_column = reshape(Yn_sub_dct, column*line, 1);
        points_No_real = sum(abs(Yn_sub_column) > tao);
        energy_real = sum(Yn_sub_column' * Yn_sub_column);
        syms M
        M = solve(M == 2*current_estimate_points_No*log2(column*line/M));
        solM = round(eval(M));
        CS_result = (fai(1:solM,:)) * Yn_sub_column;
        CS_energy_obs = sum(CS_result.^2);
        Frame_sigma = CS_energy_obs/(column*line);     
        beita = sqrt(Frame_sigma/2); alpha = 0;
        lap_x2 = tao:0.1:255;
        lap_fx = 1/(2*beita) * exp(-abs(lap_x2-alpha)/beita);
        x_n2 = (column*line) * 2 * trapz(lap_fx);
        current_estimate_points_No = round(x_n2);
        syms Meas
        Meas = solve(Meas == 2*current_estimate_points_No*log2(column*line/Meas));
        solMeas = round(eval(Meas));
        first_subrate = solMeas/(column*line);
        syms Meas_Oracle
        Meas_Oracle = solve(Meas_Oracle == 2*points_No_real*log2(column*line/Meas_Oracle));
        solMeas_Oracle = round(eval(Meas_Oracle));        
        [SUM_Mlist, dec_frame, SI, subrate] = DISACOS_P_Wang(orig_frame, Ref1, Ref2, Ref_KeyFra, block_size, first_subrate, solMeas);
        W = W + 1;
        Y(:,:,n) = dec_frame;
        imshow(uint8(dec_frame));
        imwrite(uint8(Ref2), ['...Reconstructed_Frames\','Recon_NonKeyF_',num2str(n-1),'.jpeg']);
        imwrite(uint8(dec_frame), ['...\Reconstructed_Frames\','Recon_NonKeyF_',num2str(n),'.jpeg']);        
    end
end



