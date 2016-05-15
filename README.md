# wearables
Reading and Processing Data Week 4 Project
This repository contains a single R script, run_analysis.R, as per the project instructions
The script accesses movement data collected using wearable technology (a smartphone). The data is downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The script combines movement data from subjects in both the test and training components of the wearable dataset. Only observations related to the mean or standard deviation of movement measurements are retained. The final result of the script is a data frame of the mean values of mean and standard deviations of various measurements, broken down by activity and subject. This data frame, meanvalues.activity.subject, is saved as an R data file, tidymeanvalues.Rdata .
