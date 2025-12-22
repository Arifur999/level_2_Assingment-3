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
