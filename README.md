# 🚗 Car Rental SQL Analysis
**by Christian Kho Aler**

A SQL analysis project using a Philippine-based car and motorcycle rental dataset. This project demonstrates real-world data analysis techniques using MySQL including CTEs, Window Functions, Aggregations, and Subqueries.

---

## 📁 Dataset

Two tables were used in this analysis:

### `cars` (30 rows)
Contains vehicle information including cars and motorcycles available for rent in the Philippines.

| Column | Type | Description |
|--------|------|-------------|
| car_id | INT | Primary key |
| make | VARCHAR | Brand (e.g. Toyota, Honda, Yamaha) |
| model | VARCHAR | Model name (e.g. Vios, PCX, Aerox) |
| year | INT | Year of the unit |
| color | VARCHAR | Color of the vehicle |
| plate_number | VARCHAR | PH plate number |
| daily_rate | DECIMAL | Daily rental rate in PHP |
| vehicle_type | VARCHAR | Either `car` or `motorcycle` |
| status | VARCHAR | available / rented / maintenance |

### `rentals` (210 rows)
Contains rental transaction records with customer and payment details.

| Column | Type | Description |
|--------|------|-------------|
| rental_id | INT | Primary key |
| car_id | INT | Foreign key → cars |
| customer_name | VARCHAR | Full name of customer |
| customer_email | VARCHAR | Customer email |
| customer_phone | VARCHAR | PH mobile number |
| customer_city | VARCHAR | Customer's city |
| start_date | DATE | Rental start date |
| end_date | DATE | Rental end date |
| rental_days | INT | Number of days rented |
| daily_rate | DECIMAL | Rate per day in PHP |
| total_amount | DECIMAL | Total rental cost in PHP |
| payment_status | VARCHAR | paid / pending / cancelled |
| pickup_location | VARCHAR | Pickup city |
| dropoff_location | VARCHAR | Dropoff city |

---

## 🔍 Analysis Queries

### 💰 Profitability
- **Top 10 Most Profitable Vehicles** — Ranks vehicles by total confirmed revenue (paid transactions only)
- **Top 10 Least Profitable Vehicles** — Identifies underperforming vehicles using ascending rank
- **Year/Monthly Profit** — Breaks down revenue by year and month
- **Total Profit Per Year** — Annual revenue summary
- **Running Total Profit Per Year** — Cumulative monthly revenue that resets each year

### 🏍️ Vehicle Performance
- **Most Rented Vehicle** — Counts confirmed rentals per vehicle (paid only)
- **Vehicle Type Total Rent** — Compares total rentals between cars and motorcycles
- **Average Rental Days Per Vehicle** — Shows which vehicles are rented for longer periods

### 🎨 Customer Preferences
- **Color Preference Per Model** — Shows which colors are most rented with percentage rate
- **Top 3 Color Preferences** — Overall top 3 most rented colors across all vehicles

### 👥 Customer Behavior
- **Customers Who Rent Multiple Times** — Identifies repeat/loyal customers
- **Customers Per City** — Reveals which cities generate the most rental activity

### 💳 Transactions
- **Payment Status Breakdown** — Distribution of paid, pending, and cancelled transactions

---

## 🛠️ SQL Concepts Used

| Concept | Usage |
|--------|-------|
| `CTE` | Organizing complex ranking queries |
| `DENSE_RANK()` | Ranking vehicles by profit and rental count |
| `SUM() OVER()` | Running total / cumulative revenue |
| `GROUP BY` + `HAVING` | Filtering aggregated results |
| `JOIN` | Combining cars and rentals tables |
| Subquery in `SELECT` | Calculating percentage rates |
| `YEAR()` / `MONTH()` | Extracting date parts for time-based analysis |
| `ROUND()` | Formatting decimal outputs |

---

## 💡 Key Design Decisions

- **`end_date` used for revenue reporting** instead of `start_date` — because payment is only confirmed once the rental is completed, not when it starts.
- **`WHERE payment_status = "Paid"`** applied consistently on all revenue and rental count queries to ensure only confirmed transactions are counted.
- **`DENSE_RANK()`** chosen over `RANK()` to avoid gaps in ranking when vehicles have equal values.

---

## 🚀 How to Use

1. Import `cars.csv` first
2. Import `rentals.csv` second (requires `car_id` foreign key from cars)
3. Run `car_rental_analysis.sql` in MySQL Workbench or any MySQL client

```sql
-- Quick setup
CREATE DATABASE car_rental;
USE car_rental;
-- Then import both CSV files and run the analysis
```

---

## 📌 Tools Used
- **MySQL** — Query language
- **MySQL Workbench** — SQL editor and database management

---

## 👤 Author
**Christian Kho Aler**  
Aspiring Data Analyst
