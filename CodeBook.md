# CodeBook for Reading and Processing Data W4 Project

## Summary

A new data set, tidymeanvalues.txt, is created. It is a summary of one aspect of data from a wearables study, downloaded from 
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
A full description of the study is at
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Test and Training Datasets

Test and training data is read from source datasets test/X_test.txt and train/X_train.txt. These datasets contain values for
many measurements, summarised in different ways, for example means and standard deviations over repeated observations on 
a given occasion.

There is an activity and subject associated with each such occasion. Activity details were sourced from train/y_train.txt and test/y_test.txt. Activity labels came from activity_labels.txt. Subject IDs came from test/subject_test.txt and
train/subject_train.txt.

## Subsetting

The data was subset to observations relating to either a mean or a standard deviation of a set of measurements. This subsetting was based on whether the column headings in test/X_test.txt and train/X_train.txt contained mean() or std().

## Averaging

The final dataset (tidymeanvalues.txt) contains mean values broken down by activity name, subject and variable. Each row represents a cell defined by an activity name, subject, and variable. The column meanvalue is the mean of the specified variable for this activity and subject. Note that only variables calculated as means or standard deviations of sets of values are included.


