# Facial-Recognition-System

***NOTE*** The Image Processing Toolbox provided by MATLAB will need to be downloaded to complete the entirety of this experiment. 


att_faces.zip   ------->    AT&T database of 400 faces: 40 subjects, 10 photos each 

This project implements a software implementation of facial identifcation in MATLAB using the Discrete Cosine Transform (DCT) function with a k-nearest neightbor (kNN) classifier.

__Overview__
The database used for the experiment is the AT&T Laboratories face database (also known as the Olivetti Research Laboratory (ORL) face database). There are 400 images total, 10 of each subject. Each image of a subject is slightly different in some way, with variations in time of day, lighting, facial expressions, and facial details (i.e. glasses). All images were taken against a dark homogeneous background with the subjects in an upright, frontal position. The size of each PGM image is 112 x 92 pixels, with 256 grey levels per pixel.


__PART 1__

After reading the face database as well as the MATLAB functions into a MATLAB project, part 1 helps us become acquainted with the database through the following steps:

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

Use the findfeatures.m function to convert the 2-D image into a 1-D "feature" vector. The second parameter of findfeatures.m allows the user to choose the feature length. This part is just to become more familiar with the process.
Try the following code:
imshow(findfeatures('s5/1.pgm', 50));



__PART 3__

The system is trained on the first five images of each subject using the function face_recog_knn_train.m. The two parameters allow the user to train the system on any number of the subjects (though it must start with subject 1) with the max of [1 40], and any DCT coeffecient. 
Try the following code:

face_recog_knn_train([1 40], 50);

The variable 'ans' in the Workspace tab should then be filled with a 2-D array, 200x50, of the resultant feature vectors.



__PART 4__

Use the knn_classifier.m function to test the system's effectiveness. Note that the only valid k-value inputs are 1, 3, 5, and 7. The output is the percentage of the images  guessed correctly based on the system's training. Keep in mind that if different length feature vectors are to be tested, the system must be re-trained (as in Part 3) and then knn_classifier.m can be tested again.










