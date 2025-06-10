
% 设置视频文件名和属性
outputVideoFile = 'D:\file for phd\CS_DCVS\(paper_4_CSfor_graduate)code\Reconstructed_Videos\outputVideo.mp4'; % 视频文件名
desiredFrameRate = 30; % 所需视频帧率
outputVideo = VideoWriter(outputVideoFile, 'MPEG-4');
outputVideo.FrameRate = desiredFrameRate;

% 打开VideoWriter对象以准备写入
open(outputVideo);

% 读取图片文件列表并按字典顺序排序
imageFolder = 'D:\file for phd\CS_DCVS\(paper_4_CSfor_graduate)code\Reconstructed_Frames\'; % 存储生成图片的文件夹
imageFiles = dir(fullfile(imageFolder, '*.jpeg')); % 根据需要的图片格式更改此处
[~, sortedIndices] = sort([imageFiles.datenum]);

% 遍历排序后的图片文件列表
for i = 3:numel(imageFiles)
    % 读取图片
    img = imread(fullfile(imageFolder, imageFiles(sortedIndices(i)).name));
    
    % 写入当前帧到视频中
    writeVideo(outputVideo, img);
end

% 关闭VideoWriter对象
close(outputVideo);

disp('视频生成完成');





