%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function  [identity_true,identity_guess,success_rate]=knn_classifier(k_value)
% Name: knn_classifier
% Input: k_value - Choose k = 1, 3, 5, or 7
%       -Represents the number of nearest neighbors the program takes into account
%        when making its "guess" for which is the true identity of the image

% Output: 
%       identity_true - true identity of each test image
%       identity_guess - identity determined by kNN classifier
%       success_rate - identification success rate 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [identity_true,identity_guess,success_rate] = knn_classifier(k_value)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% 
load raw_data.mat trclass trdata_raw dct_coef;

right=0;
identity_guess=zeros(200,1); %200x1 array to hold guesses
identity_true=trclass;     
range=1:40;

tedata_raw=[]; 

% Loop through all subjects (i) and last five images of each (j)
for i=1:40
    for j=6:10
        file = ['C:\Users\YOUR_NAME_HERE\Documents\MATLAB\project\s'...
            num2str(range(i)) '\' num2str(j) '.pgm'];
        feat(j-5,:)=findfeatures(file,dct_coef);          %add images 6-10 of each subject to feat
    end
    tedata_raw=[tedata_raw feat(1:5,:)'];           %append feat to raw test data
end
tedata_raw=tedata_raw'; %convert test data from 70x200 to 200x70 matrix

for i=1:200             %loop thru every test image
    dist=zeros(200,1);  %200x1 vector to hold Euclid dist to each train image
    for j=1:200         %loop thru every training image for ith test image
        score=zeros(1,dct_coef);
        for k=1:dct_coef      %loop thru every index of each vector
            tem=tedata_raw(i,k)-trdata_raw(j,k);
            score(k)=tem.^2;
        end
        dist(j)=sqrt(sum(score)); %take magnitude of the comparison
    end %after this, dist filled w/ comparison magnitudes to each training image
    guess=zeros(1,k_value); %
    for k=1:k_value   %fill guess array with nearest neighbors
        [M,I]=min(dist); %I is index of kth closest neighbor
        guess(k)=identity_true(I); %place neighbor in guess array
        dist(I)=[];       %delete closest neighbor from dist
    end %after this, guess is filled with indices of supposed matches
    if k_value==1
        identity_guess(i)=guess(1);
    end
    if k_value==3
        if guess(2)~=guess(3)
            identity_guess(i)=guess(1);
        else
            identity_guess(i)=guess(2);
        end
    end
    if k_value==5
        s=size(unique(guess),2);   %s is # of unique values in guess
        if 5-s==0                  %all 5 values diff, so pos 1 wins
            identity_guess(i)=guess(1);
        elseif 5-s==1               %1 value shows up twice, so mode wins
            identity_guess(i)=mode(guess);
        elseif 5-s==2               %2 values show up twice, so:
            u=unique(guess);
            avg=[];
            for p=1:3
                cleaver=size(find(guess==u(p)),2);
                if cleaver==1
                    avg=[avg 100];
                else
                    avg=[avg mean(find(guess==u(p)))];
                end
            end %after this, 
            [K,J]=min(avg); %J is index of smallest avg
            identity_guess(i)=u(J);
        else
            identity_guess(i)=mode(guess);
        end
    end
    if k_value==7
        [uGuess,ia,ic]=unique(guess, 'stable');
        tally=accumarray(ic,1); %vert array of frequencies of each value
        if max(tally)==1 %all 7 values unique
            identity_guess(i)=guess(1);
        end
        if max(tally)>3 %a value shows up 4 or more times
            identity_guess(i)=mode(guess);
        end
        if max(tally)==2   %at least 1 value showed up twice
           if nnz(tally==2)==1      %only 1 value showed up twice
               identity_guess(i)=mode(guess);
           end
           if nnz(tally==2)>1      %more than 1 value showed up twice
               identity_guess(i)=uGuess(1);
           end
        end
        if max(tally)==3   %at least 1 value showed up thrice
           if nnz(tally==3)==1      %only 1 value showed up thrice
               identity_guess(i)=mode(guess);
           end
           if nnz(tally==3)>1      %more than 1 value showed up thrice
               identity_guess(i)=uGuess(1);
           end
        end
%         s=size(unique(guess),2);   %s is # of unique values in guess
%         if 7-s==0                  %all 7 values diff, so pos 1 wins
%             identity_guess(i)=guess(1);
%         elseif 7-s==1               %1 value shows up twice, so mode wins
%             identity_guess(i)=mode(guess);
%         elseif 7-s==2               %2 values show up twice, so:
%             u=unique(guess);
%             avg=[];
%             for p=1:3
%                 cleaver=size(find(guess==u(p)),2);
%                 if cleaver==1
%                     avg=[avg 100];
%                 else
%                     avg=[avg mean(find(guess==u(p)))];
%                 end
%             end %after this, 
%             [K,J]=min(avg); %J is index of smallest avg
%             identity_guess(i)=u(J);
%         else
%             identity_guess(i)=mode(guess);
%         end
    end
    
    if identity_guess(i) == identity_true(i)
        right=right+1;
    end
end %after this, identity_guess is 200x1 vector of values between 1 and 40
%right holds number of matches to actual image (identity_true)

success_rate=(right/200)*100; %percent of faces correctly identified

table=[identity_true identity_guess];
%disp(table);
disp(success_rate);

end
