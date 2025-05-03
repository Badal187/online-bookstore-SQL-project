

create table books1(
 Book_ID int primary key,
 Title varchar(100),
 Author varchar(100),
 Genre varchar(100),
 Published_Year int,
 Price numeric(10 ,2),
 Stock int
)

select * from books1

copy
books1(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
from 'D:\sql books project\Books (1).csv'
DELIMITER ','
CSV HEADER;


create table customer1(
 Customer_ID int primary key,
 Name varchar (100),
 Email varchar(255),
 Phone varchar(100),
 City varchar(100),
 Country varchar(100)
)

select * from customer1

copy
customer1(Customer_ID,Name,Email,Phone,City,Country)
from 'D:\sql books project\Customers (1).csv'
DELIMITER ','
CSV HEADER;

create table orders1(
 Order_ID int primary key,
 Customer_ID int ,
 Book_ID int ,
 Order_Date date,
 Quantity int,
 Total_Amount numeric(10,2)
)
select * from orders1

copy
orders1 (Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
from 'D:\sql books project\Orders (1).csv'


 -- Add reference to Customer_ID
ALTER TABLE orders1
ADD CONSTRAINT fk_customer
FOREIGN KEY (Customer_ID)
REFERENCES customer1(Customer_ID);

-- Add reference to Book_ID
ALTER TABLE orders1
ADD CONSTRAINT fk_book
FOREIGN KEY (Book_ID)
REFERENCES books1(Book_ID);


--1) Retrieve all books in "fiction" genre:
    select * from books1
	 where genre ='Fiction'

--2) find books published after year 1950
    select * from books1
	 where published_year > 1950
	 
--3) List All the customers from the Canda 
    select * from  customer1
	 where country = 'Canada'

--4) show orders placed in november 2023
   select * from orders1
    where order_date between '2023-11-01' and '2023-11-30'
   
--5) Retrieved the total stock of books availble
   select sum(stock) as total_stock
   from books1

--6) find the details of most expensive book
    select * from books1 order by price desc limit 1 

--7) Show all customers who orderered more than 1 quantity of a book 
      select * from orders1 
	   where quantity>1
	   
--8)  Retrieve all orders where the total amount exceeds $20 
     select * from orders1  
	  where total_amount>20

--9) List all the genres availbe in the books table 
   select distinct genre
   from books1

--10) find the books with the lowest stock 
   select * from books1 order by stock limit 1

--11) calcuated  the Total revenue generated from all orders 
    select sum(total_amount) as Total_revenue
	from orders1


-- Advance question 

--1)  retrieve the total number of books sold for each genre 

	  select b.genre , sum(o.quantity) as total_books_sold
	  from orders1 o
	  join books1 b on o.book_id = b.book_id
	  group by b.genre;

--2) find the average price of books in the fantasy genre
      select avg(price) as average_price_of_fantasy
	  from books1
	  where genre = 'Fantasy'

--3) list customers who have placed at least 2 orders 
   select customer_id, count(order_id) as order_count
   from orders1 
   group by customer_id
   having count(order_id) >=2

--4) find the most frequently ordered book
   select o.book_id , b.Title, count(o.order_id) as Order_count
   from orders1 o
   join books1 b on o.book_id = b.book_id
   group by o.book_id , b.title
   order by Order_count desc

 --5) show the top 3  most expensive books of fantasy genre
    select * from books1
	where genre='Fantasy'
	order by price desc limit 3

--6) Retrieve the total quantity of books sold by each author 
     select b.author , sum(o.quantity) as total_books_sold
	 from orders1 o
	 join books1 b on o.book_id=b.book_id
	 group by author

--7) List of cities where customers who spent over $30 are located
    SELECT DISTINCT c.city, o.total_amount
FROM orders1 o
JOIN customer1 c ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;

--8) find the customers who spends most on orders
  select c.customer_id , c.name , sum(o.total_amount) as total_spend
  from orders1 o
  join customer1 c on o.customer_id = c.customer_id
  group by c.customer_id , c.name
  order by total_spend desc
  
  

  
 