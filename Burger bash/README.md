## Burger Bash (Case-Study)
## Description
"**Burger Bash**",<h8> is a pioneering venture in the burger industry that blends traditional burger sales with the convenience of on-demand delivery. This innovative approach involves assembling a team of dedicated "runners" to distribute fresh burgers from the Burger Runner Headquarters. Additionally, a user-friendly mobile app has been developed to facilitate customer orders. The project's primary goal is to revolutionize the burger business, offering both in-person and delivery options while embracing modern technology to secure seed funding for expansion.

<p align="center">
    <img src="https://github.com/SanjayD03/Burger-Bash-Case-Study/assets/130745671/cc74646c-8422-42a7-901e-9242e7dabded" alt="Burger Bash">
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
    <img src="https://github.com/SanjayD03/Burger-Bash-Case-Study/assets/130745671/c7bfd52e-fd00-4103-8995-be90767cd0ef" alt="Entity Relationship Diagram">
</p>

## Business Objective
To disrupt the traditional burger industry by transforming it into a tech-enabled, on-demand burger delivery service, leveraging a user-friendly mobile app and a network of dedicated "runners" for fast and convenient burger delivery.
In short, the business objective is to revolutionize the burger industry by offering a tech-driven, on-demand burger delivery service that prioritizes convenience, quality, and expansion, with the ultimate goal of creating a successful Burger Empire.

## Questions
1.  How many burgers were ordered?
2.  How many unique customer orders were made?
3.  How many successful orders were delivered by each runner?
4.  How many of each type of burger was delivered?
5.  How many Vegetarian and Meatlovers were ordered by each customer?
6.  What was the maximum number of burgers delivered in a single order?
7.  For each customer, how many delivered burgers had at least 1 change and how many had no changes?
8.  What was the total volume of burgers ordered for each hour of the day?
9.  How many runners signed up for each 1 week period? 
10. What was the average distance travelled for each customer?

## Results
1. How many burgers were ordered? <br>
   Total number of orders: 10 <br>
   ***Provides the straightforward count of burger orders, indicating that there were 10 orders placed in total.***

2. How many unique customer orders were made? <br>
   Number of unique order count: 10 <br>
   ***All 10 orders were unique, suggesting that there were 10 distinct customers who placed orders.***

3. How many successful orders were delivered by each runner? <br>
   Runner id: 1, 2, 3 <br>
   Successful orders: 4, 3, 1 <br>
   ***This answer breaks down the successful deliveries for each runner. Runner 1 delivered 4 orders, Runner 2 delivered 3, and Runner 3 delivered 1.***

4. How many of each type of burger was delivered?** <br>
   Burger type (Veg/Non-Veg): Meatlovers, Vegetarian <br>
   Burger count Delivered: 9 (Meatlovers), 3 (Vegetarian) <br>
   ***Distinguishes between two types of burgers - Meatlovers and Vegetarian. It shows that 9 Meatlovers and 3 Vegetarian burgers were delivered.***

5. How many Vegetarian and Meatlovers were ordered by each customer?** <br>
   Customer_id: 101, 102, 103, 104, 105 <br> 
   Burger type (Veg/Non-Veg): Meatlovers, Vegetarian <br>
   Order Count: Varies for each customer and burger type <br>
   ***Provides a detailed breakdown of the number of Meatlovers and Vegetarian burgers ordered by each customer, showing the diversity of preferences among customers.***

6. What was the maximum number of burgers delivered in a single order?** <br>
   Maximum burger count: 3 <br>
   ***Identifies that the highest number of burgers delivered in a single order was 3, suggesting that one order had 3 items.***

7. For each customer, how many delivered burgers had at least 1 change and how many had no changes?** <br>
   Customer_id: 101, 102, 103, 104, 105 <br>
   At least one change: Varies for each customer <br>
   No change: 0 for all customers <br>
   ***categorizes each customer's delivered orders into those with at least one modification and those with no changes, giving insights into individual customer preferences.***

8. What was the total volume of burgers ordered for each hour of the day?** <br>
   Hour of day: 11, 13, 18, 19, 21, 23 <br>
   Total burger count: Varies for each hour <br>
     ***Provides a distribution of burger orders by the hour of the day, indicating when customers placed orders.***

9. How many runners signed up for each 1-week period?** <br>
   Registration week: 0, 1, 2 <br>
   Runner signed up: Varies for each week <br>
   ***Tracks runner sign-ups over a 3-week period, showing the number of new runners joining the delivery service in each week.***

10. What was the average distance traveled for each customer?** <br>
    Customer_id: 101, 102, 103, 104, 105 <br>
    Average distance: Varies for each customer <br>
    ***Calculates and presents the average distance traveled by each customer for their burger deliveries, helping understand delivery efficiency and customer locations. The varying   distances suggest differences in delivery routes or customer locations.***

## Conclusion
Based on the analysis of the burger delivery data:

- There were a total of 10 burger orders placed.
- All 10 orders were unique, indicating 10 distinct customers.
- The distribution of successful deliveries among runners was as follows: Runner 1 delivered 4 orders, Runner 2 delivered 3, and Runner 3 delivered 1.
- Meatlovers burgers were more popular, with 9 delivered, compared to 3 Vegetarian burgers.
- Customer preferences for burger types varied, with each customer ordering different quantities of Meatlovers and Vegetarian burgers.
- The maximum number of burgers delivered in a single order was 3.
- None of the customers had orders with no changes, all had at least one modification to their delivered burgers.
- Burger orders were distributed throughout the day, with varying order volumes at different hours.
- Runner sign-ups occurred over a three-week period, with varying numbers of new runners each week.
- Customer average distances varied, suggesting differences in delivery routes or customer locations.

In Short, the data highlights the diversity in customer preferences, delivery efficiency, and runner engagement. Meatlovers burgers were the more popular choice, and customer orders showed individual variations. The data also indicates potential opportunities for optimizing delivery routes and improving service based on customer locations and delivery times.

## Suggestions

Based on the analysis and conclusions drawn from the burger delivery data, here are some suggestions to improve sales and customer satisfaction for the Burger Runner business:

- **Diversify Menu Option**s: While Meatlovers burgers are popular, consider expanding the menu to cater to a broader range of tastes. Adding more vegetarian options and potentially introducing special promotions or themed burgers can attract a wider customer base.

- **Customization Features**: Since all customers made modifications to their orders, enhance the mobile app to allow for easy customization of burgers. Offer a variety of toppings, sauces, and sides, giving customers the freedom to create their ideal burger.

- **Delivery Time Optimization**: Analyze the distribution of orders throughout the day and allocate runners accordingly to reduce delivery times during peak hours. Implement strategies to provide accurate estimated delivery times to customers, managing their expectations effectively.

- **Quality Control**: Ensure consistent quality in burger preparation and delivery. Implement quality checks to maintain the freshness and taste of the burgers, which can lead to repeat business and positive reviews.

- **Customer Loyalty Program**: Introduce a loyalty program that rewards frequent customers with discounts or free items after a certain number of orders. This can incentivize repeat business and customer retention.

- **Runner Training**: Provide training to runners on customer service and efficient delivery routes. Consider performance incentives to motivate them to deliver orders promptly and professionally.

- **Feedback Loop**: Create a feedback mechanism within the app, allowing customers to provide comments and ratings for their orders and the overall service. Use this feedback to identify areas for improvement.

- **Marketing and Promotion**: Use customer data to target marketing efforts more effectively. Send promotions, discounts, or special offers to specific customer segments based on their preferences and ordering history.

- **Expansion**: If the data indicates potential demand in specific areas or during certain hours, consider expanding the delivery radius or increasing the number of runners during peak times.

- **Runner Recruitment**: Continue to recruit and train new runners to ensure consistent coverage and quick deliveries, especially during busy periods.

- **Data Analytics**: Regularly analyze customer data to identify trends and preferences, enabling data-driven decisions to further improve the business.

- **Community Engagemen**t: Consider engaging with the local community through events, sponsorships, or partnerships to increase brand visibility and build a loyal customer base.

By implementing these suggestions, Burger Runner can enhance its sales, customer satisfaction, and overall competitiveness in the burger delivery industry.

## Support
👨‍🚀 Show your support
Give a ⭐️ if this project helped you!
## Feedback
- If you have any feedback, please reach out to me 😃(https://www.linkedin.com/in/sanjay-divate/)
- Your feedback is incredibly valuable to me, and I genuinely appreciate your time and support in helping me make this project better.


