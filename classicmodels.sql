select * from customers;
select * from customers where customername is null or country is null;
select * from employees where employeenumber is null or officecode is null;
select * from offices where officecode is null or city is null;
select * from orders where ordernumber is null or customernumber is null;
select * from orderdetails where ordernumber is null or productcode is null;
select * from payments where customernumber is null or paymentdate is null;
select * from productlines where productline is null;
select * from products where productcode is null or productline is null;
select * from student where st_roll is null or mark is null;
describe customers;
describe employees;
describe offices;
describe orderdetails;
describe orders;
describe payments;
describe productlines;
describe products;
describe student;
select phone from classicmodels.customers where phone not regexp '^[0-9//(//)//-//+ ] +$';
select distinct country from classicmodels.customers where country not in ('usa', 'france', 'australia', 'uk', 'germany', 'spain', 'italy', 'canada');
select customername, creditlimit from classicmodels.customers where
creditlimit < 0 or creditlimit > 1000000;
select addressline1, addressline2 from classicmodels.customers where addressline1 is null or addressline2 is not null and addressline2 not regexp '[0-9]';
select email from classicmodels.employees where email not regexp '^[a-zA-ZO-9._%+-]+@[[a-zA-ZO-9.-]+/.[a-zA-Z]{2,}$';
select employeenumber, officecode from classicmodels.employees where officecode is null or officecode not in (select officecode from classicmodels.offices); 
select email, count(*) as count from classicmodels.employees group by email having count > 1;
select distinct city from classicmodels.offices where city not in ('san francisco', 'new york', 'london', 'paris', 'tokyo');
select distinct country from classicmodels.offices where country not in ('usa', 'uk', 'france', 'japan', 'australia');
select phone from classicmodels.offices where phone not regexp '^[0-9//(//)//-//+ ]+$';
select addressline1, addressline2 from classicmodels.offices where addressline1 is null or addressline2 is not null and addressline2 not regexp '[0-9]';
select distinct productcode from classicmodels.orderdetails where productcode not in (select productcode from classicmodels.products);
select ordernumber, productcode, quantityordered from classicmodels.orderdetails where quantityordered <=0;
select ordernumber, productcode, priceEach from classicmodels.orderdetails where priceEach <=0;
select distinct ordernumber from classicmodels.orderdetails where ordernumber not in (select ordernumber from classicmodels.orders);
select ordernumber, orderdate from classicmodels.orders where orderdate > current_date();
select ordernumber, orderdate, requireddate from classicmodels.orders where requireddate < orderdate;
select ordernumber, orderdate, shippeddate from classicmodels.orders where shippeddate < orderdate;
select distinct status from classicmodels.orders where status not in ('in process', 'shipped', 'resolved', 'canclled', 'on hold', 'disputed'); 
select distinct customernumber from classicmodels.orders where customernumber not in (select customernumber from classicmodels.customers);
select p.customernumber, p.paymentdate, o.orderdate from classicmodels.payments p join classicmodels.orders o on p.customernumber = o.customernumber where p.paymentdate < o.orderdate;
select customernumber, checknumber, paymentdate, amount from classicmodels.payments where amount <=0;
select checknumber, count(*) as count from classicmodels.payments group by checknumber having count > 1;
select distinct customernumber from classicmodels.payments where customernumber not in (select customernumber from classicmodels.customers);
select productline from classicmodels.productlines where textdescription is null;
select productline, length(textdescription)  as description_length from classicmodels.productlines where length(textdescription) < 10 or length(textdescription) > 1000; 
select productline from classicmodels.productlines where htmldescription is null;
select productline from classicmodels.productlines where productline not in (select producline from classicmodels.productline);
select productcode, count(*) as count from classicmodels.products group by productcode having count > 1;
select productcode, productname from classicmodels.products where productname is null;
select productcode, productscale from classicmodels.products where productscale not in ('1:10', '1:12', '1:18', '1:24', '1:32', '1:43');  
select productcode, productvendor from classicmodels.products where productvendor is null or productvendor = '';
select distinct productline from classicmodels.products where productline not in (select productline from classicmodels.productlines);
select productcode, quantityinstock from classicmodels.products where quantityinstock < 0;
select * from student where st_roll is null or name is null or mark is null;
select * from student where name not regexp '^[a-zA-z ]+$';
update classicmodels.customers set addressline2 = coalesce(addressline2, ''), state = coalesce(state,'') where customernumber > 0;
Delete from classicmodels.orders where ordernumber is null and orderdate is null and requireddate is null and shippeddate is null and status is null and comments is null and customernumber is null; 
set sql_safe_updates = 0;
delete from classicmodels.orderdetails where ordernumber is null and productcode is null and quantityordered is null and priceeach is null and orderlinenumber is null;
set sql_safe_updates = 1;
delete from classicmodels.products where productcode is null and productname is null and productline is null and productscale is null and productvendor is null and productdescription is null and quantityinstock is null and buyprice is null and msrp is null;
delete from classicmodels.payments where customernumber is null and checknumber is null and paymentdate is null and amount is null;
delete from classicmodels.offices where officecode is null and city is null and phone is null and addressline1 is null and  addressline2 is null and state is null and country is null and postalcode is null and territory is null;
delete from classicmodels.productlines where productline is null and textdescription is null and htmldescription is null and image is null;
delete from classicmodels.employees where employeenumber is null and lastname is null and firstname is null and extension is null and email is null and officecode is null and reportsto is null and jobtitle is null;
select p.productcode, p.productname, sum(od.quantityordered * od.priceeach) as totalsales from classicmodels.orderdetails od join classicmodels.products p on od.productcode = p.productcode group by p.productcode, p.productname order by totalsales desc limit 10;
select c.customernumber, c.customername, sum(od.quantityordered * od.priceeach) as totalrevenue from classicmodels.orders o join classicmodels.orderdetails od on o.ordernumber = o.ordernumber join classicmodels.customers c on o.customernumber = c.customernumber group by c.customernumber, c.customername order by totalrevenue desc limit 10;
select p.productline, sum(od.quantityordered * od.priceeach) as totalsales from classicmodels.orderdetails od join classicmodels.products p on od.productcode = p.productcode
group by p.productline order by totalsales desc;
select year(orderdate) as year, month(orderdate) as month, sum(quantityordered * priceeach) as totalsales from classicmodels.orders join classicmodels.orderdetails on orders.ordernumber = orderdetails.ordernumber group by year, month order by year, month;
select c.customerNumber, c.customername, avg(od.quantityordered * od.priceeach) as averageordervalue from classicmodels.orders o join classicmodels.orderdetails od on o.ordernumber = od.ordernumber join classicmodels.customers c on o.customernumber = c.customernumber group by c.customernumber, c.customername order by averageordervalue desc;
select productcode, productname, (msrp - buyprice) as profitmargin from classicmodels.products order by profitmargin desc;
select c.customernumber, c.customername, count(o.ordernumber) as ordercount from classicmodels.orders o join classicmodels.customers c on o.customernumber = c.customernumber group by c.customernumber, c.customername order by ordercount desc limit 10;
select c.country, sum(od.quantityordered * od.priceeach) as totalsales from classicmodels.orders o join classicmodels.orderdetails od on o.ordernumber = od.ordernumber join classicmodels.customers c on o.customernumber = c.customernumber group by c.country order by totalsales desc;
select p.productcode, p.productname, sum(od.quantityordered) as totalquantity from classicmodels.orderdetails od join classicmodels.products p on od.productcode = p.productcode group by p.productcode, p.productname order by totalquantity desc;
select e.employeenumber, e.firstname, e.lastname, sum(od.quantityordered * od.priceeach) as totalsales from classicmodels.employees e join classicmodels.customers c on e.employeenumber = c.salesrepemployeenumber join classicmodels.orders o on c.customernumber = o.customernumber join classicmodels.orderdetails od on o.ordernumber = od.ordernumber group by e.employeenumber, e.firstname, e.lastname order by totalsales desc;
describe classicmodels.customers;
delimiter //
create procedure getcustomerorders(IN custname INT)
begin 
select * from orders 
where customernumber = cust_id;
End //
delimiter ; 
call getcustomerorders(101);

delimiter //
create procedure gettotalordervalue(in custnum int)
begin 
select customernumber, sum(priceeach * quantityordered) as totalordervalue
from orderdetails 
join orders on orderdetails.ordernumber = orders.ordernumber
where orders.customernumber = custnum
group by customernumber;
end //
delimiter //

call gettotalordervalue(101);
