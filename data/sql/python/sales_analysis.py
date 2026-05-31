# =========================================================
# ENTERPRISE SALES & REVENUE ANALYTICS SYSTEM
# COMPLETE PYTHON PROJECT
# =========================================================


# =========================================================
# 1. IMPORT LIBRARIES
# =========================================================

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns


# =========================================================
# 2. LOAD DATASET
# =========================================================

df = pd.read_excel("SuperStore Sales DataSet.xlsx")


# =========================================================
# 3. VIEW DATA
# =========================================================

print(df.head())

print(df.info())

print(df.describe())


# =========================================================
# 4. CHECK NULL VALUES
# =========================================================

print(df.isnull().sum())


# =========================================================
# 5. REMOVE NULL VALUES
# =========================================================

# Drop columns that are entirely null (like 'ind1' and 'ind2')
df.dropna(axis=1, how='all', inplace=True)

# Now drop rows with any remaining null values in relevant columns
df.dropna(inplace=True)


# =========================================================
# 6. REMOVE DUPLICATES
# =========================================================

df.drop_duplicates(inplace=True)


# =========================================================
# 7. CONVERT DATE COLUMN
# =========================================================

df['Order Date'] = pd.to_datetime(df['Order Date'])


# =========================================================
# 8. CREATE MONTH COLUMN
# =========================================================

df['Month'] = df['Order Date'].dt.month


# =========================================================
# 9. TOTAL SALES
# =========================================================

total_sales = df['Sales'].sum()

print("Total Sales:", total_sales)


# =========================================================
# 10. TOTAL PROFIT
# =========================================================

total_profit = df['Profit'].sum()

print("Total Profit:", total_profit)


# =========================================================
# 11. TOP 10 PRODUCTS
# =========================================================

top_products = df.groupby('Product Name')['Sales'].sum().sort_values(ascending=False).head(10)

print(top_products)


# =========================================================
# 12. SALES BY REGION
# =========================================================

sales_region = df.groupby('Region')['Sales'].sum()

print(sales_region)


# =========================================================
# 13. SALES BY CATEGORY
# =========================================================

sales_category = df.groupby('Category')['Sales'].sum()

print(sales_category)


# =========================================================
# 14. MONTHLY SALES TREND
# =========================================================

monthly_sales = df.groupby('Month')['Sales'].sum()

print(monthly_sales)


# =========================================================
# 15. TOP CUSTOMERS
# =========================================================

top_customers = df.groupby('Customer Name')['Sales'].sum().sort_values(ascending=False).head(10)

print(top_customers)


# =========================================================
# 16. PROFIT BY CATEGORY
# =========================================================

profit_category = df.groupby('Category')['Profit'].sum()

print(profit_category)


# =========================================================
# 17. SALES DISTRIBUTION
# =========================================================

plt.figure(figsize=(8,5))

sns.histplot(df['Sales'], bins=30)

plt.title("Sales Distribution")

plt.show()


# =========================================================
# 18. MONTHLY SALES TREND CHART
# =========================================================

plt.figure(figsize=(10,5))

monthly_sales.plot()

plt.title("Monthly Sales Trend")

plt.xlabel("Month")

plt.ylabel("Sales")

plt.show()


# =========================================================
# 19. SALES BY REGION CHART
# =========================================================

plt.figure(figsize=(8,5))

sales_region.plot(kind='bar')

plt.title("Sales by Region")

plt.xlabel("Region")

plt.ylabel("Sales")

plt.show()


# =========================================================
# 20. TOP PRODUCTS CHART
# =========================================================

plt.figure(figsize=(10,5))

top_products.plot(kind='bar')

plt.title("Top Products")

plt.xlabel("Products")

plt.ylabel("Sales")

plt.show()


# =========================================================
# 21. PROFIT BY CATEGORY CHART
# =========================================================

plt.figure(figsize=(8,5))

profit_category.plot(kind='bar')

plt.title("Profit by Category")

plt.xlabel("Category")

plt.ylabel("Profit")

plt.show()


# =========================================================
# 22. CUSTOMER SEGMENTATION
# =========================================================

customer_sales = df.groupby('Customer Name')['Sales'].sum()

segments = []

for value in customer_sales:

    if value >= 5000:
        segments.append("Premium")

    elif value >= 2000:
        segments.append("Standard")

    else:
        segments.append("Basic")


customer_segment = pd.DataFrame({

    'Customer': customer_sales.index,
    'Sales': customer_sales.values,
    'Segment': segments

})

print(customer_segment.head())


# =========================================================
# 23. SALES FORECASTING
# =========================================================

from sklearn.linear_model import LinearRegression


forecast_data = monthly_sales.reset_index()

X = forecast_data[['Month']]

y = forecast_data['Sales']


model = LinearRegression()

model.fit(X, y)


future_months = pd.DataFrame({

    'Month': [13,14,15]

})


predictions = model.predict(future_months)

print(predictions)


# =========================================================
# 24. FORECAST VISUALIZATION
# =========================================================

plt.figure(figsize=(8,5))

plt.plot(forecast_data['Month'], y, label='Actual Sales')

plt.plot(future_months['Month'], predictions, label='Forecast Sales')

plt.legend()

plt.title("Sales Forecast")

plt.xlabel("Month")

plt.ylabel("Sales")

plt.show()


# =========================================================
# 25. SAVE CLEANED DATA
# =========================================================

df.to_csv("cleaned_sales_data.csv", index=False)


# =========================================================
# 26. BUSINESS INSIGHTS
# =========================================================

print("""

BUSINESS INSIGHTS

1. Technology products generate highest revenue.

2. Top customers contribute major sales.

3. Some regions perform better than others.

4. Monthly sales show growth trends.

5. Forecast indicates future sales increase.

"""
)


# =========================================================
# END OF PROJECT
# ========================================================
