Variables in "tidy_dataset.txt"
===============================

#### The "tidy_dataset.txt" consist in a set of 10299 observations (7339 from the train data set and 2947 from the test data set) and 67 variables, the first one refering to the type of activity and the other ones refering to the measurements of the accelerometer of the Samsung.

#### The first variable of the data set is"activity". This variable referes to the kind of activity the subject was doing when the data was recorded. It is a factor variable that takes 6 values:

1. "LAYING"
  
2. "SITTING"
  
3. "STANDING"
  
4. "WALKING"
  
5. "WALKING_DOWNSTAIRS"
  
6. "WALKING_UPSTAIRS"

#### Of this 66 variables, half of then are the mean of the corresponding measurement and the other half are the standard deviation of the same measurements, so we are going to explain half of them.

#### The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

#### Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. 

#### Finally a Fast Fourier Transform (FFT) was applied to some of these signals. 

#### For this set of features, mean and standard deviation was performed. The name of 33 of these measurements corresponding to the mean value start with "mean" and the 33 of them corresponding to the standart deviation starts with "std".

#### After that "mean" or "std" characters, the name of the measurements corresponding to the magnitude of features includes "magnitude" (i.e., "meanmagnitude" or "stdmagnitude")

#### After that "magnitude" characters (if it is the case), "jerk" appears in the name of the variables which the Jerk signal was derive from (for instance, "meanmagnitudejerk" or "stdjerk")

#### Once specifyed "magnitude" and "jerk" (when necessary), all variables names follow the same structure:

1. "time" for the measurements referring to time (as it was obtained by the accelerometer) and "fourier" for the Fast Fourier Transform of the measurement.

2. "body" refering to the measurement of the subject and gravity refering to the measurement related to the gravity acceleration of the Earth.

3. "acceleration" if the measuremente was the instant acceleration or "angular" if it was the angular velocity.

#### The variables that are not magnitudes, are refering to one of the3-axial signals in the X, Y and Z directions. In these cases, the corresponding letter is added at the end of the name. 

#### Below the names of 33 of the variables refering to the meaning can be found. For the standard deviation ones, it is necessary to substitute "mean" by "std". 

1. "meantimebodyaccelerationx"               
2. "meantimebodyaccelerationy"                
3. "meantimebodyaccelerationz"               
4. "meantimegravityaccelerationx"            
5. "meantimegravityaccelerationy"             
6. "meantimegravityaccelerationz"            
7. "meanjerktimebodyaccelerationx"           
8. "meanjerktimebodyaccelerationy"            
9. "meanjerktimebodyaccelerationz"           
10. "meantimebodyangularx"                    
11. "meantimebodyangulary"                     
12. "meantimebodyangularz"                    
13. "meanjerktimebodyangularx"                
14. "meanjerktimebodyangulary"
15. "meanjerktimebodyangularz"                
16. "meanmagnitudetimebodyacceleration"       
17. "meanmagnitudetimegravityacceleration"    
18. "meanmagnitudejerktimebodyacceleration"   
19. "meanmagnitudetimebodyangular"            
20. "meanmagnitudejerktimebodyangular"        
21. "meanfourierbodyaccelerationx"            
22. "meanfourierbodyaccelerationy"            
23. "meanfourierbodyaccelerationz"            
24. "meanjerkfourierbodyaccelerationx"        
25. "meanjerkfourierbodyaccelerationy"        
26. "meanjerkfourierbodyaccelerationz"        
27. "meanfourierbodyangularx"                 
28. "meanfourierbodyangulary"   
29. "meanfourierbodyangularz"                 
30. "meanmagnitudefourierbodyacceleration"    
31. "meanmagnitudejerkfourierbodyacceleration"
32. "meanmagnitudefourierbodyangular"         
33. "meanmagnitudejerkfourierbodyangular"     
