CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) NOT NULL,
    CHECK (role IN ('Admin', 'Customer'))
);

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


CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,

    CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled')),

    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id),

    CONSTRAINT fk_vehicle
        FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id)
);


INSERT INTO users (user_id, name, email, password, phone, role) VALUES
(1, 'Alice', 'alice@example.com', 'pass123', '1234567890', 'Customer'),
(2, 'Bob', 'bob@example.com', 'pass234', '0987654321', 'Admin'),
(3, 'Charlie', 'charlie@example.com', 'pass345', '1122334455', 'Customer'),
(4, 'David', 'david@example.com', 'pass456', '2233445566', 'Customer'),
(5, 'Emma', 'emma@example.com', 'pass567', '3344556677', 'Customer'),
(6, 'Frank', 'frank@example.com', 'pass678', '4455667788', 'Admin'),
(7, 'Grace', 'grace@example.com', 'pass789', '5566778899', 'Customer'),
(8, 'Helen', 'helen@example.com', 'pass890', '6677889900', 'Customer'),
(9, 'Ian', 'ian@example.com', 'pass901', '7788990011', 'Customer'),
(10, 'Jack', 'jack@example.com', 'pass012', '8899001122', 'Customer');


INSERT INTO vehicles (vehicle_id, name, type, model, registration_number, rental_price, status) VALUES
(1, 'Toyota Corolla', 'car', 2022, 'ABC-123', 50, 'available'),
(2, 'Honda Civic', 'car', 2021, 'DEF-456', 60, 'rented'),
(3, 'Yamaha R15', 'bike', 2023, 'GHI-789', 30, 'available'),
(4, 'Ford F-150', 'truck', 2020, 'JKL-012', 100, 'maintenance'),
(5, 'Suzuki Swift', 'car', 2022, 'MNO-345', 45, 'available'),
(6, 'Kawasaki Ninja', 'bike', 2021, 'PQR-678', 35, 'rented'),
(7, 'Isuzu D-Max', 'truck', 2019, 'STU-901', 90, 'available'),
(8, 'Tesla Model 3', 'car', 2023, 'VWX-234', 120, 'available'),
(9, 'BMW X5', 'car', 2020, 'YZA-567', 110, 'rented'),
(10, 'Hero Splendor', 'bike', 2022, 'BCD-890', 20, 'available');



INSERT INTO bookings (booking_id, user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', 100),
(5, 4, 2, '2024-01-05', '2024-01-07', 'completed', 120),
(6, 5, 5, '2024-01-10', '2024-01-12', 'confirmed', 90),
(7, 6, 6, '2024-01-15', '2024-01-18', 'completed', 105),
(8, 7, 8, '2024-02-01', '2024-02-03', 'pending', 240),
(9, 8, 9, '2024-02-10', '2024-02-12', 'completed', 220),
(10, 9, 2, '2024-02-20', '2024-02-22', 'confirmed', 120);


SELECT
    bookings.booking_id,
    users.name AS customer_name,
    vehicles.name AS vehicle_name
  
FROM bookings
INNER JOIN users
    ON bookings.user_id = users.user_id
INNER JOIN vehicles
    ON bookings.vehicle_id = vehicles.vehicle_id;



SELECT
    vehicles.vehicle_id,
    vehicles.name,
    vehicles.type,
    vehicles.model,
    vehicles.registration_number,
    vehicles.rental_price,
    vehicles.status
FROM vehicles
WHERE NOT EXISTS (
    SELECT *
    FROM bookings
    WHERE bookings.vehicle_id = vehicles.vehicle_id
);
