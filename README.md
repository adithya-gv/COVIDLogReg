# COVIDLogReg
A Logistic Regression Algorithm to predict COVID-19 Cases 

## Libraries Used
The JSON Library used to scrape the JSON data from covidtracking.com

## Updates
June 24, 2020: Created the basic logistic regression algorithm to fit a curve to the data.

June 25, 2020: Updated the algorithm to attempt to calculate the inflection point and created basic predictions for 1 day, 10 day and 50 day future outlooks.

July 4, 2020: Updated the algorithm with a more accurate algorithm to estimate the inflection point, now basing it off more on the shape of the data.

July 12, 2020: Fixed print output bug where there would be no space between the colon and the case count.

July 15, 2020: Created Scraper Tool to automatically update case counts using data from covidtracking.com and the JSON API.

July 23, 2020: Generalized both the scraper tool and the algorithm to all US states. Also updated the convergence test from absolute difference to iteration count (change in predictions under 0.01%).

August 4, 2020: Fixed the case collection and gathering algorithm slightly (to compensate for lack of data at times in the day). Prediction algorithm updated to include both a graph as well as yesterday's cases. Prediction algorithm has errors, currently under investigation.

August 6, 2020: Fixed prediction algorithm errors.

August 11, 2020: Massive algorithm update: the algorithm failed to produce accurate readings for states with case decline. In addition, cases were incorrectly predicted for anomalies. Therefore, the entire algorithm was re-written in order to fix these bugs.