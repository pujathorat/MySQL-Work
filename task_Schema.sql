-- Create Product Table
CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    description TEXT,
    SKU VARCHAR(50),
    category_id INT,
    inventory_id INT,
    price DECIMAL,
    discount_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Create Product_Category Table
CREATE TABLE Product_Category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Create Product_Inventory Table
CREATE TABLE Product_Inventory (
    id SERIAL PRIMARY KEY,
    quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Create Discount Table
CREATE TABLE Discount (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    description TEXT,
    discount_percent DECIMAL,
    active BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM Product;
SELECT * FROM Product_Category;
SELECT * FROM Product_Inventory;
SELECT * FROM Discount;

ALTER TABLE Product
ADD CONSTRAINT fk_product_category
FOREIGN KEY (category_id)
REFERENCES Product_Category(id);


