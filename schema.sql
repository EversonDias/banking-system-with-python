DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE client (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  middle_name VARCHAR(20) NOT NULL,
  CPF CHAR(11) NOT NULL,
  birth_date DATE NOT NULL,
  street VARCHAR(30) NOT NULL,
  neighborhood VARCHAR(30) NOT NULL,
  zip_code CHAR(9) NOT NULL,
  state VARCHAR(20) NOT NULL,
  city VARCHAR(20) NOT NULL,
  complement VARCHAR(50),
  CONSTRAINT client_unique_CPF UNIQUE (CPF)
);

CREATE TABLE product (
  id INT PRIMARY KEY AUTO_INCREMENT,
  category VARCHAR(20) NOT NULL,
  description VARCHAR(200) NOT NULL,
  price DECIMAL(10,2) NOT NULL
);

CREATE TABLE req (
	id INT PRIMARY KEY AUTO_INCREMENT,
  status ENUM('in progress', 'processing', 'sent', 'delivered'),
  client_id INT NOT NULL,
  description VARCHAR(200) NOT NULL,
  freight DECIMAL(10,2) NOT NULL,
  CONSTRAINT req_fk_client_id FOREIGN KEY (client_id) REFERENCES client (id)
);

CREATE TABLE product_order (
  product_id INT NOT NULL,
  req_id INT NOT NULL,
  quantity INT NOT NULL UNSIGNED,
  status ENUM('available', 'unavailable'),
  PRIMARY KEY (product_id, req_id),
  CONSTRAINT product_order_unsigned_quantity UNSIGNED (quantity),
  CONSTRAINT product_order_fk_product_id FOREIGN KEY (product_id) REFERENCES product (id),
  CONSTRAINT product_order_fk_req_id FOREIGN KEY (req_id) REFERENCES req (id)
);