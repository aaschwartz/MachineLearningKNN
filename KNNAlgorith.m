%Aaron Schwartz
%ID: 000760622
%Project 2
close all;
clear all;
format compact;
clc;
% Input data
T= readtable('wdbc.data.mb.csv');
data=table2array(T);
k=input('Input k value: 1,3,5,7,9: ');
%k=3;
n=size(data(:,2)); n= n(1);
m=size(data(2,:)); m= m(2);
class = data(:,m);
%Normalize the Data
for i=1:m-1
    column = data(:,i);
    MIN = min(column);
    MAX = max(column);
    for j = i:n
        dataNorm(j) = ((column(j)- MIN)/(MAX - MIN));
    end
    Normalized(:,i) = dataNorm;
end

%Assign Test and Training Data
trainNum = round(.7*n);
testNum = round(.3*n);
index = randsample(1:length(Normalized),trainNum);
index = sort(index);
indexTest = 1:n;
for i=1:trainNum
    indexTest(indexTest == index(i)) = [];
    i=i+1;
end
testData = Normalized(indexTest,:);
trainData = Normalized(index,:);
classTrain= class(index,:);

for i = 1:length(trainData)
    distTrain(i,:)= norm(trainData(i,:));
end
for i = 1:length(testData)
    distTest(i,:)= norm(testData(i,:));
end
Training = [distTrain, classTrain];

A = repmat(distTrain,[1 length(distTest)]);
[minValue,closestIndex] = min(abs(A-(distTest')));
testMatch = closestIndex'; %Caluclate closest Neighbor for each test point
testMatch = index(testMatch);
testMatch = testMatch';

Max = max(distTrain);
Min= min(distTrain);
step = (Max-Min)/k;   
kRange = Min:step:Max;

%% Grouping Data

if k == 1
for j= 1:trainNum
    
   if distTrain(j) >= kRange(k) && distTrain(j) <= kRange(k+1)
     group(j,:) = index(j);
   else
       
   end
end
elseif k == 3
for j= 1:trainNum
    
   if distTrain(j) >= kRange(1) && distTrain(j) <= kRange(2)
     group1(j,:) = index(j);
     group1=nonzeros(group1);
   elseif distTrain(j) >= kRange(2) && distTrain(j) <= kRange(3)
     group2(j,:) = index(j);
     group2=nonzeros(group2);

   else 
     group3(j,:) = index(j);
     group3=nonzeros(group3);
   end
   
end
elseif k == 5
for j= 1:trainNum
    
   if distTrain(j) >= kRange(1) && distTrain(j) <= kRange(2)
     group1(j,:) = index(j);
     group1=nonzeros(group1);
   elseif distTrain(j) >= kRange(2) && distTrain(j) <= kRange(3)
     group2(j,:) = index(j);
     group2=nonzeros(group2);
   elseif distTrain(j) >= kRange(3) && distTrain(j) <= kRange(4)
     group3(j,:) = index(j);
     group3=nonzeros(group3);
   elseif distTrain(j) >= kRange(4) && distTrain(j) <= kRange(5)
     group4(j,:) = index(j);
     group4=nonzeros(group4);

   else 
     group5(j,:) = index(j);
     group5=nonzeros(group5);
   end
   
end

elseif k == 7
for j= 1:trainNum
    
   if distTrain(j) >= kRange(1) && distTrain(j) <= kRange(2)
     group1(j,:) = index(j);
     group1=nonzeros(group1);
   elseif distTrain(j) >= kRange(2) && distTrain(j) <= kRange(3)
     group2(j,:) = index(j);
     group2=nonzeros(group2);
   elseif distTrain(j) >= kRange(3) && distTrain(j) <= kRange(4)
     group3(j,:) = index(j);
     group3=nonzeros(group3);
   elseif distTrain(j) >= kRange(4) && distTrain(j) <= kRange(5)
     group4(j,:) = index(j);
     group4=nonzeros(group4);
   elseif distTrain(j) >= kRange(5) && distTrain(j) <= kRange(6)
     group5(j,:) = index(j);
     group5=nonzeros(group5);
   elseif distTrain(j) >= kRange(6) && distTrain(j) <= kRange(7)
     group6(j,:) = index(j);
     group6=nonzeros(group6);
   else 
     group7(j,:) = index(j);
     group7=nonzeros(group7);
   end
   
end
elseif k == 9
for j= 1:trainNum
    
   if distTrain(j) >= kRange(1) && distTrain(j) <= kRange(2)
     group1(j,:) = index(j);
     group1=nonzeros(group1);
   elseif distTrain(j) >= kRange(2) && distTrain(j) <= kRange(3)
     group2(j,:) = index(j);
     group2=nonzeros(group2);
   elseif distTrain(j) >= kRange(3) && distTrain(j) <= kRange(4)
     group3(j,:) = index(j);
     group3=nonzeros(group3);
   elseif distTrain(j) >= kRange(4) && distTrain(j) <= kRange(5)
     group4(j,:) = index(j);
     group4=nonzeros(group4);
   elseif distTrain(j) >= kRange(5) && distTrain(j) <= kRange(6)
     group5(j,:) = index(j);
     group5=nonzeros(group5);
   elseif distTrain(j) >= kRange(6) && distTrain(j) <= kRange(7)
     group6(j,:) = index(j);
     group6=nonzeros(group6);
   elseif distTrain(j) >= kRange(7) && distTrain(j) <= kRange(8)
     group7(j,:) = index(j);
     group7=nonzeros(group7);
   elseif distTrain(j) >= kRange(8) && distTrain(j) <= kRange(9)
     group8(j,:) = index(j);
     group8=nonzeros(group8);
   else 
     group9(j,:) = index(j);
     group9=nonzeros(group9);
   end
   
end
else
end

%% Classifying each Group

if  k == 1
    for i=1:length(group)
 
        grouping(i)=class(group(i));
        classification = mode(grouping);
    end

elseif  k == 3
    for j = 1:k
        if j == 1
         for i=1:length(group1)
 
        grouping1(i)=class(group1(i));
        classification1 = mode(grouping1);
         end
        else if j == 2
          for i=1:length(group2)
 
        grouping2(i)=class(group2(i));
        classification2 = mode(grouping2);
          end
        else
        for i=1:length(group3)
 
        grouping3(i)=class(group3(i));
        classification3 = mode(grouping3);
        end
            
        end
        end
    end
    

    
elseif  k == 5
    for j = 1:k
        if j == 1
         for i=1:length(group1)
 
        grouping1(i)=class(group1(i));
        classification1 = mode(grouping1);
         end
        else if j == 2
          for i=1:length(group2)
 
        grouping2(i)=class(group2(i));
        classification2 = mode(grouping2);
          end
                  else if j == 3
          for i=1:length(group3)
 
        grouping3(i)=class(group3(i));
        classification3 = mode(grouping3);
          end
                  else if j == 4
          for i=1:length(group4)
 
        grouping4(i)=class(group4(i));
        classification4 = mode(grouping4);
          end
        else
        for i=1:length(group5)
 
        grouping5(i)=class(group5(i));
        classification5 = mode(grouping5);
        end
        end
        end
        end
        end
    end
    
    
    
elseif  k == 7
    for j = 1:k
        if j == 1
         for i=1:length(group1)
 
        grouping1(i)=class(group1(i));
        classification1 = mode(grouping1);
         end
        else if j == 2
          for i=1:length(group2)
 
        grouping2(i)=class(group2(i));
        classification2 = mode(grouping2);
          end
                  else if j == 3
          for i=1:length(group3)
 
        grouping3(i)=class(group3(i));
        classification3 = mode(grouping3);
          end
                  else if j == 4
          for i=1:length(group4)
 
        grouping4(i)=class(group4(i));
        classification4 = mode(grouping4);
          end
          
          else if j == 5
          for i=1:length(group5)
 
        grouping5(i)=class(group5(i));
        classification5 = mode(grouping5);
          end
          else if j == 6
          for i=1:length(group6)
 
        grouping6(i)=class(group6(i));
        classification6 = mode(grouping6);
          end
        else
        for i=1:length(group7)
 
        grouping7(i)=class(group7(i));
        classification7 = mode(grouping7);
        end
        end
        end
        end
        end
        end
        
    end
    end    
    
    elseif  k == 9
    for j = 1:k
        if j == 1
         for i=1:length(group1)
 
        grouping1(i)=class(group1(i));
        classification1 = mode(grouping1);
         end
        else if j == 2
          for i=1:length(group2)
 
        grouping2(i)=class(group2(i));
        classification2 = mode(grouping2);
          end
                  else if j == 3
          for i=1:length(group3)
 
        grouping3(i)=class(group3(i));
        classification3 = mode(grouping3);
          end
                  else if j == 4
          for i=1:length(group4)
 
        grouping4(i)=class(group4(i));
        classification4 = mode(grouping4);
          end
          
          else if j == 5
          for i=1:length(group5)
 
        grouping5(i)=class(group5(i));
        classification5 = mode(grouping5);
          end
          else if j == 6
          for i=1:length(group6)
 
        grouping6(i)=class(group6(i));
        classification6 = mode(grouping6);
          end
           else if j == 7
          for i=1:length(group7)
 
        grouping7(i)=class(group7(i));
        classification7 = mode(grouping7);
          end
           else if j == 8
          for i=1:length(group8)
 
        grouping8(i)=class(group8(i));
        classification8 = mode(grouping8);
          end
        else
        for i=1:length(group9)
 
        grouping9(i)=class(group9(i));
        classification9 = mode(grouping9);
        end
        end
        end
        end
        end
        end
        end
    end
    end
    end        
else
end



%% Matching Test Data to Groups


if k == 1
    for j=1:length(distTest)
         if distTest(j) >= kRange(1) && distTest(j) <= kRange(2)
            MGroup(j,:) = indexTest(j);
   else
       
         end
    end
    
elseif k == 3
for j= 1:length(distTest)
    
   if distTest(j) >= kRange(1) && distTest(j) <= kRange(2)
     Mgroup1(j,:) = indexTest(j);
     Mgroup1=nonzeros(Mgroup1);
   elseif distTest(j) >= kRange(2) && distTest(j) <= kRange(3)
     Mgroup2(j,:) = indexTest(j);
     Mgroup2=nonzeros(Mgroup2);

   else 
     Mgroup3(j,:) = indexTest(j);
     Mgroup3=nonzeros(Mgroup3);
   end
   
end

elseif k == 5
for j= 1:length(distTest)
    
   if distTest(j) >= kRange(1) && distTest(j) <= kRange(2)
     Mgroup1(j,:) = indexTest(j);
     Mgroup1=nonzeros(Mgroup1);
   elseif distTest(j) >= kRange(2) && distTest(j) <= kRange(3)
     Mgroup2(j,:) = indexTest(j);
     Mgroup2=nonzeros(Mgroup2);
   elseif distTest(j) >= kRange(3) && distTest(j) <= kRange(4)
     Mgroup3(j,:) = indexTest(j);
     Mgroup3=nonzeros(Mgroup3);
   elseif distTest(j) >= kRange(4) && distTest(j) <= kRange(5)
     Mgroup4(j,:) = indexTest(j);
     Mgroup4=nonzeros(Mgroup4);

   else 
     Mgroup5(j,:) = indexTest(j);
     Mgroup5=nonzeros(Mgroup5);
   end
end
elseif k == 7
for j= 1:length(distTest)
    
   if distTest(j) >= kRange(1) && distTest(j) <= kRange(2)
     Mgroup1(j,:) = indexTest(j);
     Mgroup1=nonzeros(Mgroup1);
   elseif distTest(j) >= kRange(2) && distTest(j) <= kRange(3)
     Mgroup2(j,:) = indexTest(j);
     Mgroup2=nonzeros(Mgroup2);
   elseif distTest(j) >= kRange(3) && distTest(j) <= kRange(4)
     Mgroup3(j,:) = indexTest(j);
     Mgroup3=nonzeros(Mgroup3);
   elseif distTest(j) >= kRange(4) && distTest(j) <= kRange(5)
     Mgroup4(j,:) = indexTest(j);
     Mgroup4=nonzeros(Mgroup4);
   elseif distTest(j) >= kRange(5) && distTest(j) <= kRange(6)
     Mgroup5(j,:) = indexTest(j);
     Mgroup5=nonzeros(Mgroup5);
   elseif distTest(j) >= kRange(6) && distTest(j) <= kRange(7)
     Mgroup6(j,:) = indexTest(j);
     Mgroup6=nonzeros(Mgroup6);
   else 
     Mgroup7(j,:) = indexTest(j);
     Mgroup7=nonzeros(Mgroup7);
   end
end
elseif k == 9
for j= 1:length(distTest)
    
   if distTest(j) >= kRange(1) && distTest(j) <= kRange(2)
     Mgroup1(j,:) = indexTest(j);
     Mgroup1=nonzeros(Mgroup1);
   elseif distTest(j) >= kRange(2) && distTest(j) <= kRange(3)
     Mgroup2(j,:) = indexTest(j);
     Mgroup2=nonzeros(Mgroup2);
   elseif distTest(j) >= kRange(3) && distTest(j) <= kRange(4)
     Mgroup3(j,:) = indexTest(j);
     Mgroup3=nonzeros(Mgroup3);
   elseif distTest(j) >= kRange(4) && distTest(j) <= kRange(5)
     Mgroup4(j,:) = indexTest(j);
     Mgroup4=nonzeros(Mgroup4);
   elseif distTest(j) >= kRange(5) && distTest(j) <= kRange(6)
     Mgroup5(j,:) = indexTest(j);
     Mgroup5=nonzeros(Mgroup5);
   elseif distTest(j) >= kRange(6) && distTest(j) <= kRange(7)
     Mgroup6(j,:) = indexTest(j);
     Mgroup6=nonzeros(Mgroup6);
   elseif distTest(j) >= kRange(7) && distTest(j) <= kRange(8)
     Mgroup7(j,:) = indexTest(j);
     Mgroup7=nonzeros(Mgroup7);
   elseif distTest(j) >= kRange(8) && distTest(j) <= kRange(9)
     Mgroup8(j,:) = indexTest(j);
     Mgroup8=nonzeros(Mgroup8);
   else 
     Mgroup9(j,:) = indexTest(j);
     Mgroup9=nonzeros(Mgroup9);
     
   end
end
else
end

%% Classifying Test Data

if k == 1
    for i = 1:length(MGroup)
        V = (zeros(length(1),length(MGroup))+classification)';
        FinalClass(:,1) = MGroup;
        FinalClass(:,2) = V;
    end
end

if k ==3 
    for j=1:k
        if j==1
    for i = 1:length(Mgroup1)
        V = (zeros(length(1),length(Mgroup1))+classification1)';
        FinalClass1(:,1) = Mgroup1;
        FinalClass1(:,2) = V;
    end
        
        elseif j==2
    for i = 1:length(Mgroup2)
        V = (zeros(length(1),length(Mgroup2))+classification2)';
        FinalClass2(:,1) = Mgroup2;
        FinalClass2(:,2) = V;
    end
            
            else
    for i = 1:length(Mgroup3)
        V = (zeros(length(1),length(Mgroup3))+classification3)';
        FinalClass3(:,1) = Mgroup3;
        FinalClass3(:,2) = V;
    end
    end
    end
    FinalClass = [FinalClass1;FinalClass2;FinalClass3];
    FinalClass = sortrows(FinalClass);
end

if k ==5 
    for j=1:k
        if j==1
    for i = 1:length(Mgroup1)
        V = (zeros(length(1),length(Mgroup1))+classification1)';
        FinalClass1(:,1) = Mgroup1;
        FinalClass1(:,2) = V;
    end
        
        elseif j==2
    for i = 1:length(Mgroup2)
        V = (zeros(length(1),length(Mgroup2))+classification2)';
        FinalClass2(:,1) = Mgroup2;
        FinalClass2(:,2) = V;
    end
            
        elseif j ==3
    for i = 1:length(Mgroup3)
        V = (zeros(length(1),length(Mgroup3))+classification3)';
        FinalClass3(:,1) = Mgroup3;
        FinalClass3(:,2) = V;
    end
        elseif j ==4
    for i = 1:length(Mgroup4)
        V = (zeros(length(1),length(Mgroup4))+classification4)';
        FinalClass4(:,1) = Mgroup4;
        FinalClass4(:,2) = V;
    end
        else
    for i = 1:length(Mgroup5)
        V = (zeros(length(1),length(Mgroup5))+classification5)';
        FinalClass5(:,1) = Mgroup5;
        FinalClass5(:,2) = V;
   
    end
    end
    end
    FinalClass = [FinalClass1;FinalClass2;FinalClass3;FinalClass4;FinalClass5];
    FinalClass = sortrows(FinalClass);
end


if k ==7
    for j=1:k
        if j==1
    for i = 1:length(Mgroup1)
        V = (zeros(length(1),length(Mgroup1))+classification1)';
        FinalClass1(:,1) = Mgroup1;
        FinalClass1(:,2) = V;
    end
        
        elseif j==2
    for i = 1:length(Mgroup2)
        V = (zeros(length(1),length(Mgroup2))+classification2)';
        FinalClass2(:,1) = Mgroup2;
        FinalClass2(:,2) = V;
    end
            
        elseif j ==3
    for i = 1:length(Mgroup3)
        V = (zeros(length(1),length(Mgroup3))+classification3)';
        FinalClass3(:,1) = Mgroup3;
        FinalClass3(:,2) = V;
    end
        elseif j ==4
    for i = 1:length(Mgroup4)
        V = (zeros(length(1),length(Mgroup4))+classification4)';
        FinalClass4(:,1) = Mgroup4;
        FinalClass4(:,2) = V;
    end
            elseif j ==5
    for i = 1:length(Mgroup5)
        V = (zeros(length(1),length(Mgroup5))+classification5)';
        FinalClass5(:,1) = Mgroup5;
        FinalClass5(:,2) = V;
    end
            elseif j ==6
    for i = 1:length(Mgroup6)
        V = (zeros(length(1),length(Mgroup6))+classification6)';
        FinalClass6(:,1) = Mgroup6;
        FinalClass6(:,2) = V;
    end
        else
    for i = 1:length(Mgroup7)
        V = (zeros(length(1),length(Mgroup7))+classification7)';
        FinalClass7(:,1) = Mgroup7;
        FinalClass7(:,2) = V;
   
    end
    end
    end
    FinalClass = [FinalClass1;FinalClass2;FinalClass3;FinalClass4;FinalClass5;FinalClass6;FinalClass7];
    FinalClass = sortrows(FinalClass);
end

if k ==9
    for j=1:k
        if j==1
    for i = 1:length(Mgroup1)
        V = (zeros(length(1),length(Mgroup1))+classification1)';
        FinalClass1(:,1) = Mgroup1;
        FinalClass1(:,2) = V;
    end
        
        elseif j==2
    for i = 1:length(Mgroup2)
        V = (zeros(length(1),length(Mgroup2))+classification2)';
        FinalClass2(:,1) = Mgroup2;
        FinalClass2(:,2) = V;
    end
            
        elseif j ==3
    for i = 1:length(Mgroup3)
        V = (zeros(length(1),length(Mgroup3))+classification3)';
        FinalClass3(:,1) = Mgroup3;
        FinalClass3(:,2) = V;
    end
        elseif j ==4
    for i = 1:length(Mgroup4)
        V = (zeros(length(1),length(Mgroup4))+classification4)';
        FinalClass4(:,1) = Mgroup4;
        FinalClass4(:,2) = V;
    end
            elseif j ==5
    for i = 1:length(Mgroup5)
        V = (zeros(length(1),length(Mgroup5))+classification5)';
        FinalClass5(:,1) = Mgroup5;
        FinalClass5(:,2) = V;
    end
            elseif j ==6
    for i = 1:length(Mgroup6)
        V = (zeros(length(1),length(Mgroup6))+classification6)';
        FinalClass6(:,1) = Mgroup6;
        FinalClass6(:,2) = V;
    end
            elseif j ==7
    for i = 1:length(Mgroup7)
        V = (zeros(length(1),length(Mgroup7))+classification7)';
        FinalClass7(:,1) = Mgroup7;
        FinalClass7(:,2) = V;
    end
            elseif j ==8
    for i = 1:length(Mgroup8)
        V = (zeros(length(1),length(Mgroup8))+classification8)';
        FinalClass8(:,1) = Mgroup8;
        FinalClass8(:,2) = V;
    end
        else
    for i = 1:length(Mgroup9)
        V = (zeros(length(1),length(Mgroup9))+classification9)';
        FinalClass9(:,1) = Mgroup9;
        FinalClass9(:,2) = V;
   
    end
    end
    end
    FinalClass = [FinalClass1;FinalClass2;FinalClass3;FinalClass4;FinalClass5;FinalClass6;FinalClass7;FinalClass8;FinalClass9];
    FinalClass = sortrows(FinalClass);
end


%% Accuracy and Confusion Matrix

classTest = class(indexTest,:);
OrganizeTest = [indexTest' classTest];
OrganizeTrain = [index' classTrain];
array = (1:n)';
OrganizeData = [array class];
TP=0;
TN=0;
FP=0;
FN=0;
for i =1:testNum
    if FinalClass(i,2) == OrganizeTest(i,2) && FinalClass(i,2) == 1
        TP = TP+1;
    else if FinalClass(i,2) == OrganizeTest(i,2) && FinalClass(i,2) == -1
            TN = TN +1;
    else if FinalClass(i,2) ~= OrganizeTest(i,2) && FinalClass(i,2) == 1
            FP = FP +1;
    else if FinalClass(i,2) ~= OrganizeTest(i,2) && FinalClass(i,2) == -1
            FN = FN +1;
            else
            end
        
        end
        end
    end
end
Total = FN+FP+TP+TN;
Positive=TP+FN;
Negative=TN+FP;
ErrorRate = ((FP + FN)/(Total))
Accuracy = 1-ErrorRate
Sensitivity = TP/Positive
Specifity = TN/Negative
Precision = TP/(TP+FP)
FPRate = FP/(Negative)


            
            
            