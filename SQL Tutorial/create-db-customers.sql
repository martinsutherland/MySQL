CREATE DATABASE IF NOT EXISTS store;

USE store;

CREATE TABLE IF NOT EXISTS customer_details (
  customer_id VARCHAR(255) NOT NULL PRIMARY KEY,
  firstName VARCHAR(255) NOT NULL,
  lastName VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL
);



CREATE TABLE IF NOT EXISTS finance_details (
  customer_id VARCHAR(255) NOT NULL PRIMARY KEY,
  sortCode VARCHAR(255) NOT NULL,
  accountNumber VARCHAR(255) NOT NULL,
  accountType VARCHAR(255) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer_details(customer_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS orders (
  order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_id VARCHAR(255) NOT NULL,
  item VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer_details (customer_id) ON DELETE CASCADE
);
