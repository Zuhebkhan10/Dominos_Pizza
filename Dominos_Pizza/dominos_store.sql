-- Clean Dominos_data database-- 
#Step-1 To check for duplicate-- 
-- 2 Check for null values
-- 3 Treating null values
-- 4 Handling negative values
-- 5 fixing inconsistent date formats and Invalid dates
-- 6 fixing invalid email address
-- 7 checking the database

Select *from customers;

#To check for duplicate-- 
Select min(custid)from customers
group by email;


#Check for null values
Select count(*)from customers;

Select count(*)from customers 
Where phone is not null
Or
first_name is not null;

#Treating Null values
update customers set first_name='NA'where  first_name is null;


#Handling negative values
Select *from order_details where quantity <1;
update order_details set quantity=0 where quantity <1;

#Fixing Inconsistent date formats and Invalid dates
select *from orders where order_date is null 

#fixing invalid email address
 

 


