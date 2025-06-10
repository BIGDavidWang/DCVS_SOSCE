
% ������Ƶ�ļ���������
outputVideoFile = 'D:\file for phd\CS_DCVS\(paper_4_CSfor_graduate)code\Reconstructed_Videos\outputVideo.mp4'; % ��Ƶ�ļ���
desiredFrameRate = 30; % ������Ƶ֡��
outputVideo = VideoWriter(outputVideoFile, 'MPEG-4');
outputVideo.FrameRate = desiredFrameRate;

% ��VideoWriter������׼��д��
open(outputVideo);

% ��ȡͼƬ�ļ��б����ֵ�˳������
imageFolder = 'D:\file for phd\CS_DCVS\(paper_4_CSfor_graduate)code\Reconstructed_Frames\'; % �洢����ͼƬ���ļ���
imageFiles = dir(fullfile(imageFolder, '*.jpeg')); % ������Ҫ��ͼƬ��ʽ���Ĵ˴�
[~, sortedIndices] = sort([imageFiles.datenum]);

% ����������ͼƬ�ļ��б�
for i = 3:numel(imageFiles)
    % ��ȡͼƬ
    img = imread(fullfile(imageFolder, imageFiles(sortedIndices(i)).name));
    
    % д�뵱ǰ֡����Ƶ��
    writeVideo(outputVideo, img);
end

% �ر�VideoWriter����
close(outputVideo);

disp('��Ƶ�������');





