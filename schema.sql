DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE client (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  middle_name VARCHAR(20) NOT NULL,
  CPF CHAR(14) NOT NULL,
  phone_number CHAR(15) NOT NULL,
  email VARCHAR(50) NOT NULL,
  birth_date DATE NOT NULL,
  street VARCHAR(30) NOT NULL,
  neighborhood VARCHAR(30) NOT NULL,
  zip_code CHAR(9) NOT NULL,
  state VARCHAR(20) NOT NULL,
  city VARCHAR(20) NOT NULL,
  complement VARCHAR(50),
  CONSTRAINT client_unique_CPF UNIQUE (CPF)
);

CREATE TABLE wallet (
  client_id INT,
  type_card ENUM('CREDITO', 'DEBITO') NOT NULL,
  card_number CHAR(16) NOT NULL,
  expiration_date CHAR(5) NOT NULL,
  secret_number CHAR(3) NOT NULL,
  CONSTRAINT wallet_fk_client_id FOREIGN KEY (client_id) REFERENCES client (id)
);

CREATE TABLE product (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  category VARCHAR(20) NOT NULL,
  description VARCHAR(200) NOT NULL,
  assessment float DEFAULT (0),
  price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
  status ENUM('EM PROCESSO', 'EM TRANSPORTE', 'FINALIZADO'),
  client_id INT NOT NULL,
  description VARCHAR(200) NOT NULL,
  freight DECIMAL(5,2) DEFAULT(10.00),
  CONSTRAINT orders_fk_client_id FOREIGN KEY (client_id) REFERENCES client (id)
);

CREATE TABLE payment (
  orders_id INT PRIMARY KEY,
  type_payment ENUM('BOLETO', 'CREDITO', 'DEBITO', 'PIX') DEFAULT ('CREDITO'),
  status ENUM('FALHA', 'SUCESSO', 'EM PROGRESSO') DEFAULT('EM PROGRESSO'),
  CONSTRAINT payment_fk_orders FOREIGN KEY (orders_id) REFERENCES orders (id)
);

CREATE TABLE product_orders (
  product_id INT NOT NULL,
  orders_id INT NOT NULL,
  quantity INT UNSIGNED NOT NULL,
  PRIMARY KEY (product_id, orders_id),
  CONSTRAINT product_orders_fk_product_id FOREIGN KEY (product_id) REFERENCES product (id),
  CONSTRAINT product_orders_fk_orders_id FOREIGN KEY (orders_id) REFERENCES orders (id)
);

CREATE TABLE stock (
  id INT PRIMARY KEY AUTO_INCREMENT,
  street VARCHAR(30) NOT NULL,
  neighborhood VARCHAR(30) NOT NULL,
  zip_code CHAR(9) NOT NULL,
  state VARCHAR(20) NOT NULL,
  city VARCHAR(20) NOT NULL,
  complement VARCHAR(50)
);

CREATE TABLE in_stock (
  product_id INT,
  stock_id INT,
  quantity INT UNSIGNED,
  PRIMARY KEY (product_id, stock_id),
  CONSTRAINT in_stock_fk_stock_id FOREIGN KEY (stock_id) REFERENCES stock (id),
  CONSTRAINT in_stock_fk_product_id FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE supplier (
  id INT PRIMARY KEY AUTO_INCREMENT,
  corporate_name VARCHAR(30) NOT NULL,
  CNPJ CHAR(18) NOT NULL,
  phone_number CHAR(15) NOT NULL,
  CONSTRAINT supplier_unique_CNPJ UNIQUE (CNPJ)
);

CREATE TABLE product_provided (
  product_id INT,
  supplier_id INT,
  quantity INT NOT NULL,
  date_provide DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE seller (
  id INT PRIMARY KEY AUTO_INCREMENT,
  corporate_name VARCHAR(30) NOT NULL,
  email VARCHAR(50) NOT NULL,
  phone_number CHAR(15) NOT NULL,
  fantasy_name VARCHAR(20) NOT NULL,
  CNPJ CHAR(18) NOT NULL,
  CONSTRAINT seller_unique_CNPJ UNIQUE (CNPJ)
);

CREATE TABLE bank_account (
  seller_id INT PRIMARY KEY,
  bank VARCHAR(20) NOT NULL,
  agency VARCHAR(20) NOT NULL,
  account VARCHAR(20) NOT NULL,
  type_account ENUM('POUPANÇA', 'CORRENTE'),
  CPF CHAR(14) NOT NULL,
  CONSTRAINT bank_account_unique_CPF UNIQUE (CPF),
  CONSTRAINT bank_account_fk_seller_id FOREIGN KEY (seller_id) REFERENCES seller (id)
);

CREATE TABLE sales_history (
  seller_id INT,
  product_id INT,
  quantity INT UNSIGNED NOT NULL,
  sale_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (seller_id, product_id),
  CONSTRAINT sales_history_fk_seller_id FOREIGN KEY (seller_id) REFERENCES seller (id),
  CONSTRAINT sales_history_fk_product_id FOREIGN KEY (product_id) REFERENCES product (id)
);
