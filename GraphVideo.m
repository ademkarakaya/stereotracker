coords = readmatrix('D:\Users\Adem Ahmet Karakaya\Desktop\CAPSTONE\Presentation\coords.csv');

x = coords(1,:);
y = coords(2,:);

v = VideoWriter('graphvideo.avi');

open(v);

figure(1)
ax = gca;

for k = 1:1:length(coords)

    p = scatter(coords(1,k),coords(2,k),20,'filled'); 
    xlim([-800 800]);
    ylim([-1345 1345]);
    ax.XAxisLocation = 'origin'; 
    ax.YAxisLocation = 'origin'; 
    frame = getframe(ax);
    writeVideo(v,frame);
    
end