CREATE DATABASE LibraryManagement;
USE LibraryManagement;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO authors (author_name)
VALUES 
('Тарас Шевченко'),
('Леся Українка');

INSERT INTO genres (genre_name)
VALUES 
('Поезія'),
('Драма');

INSERT INTO users (username, email)
VALUES 
('reader_katya', 'katya@example.com'),
('reader_oleh', 'oleh@example.com');


INSERT INTO books (title, publication_year, author_id, genre_id)
VALUES 
('Кобзар', 1901, 1, 1),
('Бояриня', 1910, 2, 2);

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date)
VALUES 
(1, 1, '2024-04-01', '2024-04-15'),
(2, 2, '2024-04-03', '2024-04-17');

SELECT 
    b.title,
    b.publication_year,
    a.author_name,
    g.genre_name
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN genres g ON b.genre_id = g.genre_id;

SELECT 
    b.title,
    b.publication_year,
    a.author_name,
    g.genre_name,
    u.username,
    bb.borrow_date,
    bb.return_date
FROM borrowed_books bb
JOIN books b ON bb.book_id = b.book_id
JOIN authors a ON b.author_id = a.author_id
JOIN genres g ON b.genre_id = g.genre_id
JOIN users u ON bb.user_id = u.user_id;


