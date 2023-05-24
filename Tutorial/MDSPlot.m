%% 
function MDSPlot(r)

% Run MDS
[Y,e] = cmdscale(r);

face_left   = Y(1,1:3);
face_center = Y(2,1:3);
face_right  = Y(3,1:3);
hand_left   = Y(4,1:3);
hand_center = Y(5,1:3);
hand_right  = Y(6,1:3);

figure
plot3(face_left(1),face_left(2),face_left(3),'bo','MarkerSize',2)
hold on
plot3(face_center(1),face_center(2),face_center(3),'bo','MarkerSize',2)
plot3(face_right(1),face_right(2),face_right(3),'bo','MarkerSize',2)

text(face_left(1),face_left(2),face_left(3),'  Face Left','HorizontalAlignment','left','FontSize',16,'Color','b');
text(face_center(1),face_center(2),face_center(3),'  Face Center','HorizontalAlignment','left','FontSize',16,'Color','b');
text(face_right(1),face_right(2),face_right(3),'  Face Right','HorizontalAlignment','left','FontSize',16,'Color','b');
plot3([face_left(1),face_center(1),face_right(1),face_left(1)],[face_left(2),face_center(2),face_right(2),face_left(2)],[face_left(3),face_center(3),face_right(3),face_left(3)],'b-')


plot3(hand_left(1),hand_left(2),hand_left(3),'ro','MarkerSize',2)
plot3(hand_center(1),hand_center(2),hand_center(3),'ro','MarkerSize',2)
plot3(hand_right(1),hand_right(2),hand_right(3),'ro','MarkerSize',2)

text(hand_left(1),hand_left(2),hand_left(3),'  Hand Left','HorizontalAlignment','left','FontSize',16,'Color','r');
text(hand_center(1),hand_center(2),hand_center(3),'  Hand Center','HorizontalAlignment','left','FontSize',16,'Color','r');
text(hand_right(1),hand_right(2),hand_right(3),'  Hand Right','HorizontalAlignment','left','FontSize',16,'Color','r');
plot3([hand_left(1),hand_center(1),hand_right(1),hand_left(1)],[hand_left(2),hand_center(2),hand_right(2),hand_left(2)],[hand_left(3),hand_center(3),hand_right(3),hand_left(3)],'r-')


