CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) NOT NULL,
    CHECK (role IN ('Admin', 'Customer'))
);
