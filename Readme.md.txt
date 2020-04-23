BY RENE KELLER

The analysis presented here is based on:
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The analysis starts with this source file:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data is loaded into R and all measurements (test and training datasets) are combined.
Same goes for subjects and observations (movements).

Columns of the measurements dataset are then renamed based on the features.txt file and all non-avg/std columns are deleted

for the observations, the numeric value is replaced with a textual representation based on activitylabels.txt.

Finally, observations, measurements and subjects are combined into one dataset.

For step 5, that dataset is first melted (keeping subjects and observations intact), then summarized through a mean function and finally pivoted out to restore the variable names in line with the previous dataset.