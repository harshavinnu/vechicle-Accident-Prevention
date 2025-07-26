a=imread(uigetfile('.jpg'));  % Read an image file using the UI file picker dialog box.
a=rgb2gray(a);  % Convert the color image to grayscale.
figure;imshow(a);title('car');  % Display the grayscale image and title it "car".
[r, c , ~]=size(a);  % Get the size of the grayscale image (rows, columns, and planes).
b=a(r/3:r,1:c);  % Crop the lower third portion of the grayscale image.
imshow(b);title('LP AREA')  % Display the cropped image and title it "LP AREA".
[r, c, p]=size(b);  % Get the size of the cropped image.
Out=zeros(r,c);  % Create a matrix of zeros with the same size as the cropped image.
for i=1:r  % Loop through each row of the cropped image.
    for j=1:c  % Loop through each column of the cropped image.
        if b(i,j)>150  % If the pixel value is greater than 150, set the corresponding value in the Out matrix to 1.
            Out(i,j)=1;
        else  % Otherwise, set the corresponding value in the Out matrix to 0.
            Out(i,j)=0;
        end
    end
end
BW3 = bwfill(Out,'holes');  % Fill any holes in the binary image.
BW3=medfilt2(BW3,[4 4]);  % Apply a 4x4 median filter to the binary image.
BW3=medfilt2(BW3,[4 4]);  % Apply the median filter again.
BW3=medfilt2(BW3,[4 4]);  % Apply the median filter again.
BW3=medfilt2(BW3,[5 5]);  % Apply a 5x5 median filter to the binary image.
BW3=medfilt2(BW3,[5 5]);  % Apply the median filter again.
figure;imshow(BW3,[]);  % Display the binary image after processing.
BW3 = bwfill(BW3,'holes');  % Fill any holes in the binary image again.
[L, num]=bwlabel(BW3);  % Label connected components in the binary image and count the number of objects.
STATS=regionprops(L,'all');  % Compute various properties of the labeled objects.
disp(num);  % Display the number of objects found.
cc=[];  % Create an empty array to store object areas.
removed=0;  % Initialize the count of removed objects to zero.
for i=1:num  % Loop through each object.
    dd=STATS(i).Area;  % Get the area of the current object.
    cc(i)=dd;  % Store the area of the current object in the cc array.
    if (dd < 50000)  % If the area of the current object is less than 50000, remove it.
        L(L==i)=0;  % Set the corresponding values in the labeled image to 0.
        removed = removed + 1;  % Increment the count of removed objects.
        num=num-1;  % Decrement the count of objects.
    end
end
[L2, num2]=bwlabel(L);  % Label connected components in the updated binary image and count the number of objects.
figure,imshow(L2);  % Display the updated labeled image.
STATS = regionprops(L2,'All');  % Compute various properties of the updated labeled objects.
if num2>2  % if there are more than two regions identified in the image
     for i=1:num2    % loop through each identified region
	aa=  STATS(i).Orientation;   % get the orientation of the current region
	if aa > 0   % if the orientation of the current region is greater than zero

	imshow(L==i);   % display the region using the L matrix

	end  % end the if statement
     end  % end the for loop
	disp('exit');  % display the message 'exit'
end  % end the if statement
 [r, c]=size(L2);  % get the size of the L2 matrix and assign the values to r and c
Out=zeros(r,c);  % create a matrix of zeros with the size of r and c and assign it to Out
k=1;  % assign 1 to k
 B=STATS.BoundingBox;  % get the bounding box coordinates of each region and assign it to B
Xmin=B(2);  % get the minimum x-coordinate of the bounding box and assign it to Xmin
Xmax=B(2)+B(4);  % get the maximum x-coordinate of the bounding box and assign it to Xmax
Ymin=B(1);  % get the minimum y-coordinate of the bounding box and assign it to Ymin
Ymax=B(1)+B(3);  % get the maximum y-coordinate of the bounding box and assign it to Ymax
LP=[];  % create an empty matrix and assign it to LP
LP=b(Xmin+25:Xmax-20,Ymin+10:Ymax-10);  % get a cropped image of the license plate from the original image and assign it to LP
figure,imshow(LP,[]);  % display the license plate image

