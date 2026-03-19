
### Decision 1 — Fixing Inconsistent Date Formats

**Problem:**
When I opened the retail_transactions.csv file I noticed that the date column was a big mess. Every row had a date but they were all written in different ways. Some rows had dates like 2023-08-09, some had 29/08/2023 and some had 12-12-2023. All three formats mean the same date but the database does not understand that. If I try to group sales by month the database will get confused because it cannot sort these mixed formats correctly. For example it might put 29/08/2023 before 2023-01-15 just because of alphabetical order which is completely wrong.

**Resolution:**
I fixed this by converting every single date to one standard format which is YYYY-MM-DD before loading the data into the warehouse. I went through the data and checked which format each date was using and then converted it to the standard format. So 29/08/2023 became 2023-08-29 and 12-12-2023 became 2023-12-12. Now all dates look the same and the database can correctly sort them, group them by month and do calculations like month over month growth without any errors.

---

### Decision 2 — Standardizing Category Names

**Problem:**
The category column had the same category written in many different ways in different rows. For example Electronics was sometimes written as electronics with a small e. Groceries was sometimes written as Grocery without the s at the end. This is a big problem because when I run a GROUP BY category query the database treats Electronics and electronics as two completely separate categories. So instead of showing one total for Electronics it would show two separate rows with split numbers which would make all the reports wrong and confusing for the business.

**Resolution:**
I cleaned all the category names by making them consistent before loading into the dim_product table. I changed all versions of electronics to Electronics with a capital E. I also changed Grocery to Groceries so that all grocery products fall under one single category name. Now when the query groups by category it correctly shows one combined total for each category. This makes all the monthly reports and revenue calculations accurate and trustworthy.

---

### Decision 3 — Filling Missing Store City Values

**Problem:**
When I checked the store_city column I found that MANY rows had a completely empty city value. The city was just blank with nothing in it. This is called a NULL value. This is a problem because if I run a report grouped by city these rows would show up under a blank unnamed city in the results. The business manager looking at the report would be confused and would not know which city those sales came from. It would also make the total revenue numbers look wrong because some sales would not be counted under any real city.

**Resolution:**
I fixed the missing city values by looking at the store_name column which was always filled in for every row. Since each store name always belongs to one specific city I could figure out the correct city from the store name. For example Chennai Anna always means Chennai, Delhi South always means Delhi and Mumbai Central always means Mumbai. I used this mapping to fill in the correct city for all  blank rows before loading the data into the dim_store table. Now every store has a proper city and no NULL values remain in the warehouse.