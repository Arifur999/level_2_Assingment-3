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


