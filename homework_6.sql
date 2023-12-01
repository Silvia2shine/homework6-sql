--1. From the following tables write a SQL query to find the salesperson and 
-- customer who reside in the same city. Return Salesman, cust_name and city.
drop table if exists salesman
go
create table salesman(
	salesman_id int primary key not null,
	[name] varchar(128) not null,
	city varchar(128) not null,
	commission decimal(3,2) not null);

insert into salesman(salesman_id,name, city,commission) values (5001 ,'James Hoog' ,'New York', 0.15);
insert into salesman(salesman_id,name, city, commission) values (5002, 'Nail Knite', 'Paris', 0.13);
insert into salesman(salesman_id,name, city, commission) values (5005, 'Pit Alex', 'London', 0.11);
insert into salesman(salesman_id,name, city, commission) values (5006, 'Mc Lyon ', 'Paris', 0.14);
insert into salesman(salesman_id,name, city, commission) values (5007, 'Paul Adam', 'Rome', 0.13);
insert into salesman(salesman_id,name, city, commission) values (5003, 'Lauson Hen', 'San Jose', 0.12);

	select *
	from salesman

	drop table if exists customer
	go
    create table customer(
	customer_id int primary key not null,
	cust_name varchar (100) not null,
	city varchar (100) not null,
	grade int null,
	salesman_id int references salesman(salesman_id) not null);

insert into customer(customer_id, cust_name, city, grade, salesman_id) values (3002, 'Nick Rimando', 'New York', 100, 5001);
insert into customer(customer_id, cust_name, city, grade, salesman_id) values (3007, 'Brad Davis', 'New York', 200, 5001);
insert into customer(customer_id, cust_name, city, grade, salesman_id) values (3005, 'Graham Zusi', 'California', 200, 5002);
insert into customer(customer_id, cust_name, city, grade, salesman_id) values (3008, 'Julian Green', 'London', 300, 5002);
insert into customer(customer_id, cust_name, city, grade, salesman_id) values (3004, 'Fabian Johnson', 'Paris', 300, 5006);
insert into customer(customer_id, cust_name, city, grade, salesman_id) values (3009, 'Geoff Cameron', 'Berlin', 100, 5003);
insert into customer(customer_id, cust_name, city, grade, salesman_id) values (3003, 'Jozy Altidor', 'Moscow', 200, 5007);
insert into customer(customer_id, cust_name, city, grade, salesman_id) values (3001, 'Brad Guzan','London', null, 5005);


select 
s.name, c.cust_name, c.city
from
salesman s join customer c
on s.city = c.city

--2. 2. From the following tables write a SQL query to find those orders where the order 
--amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.
use homework

drop table if exists orders;
go

create table orders(
	ord_no int primary key not null,
	purch_amt decimal (20,2) not null,
	ord_date date not null,
	customer_id int references customer(customer_id) not null,
	salesman_id int references salesman(salesman_id)not null);


insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70001, 150.5, '2012-10-05', 3005, 5002);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70009, 270.65, '2012-09-10', 3001, 5005);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70002, 65.26, '2012-10-05', 3002, 5001);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70004, 110.5, '2012-08-17', 3009, 5003);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70007, 948.5, '2012-09-10', 3005, 5002);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70005, 2400.6, '2012-07-27', 3007, 5001);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70008, 5760, '2012-09-10', 3002, 5001);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70010, 1983.43, '2012-10-10' , 3004, 5006);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70003, 2480.4, '2012-10-10' , 3009, 5003);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70012, 250.45, '2012-06-27', 3008, 5002);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70011, 75.29, '2012-08-17', 3003, 5007);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70012, 3045.6,'2012-04-25', 3002, 5001);



 select
 o.ord_no, o.purch_amt,c.cust_name, c.city
 from
 orders O join customer C
 on o.customer_id = c.customer_id
 where
 o.purch_amt between 500 and 2000;

 --3. From the following tables write a SQL query to find the salesperson(s) 
 --and the customer(s) he represents. Return Customer Name, city, Salesman, commission.

 select
 c.cust_name as CustomerName, c.city,  s.name as SalesmanName, s.commission
 from
 salesman S join customer C
 on S.salesman_id = c.salesman_id

 --4. From the following tables write a SQL query to find salespeople who received 
 --commissions of more than 12 percent from the company. Return Customer Name, 
 --customer city, Salesman, commission. 

  select
 c.cust_name as CustomerName, c.city,  s.name as SalesmanName, s.commission
 from
 salesman S join customer C
 on S.salesman_id = c.salesman_id
 where
 s.commission > 0.12;

 -- 5. From the following tables write a SQL query to locate those salespeople who do not live 
 --in the same city where their customers live and have received a commission of more than 12% 
 --from the company. Return Customer Name, customer city, Salesman, salesman city, commission.  

   select
 c.cust_name as CustomerName, c.city as customerCity,  s.name as SalesmanName, s.city as salsmanCity,  s.commission
 from
 salesman S join customer C
 on S.salesman_id = c.salesman_id
 where
 s.city <> c.city and  s.commission > 0.12;

 -- 6. From the following tables write a SQL query to find the details of an order.
 --Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission. 

  select
 c.cust_name as CustomerName ,  s.name as SalesmanName,  c.grade,
 s.commission, o.ord_no, o.ord_date,o.purch_amt
 from
 salesman S join customer C
 on S.salesman_id = c.salesman_id
 join orders O 
 on c.salesman_id = o.salesman_id
 
--7. Write a SQL statement to join the tables salesman, customer and orders so that the same column 
--of each table appears once and only the relational rows are returned.  

  select
s.salesman_id, s.name,s.city,s.commission,c.customer_id,
c.cust_name,c.city,c.grade,o.ord_no,o.purch_amt, o.ord_date
 from
 salesman S join customer C
 on S.salesman_id = c.salesman_id
 join orders O 
 on c.salesman_id = o.salesman_id

--8. From the following tables write a SQL query to display the customer name, 
--customer city, grade, salesman, salesman city. 
--The results should be sorted by ascending customer_id. 

select 
c.cust_name,c.city,c.grade,s.name as SalsmenName, s.city as SalesmenCity
from
 salesman S join customer C
 on S.salesman_id = c.salesman_id
 order by c.customer_id 

 --9. From the following tables write a SQL query to find those customers with a grade less than 300.
 --Return cust_name, customer city, grade, Salesman, salesmancity. 
 --The result should be ordered by ascending customer_id. 

 select 
c.cust_name,c.city,c.grade,s.name as SalsmenName, s.city as SalesmenCity
from
customer C  left join salesman S
 on S.salesman_id = c.salesman_id
where c.grade< 300
order by c.customer_id

--10. Write a SQL statement to make a report with customer name, city, order number, 
--order date, and order amount in ascending order according to the order date to determine whether
--any of the existing customers have placed an order or not.

select
 c.cust_name, c.city,o.ord_no, o.ord_date,o.purch_amt
 from
 orders O right join customer C
 on o.customer_id = c.customer_id
order by o.ord_date

SELECT a.cust_name,a.city, b.ord_no,
b.ord_date,b.purch_amt AS "Order Amount" 
FROM customer a 
LEFT OUTER JOIN orders b 
ON a.customer_id=b.customer_id 
order by b.ord_date;


--11. SQL statement to generate a report with customer name, city, order number, order date,
--order amount, salesperson name, and commission to determine if any of the existing customers 
--have not placed orders or if they have placed orders through their salesman or by themselves.


  select
  c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt,s.name,s.commission
 from
 customer C left join  orders O
 on o.customer_id = c.customer_id
 left join salesman s 
 on s.salesman_id = o.salesman_id

 --12. Write a SQL statement to generate a list in ascending order of salespersons who work either 
 --for one or more customers or have not yet joined any of the customers.

 select 
s.name,COUNT(c.customer_id) OrdersNr
from
 salesman S left join customer C
 on S.salesman_id = c.salesman_id
 group by s.name


 --13. From the following tables write a SQL query to list all salespersons along with customer name,
 --city, grade, order number, date, and amount.

   select
 s.name as salesPerson, c.cust_name, c.city,c.grade, o.ord_no,o.ord_date,o.purch_amt
 from
salesman s left join customer c
 on s.salesman_id = c.salesman_id
 left join orders o 
 on s.salesman_id = o.salesman_id

 --14.Write a SQL statement to make a list for the salesmen who either work for one or more 
 --customers or yet to join any of the customer. The customer may have placed, either one or 
 --more orders on or above order amount 2000 and must have a grade, or he may not have placed any 
 --order to the associated supplier.

 SELECT a.cust_name,a.city,a.grade, 
b.name AS "Salesman", 
c.ord_no, c.ord_date, c.purch_amt 
FROM customer a 
RIGHT OUTER JOIN salesman b 
ON b.salesman_id=a.salesman_id 
LEFT OUTER JOIN orders c 
ON c.customer_id=a.customer_id 
WHERE c.purch_amt>=2000 
AND a.grade IS NOT NULL;

--15.For those customers from the existing list who put one or more orders,
--or which orders have been placed by the customer who is not on the list, create a report 
--containing the customer name, city, order number, order date, and purchase amount

select
*
from
customer c left join orders o
on c.customer_id = o.customer_id

--16.Write a SQL statement to generate a report with the customer name, city, order no. order date, 
--purchase amount for only those customers on the list who must have a grade and placed one or more 
--orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.

select
*
from
customer c left join orders o
on c.customer_id = o.customer_id
WHERE c.grade IS NOT NULL;

SELECT a.cust_name,a.city, b.ord_no,
b.ord_date,b.purch_amt AS "Order Amount" 
FROM customer a 
FULL OUTER JOIN orders b 
ON a.customer_id=b.customer_id 
WHERE a.grade IS NOT NULL;

--17. Write a SQL query to combine each row of the salesman table with each row of the customer
--table.


 SELECT * 
FROM salesman a 
CROSS JOIN customer b;

--18. Write a SQL statement to create a Cartesian product between salesperson and customer,
--i.e. each salesperson will appear for all customers and vice versa for that salesperson who 
--belongs to that city.

SELECT * 
FROM salesman a 
CROSS JOIN customer b 
WHERE a.city IS NOT NULL;

--19. Write a SQL statement to create a Cartesian product between salesperson and customer, 
--i.e. each salesperson will appear for every customer and vice versa for those salesmen who 
--belong to a city and customers who require a grade.

SELECT * 
FROM salesman a 
CROSS JOIN  customer b 
WHERE a.city IS NOT NULL 
AND b.grade IS NOT NULL;

--20. Write a SQL statement to make a Cartesian product between salesman and customer 
--i.e. each salesman will appear for all customers and vice versa for those salesmen who 
--must belong to a city which is not the same as his customer and the customers should have 
--their own grade.

SELECT * 
FROM salesman a 
CROSS JOIN customer b 
WHERE a.city IS NOT NULL 
AND b.grade IS NOT NULL 
AND  a.city<>b.city;

--21   From the following tables write a SQL query to select all rows from both participating 
--tables as long as there is a match between pro_com and com_id.

drop table if exists company_mast;
go

create table company_mast(
	com_id int primary key not null,
	com_name varchar(128) not null);
	
insert into company_mast(com_id, com_name) values (11, 'Samsung');
insert into company_mast(com_id, com_name) values (12, 'iBall');
insert into company_mast(com_id, com_name) values (13, 'Epsion');
insert into company_mast(com_id, com_name) values (14, 'Zebronics');
insert into company_mast(com_id, com_name) values (15, 'Asus');
insert into company_mast(com_id, com_name) values (16, 'Frontech');

drop table if exists item_mast;
go

create table item_mast(
	pro_id int primary key not null,
	pro_name varchar(128) not null,
	pro_price decimal(10,2) not null,
	pro_com int references company_mast(com_id) not null);

	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (101, 'Mother Board',3200.00,15);
	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (102, 'Key Board',450.00,16);
	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (103, 'ZIP drive',250.00,14);
	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (104, 'Speaker',550.00,16);
	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (105, 'Monitor',5000.00,11);
	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (106, 'DVD drive',900.00,12);
	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (107, 'CD drive',800.00,12);
	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (108, 'Printer',2600.00,13);
	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (109, 'Refill cartridge',350.00,13);
	insert into item_mast(pro_id, pro_name,pro_price,pro_com) values (110, 'Mouse',250.00,12);


	select
	*
	from
	company_mast CM join  item_mast IM
	on CM.com_id = IM.pro_com;

--22. Write a SQL query to display the item name, price, and company name of all the products.

select
	IM.pro_name,IM.pro_price,cm.com_name
from
item_mast IM left join company_mast CM  
on CM.com_id = IM.pro_com;

--23. From the following tables write a SQL query to calculate the average price of items 
-- of each company. Return average value and company name.

select
cm.com_name, AVG(IM.pro_price)
from
item_mast IM left join company_mast CM  
on CM.com_id = IM.pro_com
group by cm.com_name;


-- 24. From the following tables write a SQL query to calculate and find the average price of items
-- of each company higher than or equal to Rs. 350. Return average value and company name.

select
cm.com_name, AVG(IM.pro_price)
from
item_mast IM left join company_mast CM  
on CM.com_id = IM.pro_com
where IM.pro_price > 350
group by cm.com_name;


SELECT AVG(pro_price), company_mast.com_name
   FROM item_mast INNER JOIN company_mast
   ON item_mast.pro_com= company_mast.com_id
   GROUP BY company_mast.com_name
   HAVING AVG(pro_price) >= 350;


-- 25. From the following tables write a SQL query to find the most expensive product of each company.
-- Return pro_name, pro_price and com_name.



SELECT A.pro_name, A.pro_price, F.com_name
   FROM item_mast A INNER JOIN company_mast F
   ON A.pro_com = F.com_id
     AND A.pro_price =
     (
       SELECT MAX(A.pro_price)
         FROM item_mast A
         WHERE A.pro_com = F.com_id
     );

-- 26. From the following tables write a SQL query to display all the data of employees including
-- their department.

drop table if exists emp_department;
go

create table emp_department(
    dpt_code int primary key not null,
    dpt_name varchar(255) not null,
    dpt_allotment int
);

insert into emp_department(dpt_code, dpt_name, dpt_allotment) values (57, 'IT', 65000);
insert into emp_department(dpt_code, dpt_name, dpt_allotment) values (63, 'Finance', 15000);
insert into emp_department(dpt_code, dpt_name, dpt_allotment) values (47, 'HR', 240000);
insert into emp_department(dpt_code, dpt_name, dpt_allotment) values (27, 'RD', 55000);
insert into emp_department(dpt_code, dpt_name, dpt_allotment) values (89, 'QC', 75000);

drop table if exists emp_details
go

create table emp_details(
    emp_idno int primary key not null,
    emp_fname varchar(255) not null,
    emp_lname varchar(255) not null,
    emp_dept int,
    emp_int int references emp_department(dpt_code)
);

insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (127323, 'Michale', 'Robbin', 57);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (526689, 'Carlos', 'Snares', 63);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (843795, 'Enric', 'Dosio', 57);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (328717, 'John', 'Snares', 63);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (444527, 'Joseph', 'Dosni', 47);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (659831, 'Zanifer', 'Emily', 47);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (847674, 'Kuleswar', 'Sitaraman', 57);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (748681, 'Henrey', 'Gabriel', 47);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (555935, 'Alex', 'Manuel', 57);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (539569, 'George', 'Mardy', 27);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (733843, 'Mario', 'Saule', 63);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (631548, 'Alan', 'Snappy', 27);
insert into emp_details(emp_idno, emp_fname, emp_lname, emp_dept) values (839139, 'Maria', 'Foster', 57);


SELECT emp_idno, A.emp_fname AS "First Name", emp_lname AS "Last Name",
    B.dpt_name AS "Department", emp_dept, dpt_code,  dpt_allotment
     FROM emp_details A 
      INNER JOIN emp_department B
        ON A.emp_dept = B.dpt_code;


-- 27. From the following tables write a SQL query to display the first and last names of each 
-- employee, as well as the department name and sanction amount.



SELECT emp_details.emp_fname AS "First Name", emp_lname AS "Last Name", 
    emp_department.dpt_name AS "Department", 
     dpt_allotment AS "Amount Allotted"
       FROM emp_details 
         left JOIN emp_department
           ON emp_details.emp_dept = emp_department.dpt_code;


-- 28. From the following tables write a SQL query to find the departments with budgets more than
-- Rs. 50000 and display the first name and last name of employees.


	SELECT emp_details.emp_fname AS "First Name", emp_lname AS "Last Name"
  FROM emp_details 
    INNER JOIN emp_department
        ON emp_details.emp_dept = emp_department.dpt_code
    where emp_department.dpt_allotment > 50000;


-- 29. From the following tables write a SQL query to find the names of departments where more
-- than two employees are employed. Return dpt_name.


	SELECT 
	emp_department.dpt_name, count(emp_details.emp_idno) as NumberOfEmploys
  FROM emp_details 
    INNER JOIN emp_department 
        ON emp_details.emp_dept = emp_department.dpt_code
		
		group by emp_department.dpt_name
		having count(*) > 2



