# Reflections:
The dash offers to the user a clear visualization that helps answer the research question. The plots are properly labeled and there is an appropriate use of color to highlight the different line plots which enable the user to visualize the selected data and differentiate one job role from the other.
The plots in the app follow the principle of proportional ink. The plot is minimalistic but still has the required interactive tools available such as drop-down menus and radio buttons. The plot gives the user the ability to select the data using mouse clicks so the user can further visualize the selected data in detail.  

## Improvements:  
The plots have data till the year 2000 which might make it seem outdated for a user who wants to use it in 2019.
This is because the source dataset itself is until the year 2000.
The data set has several more job roles, but we are focusing only on the top 10 of them. We would have liked to broaden the search and encompassed more job roles. The dataset has data that includes gender and that could have been used to widen the research question into including the distribution of job roles according to gender.
The plot itself could have been a bit more refined by adding a hamburger menu like that in the sketch. The controls for interactivity to be with shift-click and control-click instead of the current choosing of a window of selection and then moving it to highlight a specific area. The drop-down menu is a little disproportionate for the text that is inside it and that hides the down arrow of the menu. The legend font size could have been a bit bigger.  

## Feedback:
Specific feedback from the TA’s to interpolate the missing values and to cite the data source has been incorporated into the app 


## Changes made according to feedback received.
A few major and some minor changes have been incorporated into the app as a response to the feedback received. The interactivity has been made easier.  

1. The user can now click to select the bar indicating a job role and get an insight into the line plot of the selected graph. The user can select multiple bars by using shift + click. The bar plot is now colored with the same color scheme like the one that is used by the line plot on the right.  
https://github.com/UBC-MDS/DSCI_532_Group_208_Job/issues/25

2. The bars are now reordered. The plot is in a descending manner while the stability plot is ordered in a descending manner. The jobs with the minimum Standard deviation which indicate maximum stability are on the left. https://github.com/UBC-MDS/DSCI_532_Group_208_Job/issues/14

3. The line plots now have a tooltip indicating the job details. The (%) symbol has been added to the Y-axis. https://github.com/UBC-MDS/DSCI_532_Group_208_Job/issues/23

4. The text in the header area has been edited to inform the user of the controls for selecting the data to be visualized.


All the changes above have been after prioritizing the peer feedback and the TA feedback received. The time constraint was the primary reason for the choice of changes to be implemented.

## Wishlist features/bugs
Expanded the bar plot to occupy the whole screen when the user selects only the bar plot from the radio button.
Include more jobs in the dataset for analysis and visualization.
Could add another graph like a heatmap or a scatter plot to compare stability and popularity.
Slider for the bar graph.

## Summary of Changes
The changes that were implemented were almost all from the feedback received from the TA and from the peers. The timeframe available was only a couple of days and only those changes that were of user value and could be implemented in a short time were selected. The bar plot and the line plots that form the heart of the application were selected. These were the selection of the bar plot, its color scheme, and the reordering.

## Summary of feedback
Most feedback was received about the Bar plot and its layout. Adding a slider and making the selection of the bar plots more intuitive. Most users did not approve of the sliding window to select the bar plot area. There was no color in the bar plot which matched the line plots. Suggestions were made to include more job roles in the analysis and its visualization.

## Teams reflections
Most users liked the simplicity of the app and the direct way in which the app addresses the research question. some of the key changes made to the bar plot have made a large impact way the app appears and functions. Some users struggled to understand the role of standard deviation in the app. We had not expected this and it was surprising to see it happen. The feedback process was an important step as it made us aware of certain aspects of our app that we as makers of the app failed to see. Suggestions made to change the app which did not address the research question were the least useful. Suggestions about the bar plots and the ones related to the interactivity of the user with the app were the most useful. Given the time frame available some changes suggested were too difficult to implement like the ones to expand the bar plot to occupy the whole screen by using the radio button. However, the most impactful changes to the bar plot have now been implemented and the app is now more user-friendly and intuitive.