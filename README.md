
# 📚 Online Bookstore Database Project (PostgreSQL)

This project is a simple SQL-based relational database model for an online bookstore. It demonstrates data modeling, SQL queries, joins, and basic analytics using PostgreSQL and CSV data import.

## 📂 Files Included

- `online-book-store.sql`: SQL script to create and populate the database.
- `Books.csv`: Book data including title, author, genre, and price.
- `Customers.csv`: Customer details like name, email, phone, and city.
- `Orders.csv`: Order transactions linking customers and books.

## 🧱 Tables Used

- `books1`
- `customers1`
- `orders1`

## 🔧 Key Features

- Use of foreign keys and table relationships.
- Aggregation queries (AVG, COUNT).
- Joins across multiple tables.
- Filtering, sorting, and grouping operations.
- Real-world CSV data import using `COPY`.

## 🧪 Technologies Used

- PostgreSQL
- SQL
- CSV
- pgAdmin / psql

## ✅ Sample Queries

```sql
-- Average book price for Fantasy genre
SELECT AVG(price) FROM books1 WHERE genre = 'Fantasy';

-- Total orders per book
SELECT b.title, COUNT(o.order_id) AS order_count
FROM orders1 o
JOIN books1 b ON o.book_id = b.book_id
GROUP BY b.title
ORDER BY order_count DESC;
