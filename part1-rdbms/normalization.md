### DATABASE ANOMALY ###
A database anomaly is an unwanted side effect that occurs when performing basic operations (insert, update, delete) on a poorly designed database table. Anomalies arise
mainly when all data is stored in a single flat table instead of being properly separated into related tables.

### INSERT ANOMALY ###

# Definition #: 
An Insert Anomaly occurs when we cannot insert a new record into the database without also providing some other unrelated information that we may not have.

Example:
Suppose a new sales representative Sunita Kapoor (SR04) joins the company with email sunita@corp.com and office at Pune. We want to save her details in the system.

Problem: 
In this flat table, a sales rep's details can only be stored as part of an order row.Since Sunita has no orders yet, we CANNOT add her information. We would have to create a fake/dummy order  to store her name — which is wrong .


### UPDATE ANOMALY ###

# Definition #:
An Update Anomaly occurs when the same data is stored in multiple rows. If that data needs to be changed, it must be updated in every row. If even one row is missed, the
database becomes inconsistent.

Example :
Sales rep Deepak Joshi (SR01) has many orders. His office address mappears in every  rows. In our dataset, someone updated his address in somerows but missed others — creating two different addresses for the same person.in this file we also have done this mistake use 2 different address for one person.



### DELETE ANOMALY ###

# Definition #:
A Delete Anomaly occurs when deleting a record for one reason accidentally causes the loss of other important, unrelated information stored in the same row.

Example :
If we delete all orders handled by Ravi Kumar (SR03), we permanently lose his email (ravi@corp.com) and office address (South Zone, MG Road, Bangalore). This data exists nowhere else.


### Normalization Justification ###
I completely disagree with my manager's argument. While keeping everything in one table may seem simpler at first, it actually creates serious problems in the long run — and our own dataset is proof of that.Our dataset stores customer details, product details, sales rep details, and order details all in one flat table. This looks convenient, but it has already caused real damage. 
For example, sales rep Deepak Joshi (SR01) has his office address stored in many rows. When someone tried to update his address, they missed a few rows — so now the same person shows two different office addresses in the same table. This is a direct Update Anomaly caused .
Similarly, if customer Kavya Rao (C008) cancels all her orders and we delete those rows, we permanently lose her name, email, and city. There is no separate place where her information is saved. This is a Delete Anomaly.
if a new sales rep joins but has no orders yet, we simply cannot add her to the system — that is an Insert Anomaly.
So normalization is not over-engineering — it is essential for data accuracy, consistency, and reliability. A simpler-looking table is not actually simple when it causes data corruption and loss.
Normalization fixes all of this by organizing data into four clean tables — Customers, Products, Sales_Reps, and Orders. Each piece of information is stored in exactly one place. If Deepak's address changes, we update it once in the Sales_Reps table and it is correct everywhere. If Kavya cancels her orders, her customer profile remains safe in the Customers table. If a new sales rep joins, we simply add a row to Sales_Reps — no dummy order needed.
Conclusion
My manager's idea of "simplicity" actually creates hidden complexity — inconsistent data, accidental data loss, and blocked insertions. True simplicity means a database that is reliable, consistent, and easy to maintain. That is exactly what normalization delivers. The one-table approach may save five minutes of design time today, but it will cost hours of data correction and cause serious business errors tomorrow.