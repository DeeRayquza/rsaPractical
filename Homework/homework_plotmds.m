%%
function plotmds_homework(r)

% Run MDS
[Y,e] = cmdscale(r);

room1_vertical  = Y(1,1:3);
room2_vertical  = Y(2,1:3);
room3_vertical  = Y(3,1:3);
room4_vertical  = Y(4,1:3);
room1_horizontal  = Y(5,1:3);
room2_horizontal  = Y(6,1:3);
room3_horizontal  = Y(7,1:3);
room4_horizontal  = Y(8,1:3);


figure
plot3(room1_vertical(1),room1_vertical(2),room1_vertical(3),'bo','MarkerSize',2)
hold on
plot3(room2_vertical(1),room2_vertical(2),room2_vertical(3),'bo','MarkerSize',2)
plot3(room3_vertical(1),room3_vertical(2),room3_vertical(3),'bo','MarkerSize',2)
plot3(room4_vertical(1),room4_vertical(2),room4_vertical(3),'bo','MarkerSize',2)

text(room1_vertical(1),room1_vertical(2),room1_vertical(3),'  Room 1 Vertical','HorizontalAlignment','left','FontSize',16,'Color','b');
text(room2_vertical(1),room2_vertical(2),room2_vertical(3),'  Room 2 Vertical','HorizontalAlignment','left','FontSize',16,'Color','b');
text(room3_vertical(1),room3_vertical(2),room3_vertical(3),'  Room 3 Vertical','HorizontalAlignment','left','FontSize',16,'Color','b');
text(room4_vertical(1),room4_vertical(2),room4_vertical(3),'  Room 4 Vertical','HorizontalAlignment','left','FontSize',16,'Color','b');

plot3([room1_vertical(1),room2_vertical(1),room3_vertical(1),room4_vertical(1),room1_vertical(1)],[room1_vertical(2),room2_vertical(2),room3_vertical(2),room4_vertical(2),room1_vertical(2)],[room1_vertical(3),room2_vertical(3),room3_vertical(3),room4_vertical(3),room1_vertical(3)],'b-')

plot3(room1_horizontal(1),room1_horizontal(2),room1_horizontal(3),'ro','MarkerSize',2)
plot3(room2_horizontal(1),room2_horizontal(2),room2_horizontal(3),'ro','MarkerSize',2)
plot3(room3_horizontal(1),room3_horizontal(2),room3_horizontal(3),'ro','MarkerSize',2)
plot3(room4_horizontal(1),room4_horizontal(2),room4_horizontal(3),'ro','MarkerSize',2)

text(room1_horizontal(1),room1_horizontal(2),room1_horizontal(3),'  Room 1 Horizontal','HorizontalAlignment','left','FontSize',16,'Color','r');
text(room2_horizontal(1),room2_horizontal(2),room2_horizontal(3),'  Room 2 Horizontal','HorizontalAlignment','left','FontSize',16,'Color','r');
text(room3_horizontal(1),room3_horizontal(2),room3_horizontal(3),'  Room 3 Horizontal','HorizontalAlignment','left','FontSize',16,'Color','r');
text(room4_horizontal(1),room4_horizontal(2),room4_horizontal(3),'  Room 4 Horizontal','HorizontalAlignment','left','FontSize',16,'Color','r');

plot3([room1_horizontal(1),room2_horizontal(1),room3_horizontal(1),room4_horizontal(1),room1_horizontal(1)],[room1_horizontal(2),room2_horizontal(2),room3_horizontal(2),room4_horizontal(2),room1_horizontal(2)],[room1_horizontal(3),room2_horizontal(3),room3_horizontal(3),room4_horizontal(3),room1_horizontal(3)],'r-')

