CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

CREATE TABLE IF NOT EXISTS Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT IGNORE INTO Users (name, email, createdAt, updatedAt) VALUES
('Alice', 'alice@example.com', NOW(), NOW()),
('Bob', 'bob@example.com', NOW(), NOW()),
('Charlie', 'charlie@example.com', NOW(), NOW());