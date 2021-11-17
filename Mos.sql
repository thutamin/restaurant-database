/* (Database Fundamentals)
/* Author's name: Min Thu Ta*/
/* script name: MOS.SQL */
/* purpose:     Builds PostgreSQL tables for Mos-burger database */
/* date:        30 May 2020 */
/* The URL for the website related to this database is http://www.mosburger.com.au/menu/drinks/ */

DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS ORDERS;
DROP TABLE IF EXISTS MEAL;

CREATE TABLE CUSTOMER
(
    Customer_ID          int         NOT NULL,
    Customer_FirstName   varchar(25),
    Customer_LastName    varchar(25),
    customer_Email       varchar(50),
    Customer_Phonenumber numeric,
    Customer_DOB         date,
Constraint CUSTOMER_PK PRIMARY KEY(Customer_ID)
);

INSERT INTO CUSTOMER VALUES('1001','Darth','Vader','DanDanDanDan@darth.com','0481357950','05/25/1977');
INSERT INTO CUSTOMER VALUES('1002','Darth','Sidious','welcometothedarthside@darth.com','0484569999','05/24/1977');
INSERT INTO CUSTOMER VALUES('1003','Obiwan','Kenobi','hellothere@jedi.com','0482356543','05/28/1977');
INSERT INTO CUSTOMER VALUES('1004','Luke','Skywalker','luke@jedi.com','0489752347','05/26/1977');
INSERT INTO CUSTOMER VALUES('1005','Mace','Windu','purple@jedi.com','0483579533','05/27/1977');

Create TABLE ORDERS
(
    Customer_ID          int         NOT NULL,
    Order_ID             int         NOT NULL,
    Order_Date           date                ,
Constraint ORDERS_PK PRIMARY KEY (Customer_ID,Order_ID),
Constraint ORDERS_FK FOREIGN KEY (Customer_ID) References CUSTOMER
);

INSERT INTO ORDERS VALUES('1001','101','05/27/2020');
INSERT INTO ORDERS VALUES('1001','102','05/27/2020');
INSERT INTO ORDERS VALUES('1002','103','05/27/2020');
INSERT INTO ORDERS VALUES('1003','104','05/27/2020');
INSERT INTO ORDERS VALUES('1004','105','05/27/2020');
INSERT INTO ORDERS VALUES('1005','106','05/27/2020');


Create TABLE MEAL
(
    Meal_ID              int         NOT NULL,
    Meal_Name            varchar(50)         ,
    Meal_Price           numeric     ,
Constraint MEAL_PK PRIMARY KEY (Meal_ID)
);

INSERT INTO MEAL VALUES('2001','Wagyuworks','10.50');
INSERT INTO MEAL VALUES('2002','Easy Cheesy','10.00');
INSERT INTO MEAL VALUES('2003','Tokyo Wagyu','10.00');
INSERT INTO MEAL VALUES('2004','Gourmet Wagyu','9.50');
INSERT INTO MEAL VALUES('2005','Beef Salad','6.50');
INSERT INTO MEAL VALUES('2006','Tokyo Chicken','10.00');
INSERT INTO MEAL VALUES('2007','Buttermilk Chicken','8.00');
INSERT INTO MEAL VALUES('2008','Teriyaki Chicken','8.00');
INSERT INTO MEAL VALUES('2009','Cajun Chicken','8.00');
INSERT INTO MEAL VALUES('2010','BBQ Beef Sushi Burger','7.50');
INSERT INTO MEAL VALUES('2011','Smoked Salmon & Avocado Burger','10.00');
INSERT INTO MEAL VALUES('2012','Seafood Tempura Burger','7.50');
INSERT INTO MEAL VALUES('2013','California Burger','7.50');
INSERT INTO MEAL VALUES('2014','Loaded Chips','10.50');
INSERT INTO MEAL VALUES('2015','Butterfly Prawns (5pc)','5.50');
INSERT INTO MEAL VALUES('2016','Chicken Nuggets(5pc)','5.00');
INSERT INTO MEAL VALUES('2017','Calamari Rings (5pc)','5.00');
INSERT INTO MEAL VALUES('2018','Wedges','4.50');
INSERT INTO MEAL VALUES('2019','Large Chips','4.00');
INSERT INTO MEAL VALUES('2020','Regular Chips','2.50');
INSERT INTO MEAL VALUES('2021','The Wagyu Menace','30.00');
INSERT INTO MEAL VALUES('2022','Attack of the Chicken','17.50');
INSERT INTO MEAL VALUES('2023','Revenge of the Fries','19.00');



Create TABLE COMPONENT
(
    Meal_ID              int         NOT NULL,
    Component_ID         int         NOT NULL,
    Quantity            int         NOT NULL,

Constraint COMPONENT_PK PRIMARY KEY (Meal_ID,Component_ID),
Constraint COMPONENT_FK1 FOREIGN KEY (Meal_ID) References MEAL,
Constraint COMPONENT_FK2 FOREIGN KEY (Component_ID) References MEAL
);

INSERT INTO COMPONENT VALUES('2021','2001','1');
INSERT INTO COMPONENT VALUES('2021','2002','1');
INSERT INTO COMPONENT VALUES('2021','2003','1');
INSERT INTO COMPONENT VALUES('2021','2019','1');
INSERT INTO COMPONENT VALUES('2022','2006','1');
INSERT INTO COMPONENT VALUES('2022','2009','1');
INSERT INTO COMPONENT VALUES('2022','2016','1');
INSERT INTO COMPONENT VALUES('2023','2014','1');
INSERT INTO COMPONENT VALUES('2023','2015','1');
INSERT INTO COMPONENT VALUES('2023','2016','1');
INSERT INTO COMPONENT VALUES('2023','2017','1');


Create TABLE ORDERDETAILS
(
    Customer_ID          int         NOT NULL,
    Order_ID             int         NOT NULL,
    Meal_ID              int         NOT NULL,
    Quantity            int         ,
Constraint ORDERDETAILS_PK PRIMARY KEY (Customer_ID,Order_ID,Meal_ID),
Constraint ORDERDETAILS_FK1 FOREIGN KEY (Customer_ID,Order_ID) References ORDERS,
Constraint ORDERDETAILS_FK2 FOREIGN KEY (Meal_ID) References MEAL
);
INSERT INTO ORDERDETAILS VALUES('1001','101','2023','1');
INSERT INTO ORDERDETAILS VALUES('1001','101','2001','1');
INSERT INTO ORDERDETAILS VALUES('1001','102','2021','2');
INSERT INTO ORDERDETAILS VALUES('1002','103','2021','3');
INSERT INTO ORDERDETAILS VALUES('1003','104','2022','2');
INSERT INTO ORDERDETAILS VALUES('1004','105','2003','1');
INSERT INTO ORDERDETAILS VALUES('1004','105','2015','2');
INSERT INTO ORDERDETAILS VALUES('1005','106','2010','2');
INSERT INTO ORDERDETAILS VALUES('1005','106','2020','1');
INSERT INTO ORDERDETAILS VALUES('1005','106','2018','1');



Select * From CUSTOMER;
Select * from ORDERS;
SELECT * from MEAL;
Select Orders.Customer_id,Orders.order_id,sum(Meal.Meal_Price*Orderdetails.quantity) as total From ORDERS
inner join ORDERDETAILS
on ORDERS.order_id = orderdetails.order_id
inner join MEAL
on MEAL.Meal_ID = ORDERDETAILS.Meal_ID
Group by Orders.Order_ID,ORDERs.Customer_id
order by order_id
;

SELECT * from COMPONENT;
Select Customer_id,order_id,orderdetails.meal_id,quantity,(Meal_Price*quantity)as cost
from ORDERDETAILS inner join MEAL
on MEAL.Meal_ID = ORDERDETAILS.Meal_ID
;
Select Meal_Name From Meal where meal_price = (Select MAx(Meal_Price) From Meal Where meal_price < 10.00);
