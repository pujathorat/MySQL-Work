-- Create Authors Table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255)
);

-- Create Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    author_id INT,
    genre VARCHAR(255),
    publication_date DATE,
    isbn VARCHAR(13),
    quantity_available INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Create Members Table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    member_name VARCHAR(255),
    member_email VARCHAR(255),
    member_phone VARCHAR(15)
);

-- Create Borrowings Table
CREATE TABLE Borrowings (
    borrowing_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrowing_date DATE,
    return_date DATE,
    is_returned BOOLEAN,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Create Publishers Table
CREATE TABLE Publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255),
    publisher_country VARCHAR(255)
);

-- Create Book Copies Table
CREATE TABLE BookCopies (
    copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    copy_number VARCHAR(10),
    `condition` VARCHAR(50), -- Enclosing "condition" in backticks
    shelf_location VARCHAR(50),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Create Authors-Books Mapping Table
CREATE TABLE AuthorsBooks (
    author_book_id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    book_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Create Reviews Table
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    rating FLOAT,
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Create Transactions Table
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(50),
    amount_paid DECIMAL(10, 2),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);
-- Inserting data into the Books table
INSERT INTO Books (book_id,title, author_id, genre, publication_date, isbn, quantity_available)
VALUES 
    (1,'Harry Potter', 1, 'Fantasy', '1997-06-26', '9788700631625', 5),
    (2,'To Kill a Mockingbird', 2, 'Fiction', '1960-07-11', '9780061120084', 3),
    (3,'The Great Gatsby', 3, 'Classic', '1925-04-10', '9780743273565', 2);
-- Inserting data into the Authors table
INSERT INTO Authors (author_id, author_name)
VALUES 
    (1, 'J.K. Rowling'),
    (2, 'Harper Lee'),
    (3,  'F. Scott Fitzgerald');
-- Inserting data into the Members table
INSERT INTO Members (member_id, member_name, member_email, member_phone)
VALUES 
    (1,'John Doe', 'john.doe@example.com', '123-456-7890'),
    (2, 'Jane Smith', 'jane.smith@example.com', '987-654-3210');
-- Inserting data into the Borrowings table
INSERT INTO Borrowings (book_id, member_id, borrowing_id,   borrowing_date, return_date, is_returned)
VALUES 
    (1, 1, 1, '2024-02-10', '2024-02-20', TRUE),
    (2, 2, 2, '2024-02-15', NULL, FALSE);
-- Inserting data into the Publishers table
INSERT INTO Publishers (publisher_name, publisher_country)
VALUES 
    ('Penguin Random House', 'United States'),
    ('HarperCollins', 'United Kingdom');
-- Inserting data into the BookCopies table
INSERT INTO BookCopies (book_id, copy_number, `condition`, shelf_location)
VALUES 
    (1, '001', 'Good', 'A1'),
    (1, '002', 'Fair', 'B3');
-- Inserting data into the AuthorsBooks table
INSERT INTO AuthorsBooks (author_id, book_id)
VALUES 
    (1, 1),
    (2, 2);
-- Inserting data into the Reviews table
INSERT INTO Reviews (book_id, member_id, rating, review_text, review_date)
VALUES 
    (1, 1, 4.5, 'A classic masterpiece.', '2024-02-12'),
    (2, 2, 5.0, 'Absolutely loved it!', '2024-02-18');
-- Inserting data into the Transactions table
INSERT INTO Transactions (member_id, transaction_date, transaction_type, amount_paid)
VALUES 
    (1, '2024-02-10', 'Borrow', 0),
    (2, '2024-02-15', 'Borrow', 0);
    -- Question1-Ans
    SELECT Books.title 
FROM Books
JOIN Borrowings ON Books.book_id = Borrowings.book_id
WHERE Borrowings.member_id = 1; -- Replace 1 with the actual member_id
-- Question-2 answer
SELECT genre, COUNT(*) AS count
FROM Books
GROUP BY genre
ORDER BY count DESC;

-- Question-3 answer
SELECT Books.title, AVG(Reviews.rating) AS average_rating
FROM Books
LEFT JOIN Reviews ON Books.book_id = Reviews.book_id
GROUP BY Books.book_id
ORDER BY average_rating DESC;

-- Question4-answer
SELECT Members.member_name
FROM Members
JOIN Borrowings ON Members.member_id = Borrowings.member_id
GROUP BY Members.member_id
HAVING COUNT(*) > 5;

-- Question-5 answer
SELECT Members.member_name
FROM Members
JOIN Borrowings ON Members.member_id = Borrowings.member_id
GROUP BY Members.member_id
HAVING COUNT(*) < 5;

-- Question-6- answer
SELECT Books.title, AVG(Reviews.rating) AS average_rating, COUNT(*) AS review_count
FROM Books
LEFT JOIN Reviews ON Books.book_id = Reviews.book_id
GROUP BY Books.book_id
HAVING review_count >= 5
ORDER BY average_rating DESC;

-- Question-7 -answer
SELECT SUM(amount_paid) AS total_revenue
FROM Transactions
WHERE transaction_type = 'Purchase';

-- Question-8 -answer
SET SQL_SAFE_UPDATES = 0;
UPDATE Books
SET publisher_id = (
    SELECT publisher_id
    FROM Publishers
    WHERE publisher_name = 'Penguin Random House'
)
WHERE title = 'Harry Potter'; -- Replace 'Harry Potter' with the appropriate book title
DESCRIBE Books;

SELECT Books.title, Authors.author_name, Publishers.publisher_name
FROM Books
JOIN Authors ON Books.author_id = Authors.author_id
JOIN Publishers ON Books.publisher_id = Publishers.publisher_id;
-- Question9 -answer
SELECT title
FROM Books
WHERE quantity_available > 0;

-- Question 10 -answer
SELECT member_id
FROM Borrowings
WHERE return_date < CURRENT_DATE AND is_returned = FALSE;

-- Question 11-answer
SELECT Books.title, COUNT(*) AS borrow_count
FROM Books
JOIN Borrowings ON Books.book_id = Borrowings.book_id
GROUP BY Books.book_id
ORDER BY borrow_count DESC
LIMIT 10;

-- Question 12 -answer
SELECT AVG(DATEDIFF(return_date, borrowing_date)) AS average_borrow_duration
FROM Borrowings
WHERE is_returned = TRUE;

-- Question 13 -answer
SELECT YEAR(publication_date) AS publication_year, COUNT(*) AS book_count
FROM Books
GROUP BY YEAR(publication_date);

-- Question14 -answer
SELECT member_id, COUNT(*) AS borrow_count
FROM Borrowings
GROUP BY member_id
HAVING borrow_count > 1;

-- Question 15 -answer
SELECT Books.title, Authors.author_name, AVG(Reviews.rating) AS average_rating
FROM Books
JOIN Authors ON Books.author_id = Authors.author_id
LEFT JOIN Reviews ON Books.book_id = Reviews.book_id
GROUP BY Books.book_id;


-- Question-16 -answer
SELECT Books.title, COUNT(*) AS copy_count
FROM Books
JOIN BookCopies ON Books.book_id = BookCopies.book_id
GROUP BY Books.book_id;

-- Question-17 -answer
CREATE VIEW TransactionView AS
SELECT member_id, transaction_date
FROM Transactions;
-- Grant SELECT privilege to another user
GRANT SELECT ON TransactionView TO puja;



