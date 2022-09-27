# Medical Cost Predictive Analysis

Dataset: [https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset](https://www.kaggle.com/datasets/mirichoi0218/insurance) <br>


## Code and Resources Used 
**Python Version:** 3.9.12
**Packages:** pandas 



## Data Exploration
I initially looked at our basic column structures, stats for each column (min, max, stdev, etc...), and the null values.
The best part of this dataset is there are no null values!


I then switched to looking at our columns data types to get a good understanding of what possible changes we may need to make for our statistical modeling. Here is the recoding I performed:

* Recoded the following Columns floats to integers
    * BMI
    * Age
    * Region

For each of the variables above, they were continuous data. I changed them for 2 reasons:
1. I wanted to match our other categorical variables and run a simple ANOVA
2. BMI and Age are usually broken up into separate categories in the healthcare field. 
   This would allow me to determine a particular age group as opposed to observing individual ages.
   
   
* I created and exported the following for statistical modeling and visualization:
    * Dropped the original BMI, Age and Region columns for the statistical modeling dataset
    * Created another dataframe dropping our newly recoded columns
    * Exported both dataframes separately for each use case:
      * insurance2 is for statistical modeling
      * insurance3 is for data visualization


## Model Building 
<!-- 
First, I transformed the categorical variables into dummy variables. I also split the data into train and tests sets with a test size of 40%.   

I tried three different models and evaluated them using Mean Absolute Error. I chose MAE because it is relatively easy to interpret and outliers aren’t particularly bad in for this type of model.   

I attempted one model and evaluated the fit for the data. With an 82% accuracy, we have a pretty decent build. However, I will explore further models builds through Lasso Regression and Multiple Linear Regression

Here is the model I tested
*	**Random Forest** – with the sparsity associated with the data, I thought that this would be a good fit. -->

## Model performance
<!-- The Random Forest model performed well and was able to predict employee attrition with 82% accuracy.
*We performed Hyperparameter tuning to enahnce and build the best possible model. The following parameters gave us the best model.
     * Number of Estimators = 50
     * Minimum Samples Leaf = 1
     * Max Depth = 30 -->
     
     
## Conclusions
<!-- * We can predict, with our model, whether an employee will stay with 84% accuracy
* The best predictors of whether someone will stay are in descending order: <br>
      * Monthly Income <br>
      * Age<br>
      * Total Working Years<br>
      * Hourly Rate<br>
      * Monthly Rate<br>
      * Distance from Home<br>
      * OverTime<br> -->
      

      
      
<!-- Here you can see a graph of the features importance from least to greatest:

<img style="display: inline; margin: 0 5px;" title="Feature Importance" src="https://github.com/michaeljwilt/employeeAttritionML/blob/main/Images/Features%20Graph.png" alt="" width="800" height="500" /> -->


