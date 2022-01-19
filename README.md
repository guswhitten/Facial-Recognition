# Facial-Recognition-System

att_faces.zip   ------->    AT&T database of 400 faces: 40 subjects, 10 photos each 

This project implements a software implementation of facial identifcation in MATLAB using the Discrete Cosine Transform (DCT) function with a k-nearest neightbor (kNN) classifier.

__Overview__
The database used for the experiment is the AT&T Laboratories face database (also known as the Olivetti Research Laboratory (ORL) face database). There are 400 images total, 10 of each subject. Each image of a subject is slightly different in some way, with variations in time of day, lighting, facial expressions, and facial details (i.e. glasses). All images were taken against a dark homogeneous background with the subjects in an upright, frontal position. The size of each PGM image is 112 x 92 pixels, with 256 grey levels per pixel.

__PART 1__
After reading the face database as well as the MATLAB functions into a MATLAB project, part 1 helps us become acquainted with the database through the following steps:
1. Read and plot the image
2. Find the 2-D DCT of the image.
3. Plot the 2-D DCT.
4. Find the inverse 2-D DCT to recover the original image and plot it.
The code to achieve this (substituting :

[img,map]=imread(‘face.pgm’);

imshow(img,map);

img2dct=dct2(img);

imshow(img2dct,map);

imgrecover=idct2(img2dct);

imshow(imgrecover,map);

To more clearly see the effect the 2-D DCT function has on the image, try the following code:

% Compute and plot log magnitude of 2-D DCT

t1=0.01.*abs(imgdct); 

t2=0.01*max(max(abs(imgdct)));

c_hat=255*(log10(1+t1)/log10(1+t2)); 

imshow(c_hat,map); 

title('Log Magnitude of 2-D DCT');


__PART 2__

