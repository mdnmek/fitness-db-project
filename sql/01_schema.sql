CREATE TABLE training_types (
    training_type_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 2. Основные сущности
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    birth_date DATE,
    address TEXT
);

CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    address TEXT,
    birth_date DATE,
    hire_date DATE NOT NULL,
    salary NUMERIC(10, 2) CHECK (salary >= 0)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) CHECK (price >= 0),
    stock_quantity INT CHECK (stock_quantity >= 0)
);

-- 3. Абонементы
CREATE TABLE memberships (
    membership_id SERIAL PRIMARY KEY,
    training_type_id INT REFERENCES training_types(training_type_id),
    service_id INT REFERENCES services(service_id),
    price NUMERIC(10, 2) CHECK (price >= 0),
    visits_limit INT CHECK (visits_limit >= 0),
    duration_days INT CHECK (duration_days > 0)
);

-- 4. Транзакционные таблицы
CREATE TABLE membership_sales (
    sale_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(client_id),
    membership_id INT REFERENCES memberships(membership_id),
    card_number VARCHAR(50) UNIQUE NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    visits_left INT CHECK (visits_left >= 0)
);

CREATE TABLE schedule (
    schedule_id SERIAL PRIMARY KEY,
    staff_id INT REFERENCES staff(staff_id),
    service_id INT REFERENCES services(service_id),
    training_type_id INT REFERENCES training_types(training_type_id),
    class_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

CREATE TABLE attendance (
    visit_id SERIAL PRIMARY KEY,
    sale_id INT REFERENCES membership_sales(sale_id),
    schedule_id INT REFERENCES schedule(schedule_id),
    visit_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_sales (
    product_sale_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(client_id),
    product_id INT REFERENCES products(product_id),
    quantity INT CHECK (quantity > 0),
    sale_date DATE DEFAULT CURRENT_DATE
);