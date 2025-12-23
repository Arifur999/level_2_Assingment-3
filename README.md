# 🚗 Vehicle Rental System – Database Design & SQL Queries

repo link: https://github.com/Arifur999/level_2_Assingment-3

## 📌 Overview
This project represents a simplified **Vehicle Rental System** designed to demonstrate database design, ERD relationships, and basic SQL querying techniques.  
The system manages users, vehicles, and bookings while maintaining proper relationships using primary keys and foreign keys.

This assignment focuses on:
- ERD design and relationships
- Writing basic SQL queries using JOIN, EXISTS, WHERE, GROUP BY, and HAVING
- Understanding relational database concepts

---

## 🎯 Objectives
By completing this project, I was able to:
- Design an ERD with one-to-many and logical one-to-one relationships
- Use primary keys and foreign keys correctly
- Write SQL queries using INNER JOIN, NOT EXISTS, WHERE, GROUP BY, and HAVING
- Work with PostgreSQL-compatible SQL syntax

---

## 🗂️ Database Tables

### 1️⃣ Users Table
Stores user information including role and contact details.

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) NOT NULL,
    CHECK (role IN ('Admin', 'Customer'))
);

```

Vehicles Table

Stores vehicle details and availability status.

```
CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL,
    model INT,
    registration_number VARCHAR(50) NOT NULL UNIQUE,
    rental_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    CHECK (type IN ('car', 'bike', 'truck')),
    CHECK (status IN ('available', 'rented', 'maintenance'))
);
```
Bookings Table

Stores booking details and links users with vehicles.

```
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled')),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

```

ERD Relationships

Users → Bookings: One-to-Many
A user can make multiple bookings.

Vehicles → Bookings: One-to-Many
A vehicle can be booked multiple times.

Logical One-to-One:
Each booking is associated with exactly one user and one vehicle.

 Lucidchart ERD Link:
[https://lucid.app/lucidchart/fed6b9d2-e7f0-4fc8-9044-de63e34ce016](https://lucid.app/lucidchart/fed6b9d2-e7f0-4fc8-9044-de63e34ce016/edit?viewport_loc=-2443%2C-1732%2C4655%2C2056%2C0_0&invitationId=inv_7125a5c0-720f-4c8d-a684-8fd0db726663)



Sample Data (Demo)
Users

```
INSERT INTO users VALUES
(1, 'Alice', 'alice@example.com', 'pass123', '1234567890', 'Customer'),
(2, 'Bob', 'bob@example.com', 'pass234', '0987654321', 'Admin'),
(3, 'Charlie', 'charlie@example.com', 'pass345', '1122334455', 'Customer');
```
Vehicles

```
INSERT INTO vehicles VALUES
(1, 'Toyota Corolla', 'car', 2022, 'ABC-123', 50, 'available'),
(2, 'Honda Civic', 'car', 2021, 'DEF-456', 60, 'rented'),
(3, 'Yamaha R15', 'bike', 2023, 'GHI-789', 30, 'available'),
(4, 'Ford F-150', 'truck', 2020, 'JKL-012', 100, 'maintenance');
```
Bookings

```
INSERT INTO bookings VALUES
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', 100);

```
SQL Queries
Query 1: INNER JOIN

Retrieve booking information with customer and vehicle names.
```
SELECT
    bookings.booking_id,
    users.name AS customer_name,
    vehicles.name AS vehicle_name,
    bookings.start_date,
    bookings.end_date,
    bookings.status
FROM bookings
INNER JOIN users
    ON bookings.user_id = users.user_id
INNER JOIN vehicles
    ON bookings.vehicle_id = vehicles.vehicle_id;

```
Query 2: NOT EXISTS

Find vehicles that have never been booked.
```
SELECT *
FROM vehicles
WHERE NOT EXISTS (
    SELECT *
    FROM bookings
    WHERE bookings.vehicle_id = vehicles.vehicle_id
);
```

Query 3: WHERE

Retrieve all available cars.
```
SELECT *
FROM vehicles
WHERE type = 'car'
  AND status = 'available';

```
Query 4: GROUP BY & HAVING

Find vehicles with more than two bookings.

```
SELECT
    vehicles.name AS vehicle_name,
    COUNT(bookings.booking_id) AS total_bookings
FROM bookings
INNER JOIN vehicles
    ON bookings.vehicle_id = vehicles.vehicle_id
GROUP BY vehicles.name
HAVING COUNT(bookings.booking_id) > 2;
```

Conclusion

This project demonstrates a complete and functional database design for a vehicle rental system.
The ERD clearly represents relationships, and all SQL queries produce the expected results using basic SQL concepts.
