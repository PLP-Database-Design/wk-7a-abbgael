-- ===========================================================
-- Question 1: Achieving 1NF (First Normal Form) 🛠️
-- ===========================================================
-- Problem: 'Products' column contains multiple values (comma-separated)
-- Solution: Break down each product into a separate row

-- Assuming an original raw table called ProductDetail:
-- This would be your initial structure (just for context, not to run):
-- CREATE TABLE ProductDetail (
--     OrderID INT,
--     CustomerName VARCHAR(100),
--     Products VARCHAR(255)
-- );

-- 1NF-compliant table:
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert normalized data (one product per row)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Now the table satisfies 1NF: no multivalued columns


-- ===========================================================
-- Question 2: Achieving 2NF (Second Normal Form) 🧩
-- ===========================================================
-- Problem: 'CustomerName' depends only on 'OrderID', not the full composite key (OrderID, Product)
-- Solution: Split into two tables:
--     - Orders (OrderID, CustomerName)
--     - OrderDetails (OrderID, Product, Quantity)

-- Create Orders table (stores data dependent only on OrderID)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Create OrderDetails table (stores data dependent on full key: OrderID + Product)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert data into OrderDetails
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Now the schema satisfies 2NF: all non-key attributes depend on the whole primary key
