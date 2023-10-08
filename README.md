# DataMart-Case-Study-
## Description
In June 2020, Data Dart, a company dedicated to environmental sustainability, underwent substantial supply chain transformations. These changes involved the adoption of sustainable packaging methods for all their products, ensuring an eco-friendly approach from the farm to the customer. Data Dart focuses on evaluating the impact of this shift on its sales performance across different business segments.
<p align="center">
    <img src="https://github.com/SanjayD03/Burger-Bash-Case-Study/assets/130745671/09e71f8b-4934-44d3-b532-9793c826954c" alt="DataMart">
</p>

## Installation
To run this project on your machine you need to install any SQL supported DBMS then follow the steps below:
- Create a database.
- Create tables using the schemas.
- Import csv files provided in the dataset folder.

## Database and Tools
MySQL Workbench

## Entity Relationship Diagram
<p align="center">
    <img src="https://github.com/SanjayD03/Burger-Bash-Case-Study/assets/130745671/819f329c-109d-4a27-858b-4bfdb9fd3611" alt="Entity Relationship Diagram">
</p>

## Data Cleansing Steps**
In a single query, perform the following operations and generate a new table in the data_mart schema named clean_weekly_sales:
1.    Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2, etc.
2.    Add a month_number with the calendar month for each week_date value as the 3rd column
3.    Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values
4.    Add a new column called age_band after the original segment column using the following mapping on the number inside the segment value

| Segment | Age Band    |
|---------|-------------|
| 1       | Young Adults|
| 2       | Middle Aged |
| 3 or 4  | Retirees    |

5.    Add a new demographic column using the following mapping for the first letter in the segment values:
segment | demographic | C | Couples |
F | Families |6.    Ensure all null string values with an "unknown" string value in the original segment column as well as the 
new age_band and demographic columns
7.    Generate a new avg_transaction column as the sales value divided by transactions rounded to 2 decimal places for each record

## Questions
1.  Which week numbers are missing from the dataset?
2.  How many total transactions were there for each year in the dataset?
3.  What are the total sales for each region for each month?
4.  What is the total count of transactions for each platform
5.  What is the percentage of sales for Retail vs Shopify for each month?
6.  What is the percentage of sales by demographic for each year in the dataset?
7.  Which age_band and demographic values contribute the most to Retail sales?

## Solutions
1. Which week numbers are missing from the dataset?
Number of weekdays that are missing from the dataset - 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60

2. How many total transactions were there for each year in the dataset?
   
| Calendar Year | Total Transactions |
|---------------|-------------------|
| 2020          | 375,813,651       |
| 2019          | 365,639,285       |
| 2018          | 346,406,460       |

3. What are the total sales for each region for each month?
   
| Month Number | Region        | Total Sales  |
|--------------|---------------|--------------|
| 3            | AFRICA        | 567,767,480  |
| 3            | ASIA          | 529,770,793  |
| 3            | CANADA        | 144,634,329  |
| 3            | EUROPE        | 35,337,093   |
| 3            | OCEANIA       | 783,282,888  |
| 3            | SOUTH AMERICA | 71,023,109   |
| 3            | USA           | 225,353,043  |
| 4            | AFRICA        | 1,911,783,504|
| 4            | ASIA          | 1,804,628,707|
| 4            | CANADA        | 484,552,594  |
| 4            | EUROPE        | 127,334,255  |
| 4            | OCEANIA       | 2,599,767,620|
| 4            | SOUTH AMERICA | 238,451,531  |
| 4            | USA           | 759,786,323  |
| 5            | AFRICA        | 1,647,244,738|
| 5            | ASIA          | 1,526,285,399|
| 5            | CANADA        | 412,378,365  |
| 5            | EUROPE        | 109,338,389  |
| 5            | OCEANIA       | 2,215,657,304|
| 5            | SOUTH AMERICA | 201,391,809  |
| 5            | USA           | 655,967,121  |
| 6            | AFRICA        | 1,767,559,760|
| 6            | ASIA          | 1,619,482,889|
| 6            | CANADA        | 443,846,698  |
| 6            | EUROPE        | 122,813,826  |
| 6            | OCEANIA       | 2,371,884,744|
| 6            | SOUTH AMERICA | 218,247,455  |
| 6            | USA           | 703,878,990  |
| 7            | AFRICA        | 1,960,219,710|
| 7            | ASIA          | 1,768,844,756|
| 7            | CANADA        | 477,134,947  |
| 7            | EUROPE        | 136,757,466  |
| 7            | OCEANIA       | 2,563,459,400|
| 7            | SOUTH AMERICA | 235,582,776  |
| 7            | USA           | 760,331,754  |
| 8            | AFRICA        | 1,809,596,890|
| 8            | ASIA          | 1,663,320,609|
| 8            | CANADA        | 447,073,019  |
| 8            | EUROPE        | 122,102,995  |
| 8            | OCEANIA       | 2,432,313,652|
| 8            | SOUTH AMERICA | 221,166,052  |
| 8            | USA           | 712,002,790  |
| 9            | AFRICA        | 276,320,987  |
| 9            | ASIA          | 252,836,807  |
| 9            | CANADA        | 69,067,959   |
| 9            | EUROPE        | 18,877,433   |
| 9            | OCEANIA       | 372,465,518  |
| 9            | SOUTH AMERICA | 34,175,583   |
| 9            | USA           | 110,532,368  |

4. What is the total count of transactions for each platform
   
| Platform | Total Transactions |
|----------|---------------------|
| Retail   | 1,081,934,227       |
| Shopify  | 5,925,169           |

5. What is the percentage of sales for Retail vs Shopify for each month?
   
| Month Number | Calendar Year | Retail Percentage | Shopify Percentage |
|--------------|---------------|-------------------|--------------------|
| 3            | 2018          | 97.92%            | 2.08%              |
| 3            | 2019          | 97.71%            | 2.29%              |
| 3            | 2020          | 97.30%            | 2.70%              |
| 4            | 2018          | 97.93%            | 2.07%              |
| 4            | 2019          | 97.80%            | 2.20%              |
| 4            | 2020          | 96.96%            | 3.04%              |
| 5            | 2018          | 97.73%            | 2.27%              |
| 5            | 2019          | 97.52%            | 2.48%              |
| 5            | 2020          | 96.71%            | 3.29%              |
| 6            | 2018          | 97.76%            | 2.24%              |
| 6            | 2019          | 97.42%            | 2.58%              |
| 6            | 2020          | 96.80%            | 3.20%              |
| 7            | 2018          | 97.75%            | 2.25%              |
| 7            | 2019          | 97.35%            | 2.65%              |
| 7            | 2020          | 96.67%            | 3.33%              |
| 8            | 2018          | 97.71%            | 2.29%              |
| 8            | 2019          | 97.21%            | 2.79%              |
| 8            | 2020          | 96.51%            | 3.49%              |
| 9            | 2018          | 97.68%            | 2.32%              |
| 9            | 2019          | 97.09%            | 2.91%              |

6. What is the percentage of sales by demographic for each year in the dataset?
   
| Calendar Year | Demographic | Yearly Sales | Percentage |
|---------------|-------------|--------------|------------|
| 2018          | Couples     | 3,402,388,688| 30.38%     |
| 2018          | Families    | 4,125,558,033| 31.25%     |
| 2018          | Unknown     | 5,369,434,106| 32.86%     |
| 2019          | Couples     | 3,749,251,935| 33.47%     |
| 2019          | Families    | 4,463,918,344| 33.81%     |
| 2019          | Unknown     | 5,532,862,221| 33.86%     |
| 2020          | Couples     | 4,049,566,928| 36.15%     |
| 2020          | Families    | 4,614,338,065| 34.95%     |
| 2020          | Unknown     | 5,436,315,907| 33.27%     |

7. Which age_band and demographic values contribute the most to Retail sales?
   
| Age Band     | Demographic | Total Sales    |
|--------------|--------------|-----------------|
| Unknown      | Unknown      | 16,067,285,533 |
| Retirees     | Families     | 6,634,686,916  |
| Retirees     | Couples      | 6,370,580,014  |
| Middle Aged  | Families     | 4,354,091,554  |
| Young Adults | Couples      | 2,602,922,797  |
| Middle Aged  | Couples      | 1,854,160,330  |
| Young Adults | Families     | 1,770,889,293  |

## Conclusion
The provided analysis reveals several key insights about the dataset:
- Missing Weeks: Weeks 1 to 10 and 51 to 60 are missing from the dataset, indicating gaps in the recorded data during these periods.
- Total Transactions: Over the years, total transactions steadily increased, with 2020 showing the highest figure at 375,813,651 transactions.
- Regional Sales: Oceania consistently had the highest sales across months, indicating a strong market presence in that region.
- Platform Distribution: Retail dominated the platform-based transactions with 1,081,934,227 transactions, significantly surpassing Shopify's 5,925,169 transactions.
- Sales Distribution: Retail consistently accounted for the majority of sales over Shopify, showing a consistent retail preference across the years.
- Demographic Influence: Unknown demographic contributed the most to overall sales, followed closely by Retirees and Middle Aged demographics, indicating these age bands play a significant role in the market.
- Retail Sales: For retail sales, Unknown demographic had the highest contribution, indicating a robust market share from an unspecified demographic group, followed by Retirees and Middle Aged demographics.
In a nutshell,, the dataset highlights a strong market presence in Oceania and underscores the importance of understanding demographic preferences, especially in the context of retail sales. Focusing on understanding and catering to the needs of the Unknown, Retirees, and Middle Aged demographics could offer substantial growth opportunities. Additionally, addressing the missing data periods and exploring potential reasons behind the platform preference disparities could provide further valuable insights for strategic decision-making.

## Support
👨‍🚀 Show your support
Give a ⭐️ if this project helped you!
## Feedback
- If you have any feedback, please reach out to me 😃(https://www.linkedin.com/in/sanjay-divate/)
- Your feedback is incredibly valuable to me, and I genuinely appreciate your time and support in helping me make this project better.


