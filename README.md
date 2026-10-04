# E-Commerce Delivery Prediction

An end-to-end data analytics and machine learning project using Brazilian e-commerce data to analyse delivery performance and predict potentially late orders.

## Project Overview

Late deliveries can negatively affect customer satisfaction and create operational challenges for e-commerce businesses.

This project analyses historical e-commerce order data to identify factors associated with late deliveries and develops machine-learning classification models to predict whether an order is likely to be delivered late.

The project follows a complete analytics workflow:

**Data Cleaning → Exploratory Data Analysis → Feature Engineering → Machine Learning → Model Evaluation → Threshold Optimisation → Business Recommendations**

---

## Business Problem

The main business question is:

> **Can historical order and customer information be used to identify orders that are more likely to be delivered late?**

Identifying potentially late orders in advance could allow a business to prioritise high-risk deliveries for additional monitoring.

The project also investigates which characteristics are associated with delivery performance.

---

## Dataset

The analysis uses Brazilian e-commerce order data containing information about:

- Orders
- Order items
- Customers
- Customer locations
- Product and freight information
- Purchase and delivery dates

The datasets are combined at order level to create features suitable for analysis and machine learning.

Raw datasets are **not included in the GitHub repository**. The repository contains the analytical notebooks and supporting project files.

---

## Project Objectives

- Clean and prepare the e-commerce datasets.
- Analyse delivery performance.
- Identify differences between Late and On Time orders.
- Engineer useful order-level features.
- Investigate geographic differences in delivery performance.
- Build multiple classification models.
- Compare model performance using appropriate evaluation metrics.
- Address the class imbalance between Late and On Time deliveries.
- Optimise the classification threshold.
- Translate the results into practical business recommendations.

---

## Target Variable

The prediction target is:

`delivery_status`

Two classes are used:

- **Late**
- **On Time**

A delivery is classified as Late when the actual customer delivery date occurs after the estimated delivery date.

---

## Exploratory Data Analysis

The analysis found a strong imbalance in delivery outcomes:

| Delivery Status | Proportion |
|---|---:|
| On Time | 93.43% |
| Late | 6.57% |

Because Late deliveries represent a minority class, accuracy alone can be misleading.

Therefore, the project evaluates:

- Accuracy
- Precision
- Recall
- F1-score

with particular attention to the **Late** class.

---

## Feature Engineering

Several features were created from the original datasets.

### Purchase-Time Features

- `purchase_year`
- `purchase_month`
- `purchase_dayofweek`
- `purchase_hour`

### Order-Level Features

The order-items data was aggregated to create:

- `item_count`
- `order_value`
- `freight_value`

### Delivery Planning Feature

- `estimated_delivery_days`

This represents the number of days between the purchase date and the estimated delivery date.

### Customer Feature

- `customer_state`

Customer state was included to investigate whether geographic information improves delivery-delay prediction.

---

## Machine Learning Models

Several modelling approaches were evaluated.

### Model 1 — Baseline Random Forest

Uses purchase-time features as the initial baseline.

### Model 2 — Random Forest + Order Features

Adds:

- Item count
- Order value
- Freight value

### Model 3 — Balanced Random Forest

Uses a balanced class-weight configuration to give greater consideration to the minority Late class.

### Model 4 — Estimated Delivery Feature

Adds the estimated delivery duration.

### Model 5 — Customer State

Adds customer geographic information using one-hot encoding.

### Model 6 — Logistic Regression

A Logistic Regression model was evaluated as an alternative to the Random Forest approach.

### Threshold Optimisation

The Model 5 Random Forest probability threshold was tested between 0.20 and 0.50.

A threshold of **0.30** provided a stronger balance for identifying Late deliveries.

---

## Model Comparison

| Model | Accuracy | Late Precision | Late Recall | Late F1 |
|---|---:|---:|---:|---:|
| Model 1 - Random Forest | 62.2% | 10% | 61% | 17% |
| Model 2 - + Order Features | 91.1% | 18% | 10% | 13% |
| Model 3 - Balanced Random Forest | 93.2% | 24% | 2% | 3% |
| Model 4 - + Estimated Delivery | 91.9% | 25% | 12% | 16% |
| Model 5 - + Customer State | 92.1% | 32% | 18% | 23% |
| Model 6 - Logistic Regression | 65.4% | 11% | 60% | 19% |
| Model 5 - Threshold 0.30 | **87.0%** | **22%** | **40%** | **28%** |

---

## Key Result

The Balanced Random Forest achieved the highest overall accuracy at **93.2%**.

However, its Late recall was only **2%**.

This means that despite its high accuracy, it detected very few genuinely late deliveries.

Therefore, the model with the highest accuracy was **not automatically considered the best model for the business problem**.

The Random Forest model incorporating customer state and using a **0.30 classification threshold** achieved the strongest Late F1-score:

- **Accuracy:** 87.0%
- **Late Precision:** 22%
- **Late Recall:** 40%
- **Late F1:** 28%

Lowering the threshold from 0.50 to 0.30 increased Late recall from **18% to 40%** and improved Late F1 from **23% to 28%**. 

---

## Important Business Insight

This project demonstrates why **accuracy should not be used as the only model-selection metric** when the target variable is imbalanced.

A model can achieve more than 90% accuracy while still failing to identify most late deliveries.

For this business problem, identifying potentially late orders is important, so Late-class recall and F1-score are particularly relevant.

---

## Key Findings

### 1. Delivery Imbalance

Most orders were delivered on time:

- 93.43% On Time
- 6.57% Late

This creates a significant class-imbalance challenge.

### 2. Order Value

Late orders had a higher average order value:

- Late: **150.87**
- On Time: **136.82**

### 3. Freight Value

Late orders also had a higher average freight value:

- Late: **25.25**
- On Time: **22.65**

### 4. Estimated Delivery Duration

Late orders had a slightly shorter average estimated delivery period:

- Late: **22.29 days**
- On Time: **23.48 days**

### 5. Customer Geography

Adding customer state improved Late-class performance:

- Late precision increased from 25% to 32%.
- Late recall increased from 12% to 18%.
- Late F1 increased from 16% to 23%.

This indicates that geographic information contains useful predictive information for delivery performance.

---

## Business Recommendations

### 1. Identify High-Risk Deliveries Early

The model can be used to identify orders with a higher predicted probability of being late.

High-risk orders could receive additional monitoring during fulfilment and delivery.

### 2. Investigate Geographic Performance

Customer state improved model performance.

Businesses could therefore investigate regions with higher delivery-risk levels and consider whether additional logistics resources or improved delivery partnerships are required.

### 3. Monitor Freight Characteristics

Late orders had higher average freight values.

Further investigation could determine whether particular shipping methods, routes or delivery services are associated with higher delays.

### 4. Monitor High-Value Orders

Late orders also had higher average order values.

High-value orders predicted as high risk could receive additional monitoring because delays may have a greater effect on customer satisfaction.

### 5. Use Appropriate Evaluation Metrics

Accuracy should not be considered in isolation.

Precision, recall and F1-score for the Late class provide a better understanding of whether the model can actually identify delivery-risk cases.

### 6. Adjust the Classification Threshold

The appropriate threshold depends on business priorities.

A lower threshold can identify more potentially late orders but may also create more false alerts.

A higher threshold reduces the number of alerts but may miss more late deliveries.

---

## Limitations

The model should be treated as a **decision-support tool**, not as a guarantee that an order will be late.

The current analysis is based on the available order, order-item and customer information.

Additional operational information could potentially improve prediction performance, including:

- Seller location
- Product category
- Shipping method
- Carrier information
- Additional logistics information

These variables were identified as potential areas for future development rather than being presented as results of the current model.

---

## Project Structure

```text
UK_Job_Market_Intelligence/
│
├── notebooks/
│   ├── 02_data_cleaning.ipynb
│   └── 04_late_delivery_prediction.ipynb
│
├── sql/
│   └── README.md
│
├── data/
│   └── Local datasets excluded from GitHub
│
├── database/
│   └── Local SQLite database excluded from GitHub
│
├── .gitignore
└── README.md
```

---

## Technologies Used

- **Python**
- **Pandas**
- **NumPy**
- **Matplotlib**
- **Scikit-learn**
- **Jupyter Notebook**
- **SQL**
- **SQLite**
- **Git**
- **GitHub**

---

## Machine Learning Techniques

- Train/test split
- Random Forest Classification
- Logistic Regression
- Class weighting
- One-hot encoding
- Feature engineering
- Standardisation
- Classification reports
- Confusion matrices
- Precision
- Recall
- F1-score
- Probability threshold optimisation

---

## Skills Demonstrated

This project demonstrates practical experience with:

**Data Analysis**
- Data cleaning
- Data transformation
- Exploratory data analysis
- Aggregation
- Feature engineering

**Machine Learning**
- Classification
- Random Forest
- Logistic Regression
- Imbalanced classification
- Model comparison
- Threshold optimisation

**Business Analytics**
- Translating model results into business recommendations
- Evaluating trade-offs between precision and recall
- Identifying operational risk
- Communicating analytical findings

**Technical**
- Python
- Pandas
- NumPy
- Scikit-learn
- SQL
- SQLite
- Jupyter
- Git/GitHub

---

## Conclusion

This project demonstrates an end-to-end approach to analysing e-commerce delivery performance and developing a machine-learning solution for identifying potentially late deliveries.

The key lesson is that **the model with the highest accuracy is not necessarily the most useful model** when the business objective focuses on identifying a minority class.

The final Random Forest configuration with customer state and a 0.30 probability threshold achieved a **40% Late recall and 28% Late F1-score**, providing a more useful balance for identifying potentially late deliveries than simply maximising overall accuracy.

---

## Author

**Danish Mushtaq**

Data Analytics | Python | SQL | Power BI | Machine Learning

This project is part of my practical data analytics and machine learning portfolio.