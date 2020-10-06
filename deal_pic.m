%% 画红框的函数
%% (x1,y1)为左上角坐标，(x2,y2)为右下角坐标，坐标用MATLAB自带的imtool可以获取
%% path为要处理的图片的名字
%% 示例：deal_pic(465,188,580,264,'22TIP.jpg')
function result = deal_pic(x1,y1,x2,y2,I,flag)
% I = imread(path);
imshow(I);
[H W D] = size(I);

dist = I(y1:y2,x1:x2,:);
dist1 = imresize(dist,[round(size(dist,1)*1.5),round(size(dist,2)*1.5)]);
if flag
    I((1:size(dist1,1)),(W-size(dist1,2)+1):W,:) = dist1;
else
    I((H-size(dist1,1)+1):H,(W-size(dist1,2)+1):W) = dist1;
end
imshow(I);
h = rectangle('position',[x1,y1,x2-x1,y2-y1],'LineWidth',4,'edgecolor','r');
if flag
    h2 = rectangle('position',[W-size(dist1,2)+1,1,size(dist1,2)-1,(size(dist1,1))],'LineWidth',4,'edgecolor','r');
else
    h2 = rectangle('position',[W-size(dist1,2)+1,H-size(dist1,1)+1,size(dist1,2)-1,(size(dist1,1)-1)],'LineWidth',4,'edgecolor','r');
end
frame=getframe(gcf);
result=frame2im(frame);

for i = 1:size(result,1)
    if(result(i,round(W/2),1)~=240||result(i,round(W/2),2)~=240||result(i,round(W/2),3)~=240)
        top = i;
        break
    end
end
for i = size(result,1):-1:1
    if(result(i,round(W/2),1)~=240||result(i,round(W/2),2)~=240||result(i,round(W/2),3)~=240)
        bottom = i;
        break
    end
end
for i = size(result,2):-1:1
    if(result(round(H/2),i,1)~=240||result(round(H/2),i,2)~=240||result(round(H/2),i,3)~=240)&&(result(round(H/2),i+1,1)==240||result(round(H/2),i+1,2)==240||result(round(H/2),i+1,3)==240)
        right = i;
        break
    end
end
for i = 1:size(result,2)
    if(result(round(H/2),i,1)~=240||result(round(H/2),i,2)~=240||result(round(H/2),i,3)~=240)&&(result(round(H/2),i-1,1)==240||result(round(H/2),i-1,2)==240||result(round(H/2),i-1,3)==240)
        left = i;
        break
    end
end

result = result(top:bottom,left:right,:);
% imwrite(result,cat(2,'dealt/',path));
end
