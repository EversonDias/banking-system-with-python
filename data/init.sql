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

-- populando o banco de dados

INSERT INTO client (first_name, last_name, middle_name, CPF, phone_number, email, birth_date, street, neighborhood, zip_code, state, city, complement)
VALUES
('João', 'Silva', 'Mendes', '000.000.000-00', '(00) 00000-0000', 'joao@email.com', '1990-01-15', 'Rua A', 'Centro', '12345-000', 'SP', 'São Paulo', NULL),
('Maria', 'Santos', 'Ferreira', '111.111.111-11', '(11) 11111-1111', 'maria@email.com', '1985-05-20', 'Rua B', 'Bairro X', '23456-000', 'RJ', 'Rio de Janeiro', 'Apto 101'),
('Pedro', 'Fernandes', 'Ribeiro', '222.222.222-22', '(22) 22222-2222', 'pedro@email.com', '1998-08-10', 'Av. C', 'Bairro Y', '34567-000', 'MG', 'Belo Horizonte', NULL),
('Ana', 'Oliveira', 'Sousa', '333.333.333-33', '(33) 33333-3333', 'ana@email.com', '1987-03-25', 'Rua D', 'Centro', '45678-000', 'PR', 'Curitiba', 'Apto 202'),
('Lucas', 'Rodrigues', 'Alves', '444.444.444-44', '(44) 44444-4444', 'lucas@email.com', '1995-12-01', 'Av. E', 'Bairro Z', '56789-000', 'BA', 'Salvador', NULL),
('Carla', 'Gomes', 'Silveira', '555.555.555-55', '(55) 55555-5555', 'carla@email.com', '1992-07-12', 'Rua F', 'Centro', '67890-000', 'PE', 'Recife', 'Casa 10'),
('Fernando', 'Martins', 'Lima', '666.666.666-66', '(66) 66666-6666', 'fernando@email.com', '1983-11-05', 'Av. G', 'Bairro W', '78901-000', 'SC', 'Florianópolis', NULL),
('Mariana', 'Almeida', 'Vieira', '777.777.777-77', '(77) 77777-7777', 'mariana@email.com', '1997-09-18', 'Rua H', 'Bairro X', '89012-000', 'RS', 'Porto Alegre', 'Apto 303'),
('Rafael', 'Pereira', 'Rocha', '888.888.888-88', '(88) 88888-8888', 'rafael@email.com', '1994-06-30', 'Av. I', 'Centro', '90123-000', 'GO', 'Goiânia', NULL),
('Isabela', 'Sousa', 'Santos', '999.999.999-99', '(99) 99999-9999', 'isabela@email.com', '2000-02-22', 'Rua J', 'Bairro Y', '01234-000', 'MT', 'Cuiabá', 'Apto 404');


INSERT INTO wallet (client_id, type_card, card_number, expiration_date, secret_number)
VALUES
(1, 'CREDITO', '1111111111111111', '12/25', '123'),
(2, 'DEBITO', '2222222222222222', '06/24', '456'),
(3, 'CREDITO', '3333333333333333', '09/23', '789'),
(4, 'DEBITO', '4444444444444444', '11/26', '012'),
(5, 'CREDITO', '5555555555555555', '03/27', '345'),
(6, 'DEBITO', '6666666666666666', '05/28', '678'),
(7, 'CREDITO', '7777777777777777', '07/22', '901'),
(8, 'DEBITO', '8888888888888888', '02/24', '234');


INSERT INTO product (name, category, description, assessment, price)
VALUES
('Camiseta Preta', 'Vestuário', 'Camiseta preta de algodão', 4.5, 29.99),
('Calça Jeans', 'Vestuário', 'Calça jeans azul clara', 4.2, 79.99),
('Tênis Esportivo', 'Calçados', 'Tênis esportivo para corrida', 4.8, 119.99),
('Bolsa de Couro', 'Acessórios', 'Bolsa de couro marrom com alça ajustável', 4.7, 89.99),
('Relógio Analógico', 'Acessórios', 'Relógio de pulso analógico dourado', 4.6, 149.99),
('Smartphone Android', 'Eletrônicos', 'Smartphone Android de última geração', 4.9, 699.99),
('Notebook Ultrabook', 'Eletrônicos', 'Notebook ultrabook com processador rápido', 4.4, 999.99),
('Fone de Ouvido Bluetooth', 'Eletrônicos', 'Fone de ouvido sem fio com conectividade Bluetooth', 4.3, 49.99),
('Câmera DSLR', 'Fotografia', 'Câmera DSLR profissional com lentes intercambiáveis', 4.8, 899.99),
('Livro Best-Seller', 'Livros', 'Livro de ficção best-seller', 4.7, 19.99);


INSERT INTO orders (status, client_id, description, freight)
VALUES
('EM PROCESSO', 1, 'Pedido de camisetas e calças', 15.00),
('EM TRANSPORTE', 2, 'Envio de tênis e bolsa', 12.50),
('FINALIZADO', 3, 'Entrega de smartphone e fone de ouvido', 8.00),
('EM TRANSPORTE', 4, 'Pedido de relógio e livro', 9.00),
('FINALIZADO', 5, 'Entrega de câmera e notebook', 10.00),
('EM PROCESSO', 6, 'Pedido de calças e fones de ouvido', 11.50),
('EM TRANSPORTE', 7, 'Envio de livro e bolsa', 13.00),
('FINALIZADO', 8, 'Entrega de tênis e smartphone', 10.00),
('EM TRANSPORTE', 9, 'Pedido de camisetas e notebook', 14.00),
('FINALIZADO', 10, 'Entrega de relógio e câmera', 8.50),
('EM PROCESSO', 10, 'Pedido de tênis e livro', 12.00),
('EM TRANSPORTE', 2, 'Envio de bolsa e smartphone', 9.50),
('FINALIZADO', 3, 'Entrega de fones de ouvido e calças', 11.00);


INSERT INTO payment (orders_id, type_payment, status)
VALUES
(1, 'CREDITO', 'SUCESSO'),
(2, 'BOLETO', 'EM PROGRESSO'),
(3, 'PIX', 'FALHA'),
(4, 'CREDITO', 'SUCESSO'),
(5, 'DEBITO', 'SUCESSO'),
(6, 'PIX', 'EM PROGRESSO'),
(7, 'BOLETO', 'SUCESSO'),
(8, 'DEBITO', 'SUCESSO'),
(9, 'CREDITO', 'EM PROGRESSO'),
(10, 'BOLETO', 'SUCESSO'),
(11, 'PIX', 'SUCESSO'),
(12, 'CREDITO', 'SUCESSO'),
(13, 'DEBITO', 'SUCESSO');


INSERT INTO product_orders (product_id, orders_id, quantity)
VALUES
(1, 1, 2),
(2, 1, 3),
(3, 2, 1),
(4, 2, 1),
(5, 3, 1),
(6, 3, 2),
(7, 4, 1),
(8, 4, 2),
(9, 5, 1),
(10, 5, 1),
(10, 6, 2),
(2, 6, 1),
(3, 7, 1);

INSERT INTO stock (street, neighborhood, zip_code, state, city, complement)
VALUES
('Rua F', 'Bairro W', '67890-000', 'PR', 'Curitiba', NULL),
('Rua G', 'Centro', '78900-100', 'SP', 'São Paulo', 'Loja 101');

INSERT INTO in_stock (product_id, stock_id, quantity)
VALUES
(1, 1, 50),
(2, 1, 30),
(3, 2, 20),
(4, 2, 15),
(5, 1, 40),
(6, 1, 25),
(7, 2, 10),
(8, 2, 5),
(9, 1, 60),
(10, 1, 35);

INSERT INTO supplier (corporate_name, CNPJ, phone_number)
VALUES
('Fornecedor A', '00.111.222/0001-11', '(11) 11111-1111'),
('Fornecedor B', '11.222.333/0001-22', '(22) 22222-2222'),
('Fornecedor C', '22.333.444/0001-33', '(33) 33333-3333'),
('Fornecedor D', '33.444.555/0001-44', '(44) 44444-4444'),
('Fornecedor E', '44.555.666/0001-55', '(55) 55555-5555');


INSERT INTO product_provided (product_id, supplier_id, quantity, date_provide)
VALUES
(1, 1, 100, '2023-05-01 10:00:00'),
(2, 1, 50, '2023-04-02 11:30:00'),
(3, 2, 75, '2023-08-03 09:15:00'),
(4, 2, 30, '2023-08-04 14:20:00'),
(5, 3, 120, '2023-08-05 12:45:00'),
(6, 3, 60, '2023-08-06 16:10:00'),
(7, 4, 25, '2023-08-07 08:30:00'),
(8, 4, 15, '2023-07-08 13:00:00'),
(9, 5, 90, '2023-01-09 10:45:00'),
(10, 5, 40, '2023-03-10 15:30:00'),
(1, 1, 55, '2023-05-11 09:50:00'),
(2, 2, 70, '2023-04-12 11:00:00');

INSERT INTO seller (corporate_name, email, phone_number, fantasy_name, CNPJ)
VALUES
('Vendedor Autônomo A', 'vendedor_a@example.com', '(11) 11111-1111', 'Fantasia A', '00.111.222/0001-11'),
('Vendedor Autônomo B', 'vendedor_b@example.com', '(22) 22222-2222', 'Fantasia B', '11.222.333/0001-22'),
('Vendedor Autônomo C', 'vendedor_c@example.com', '(33) 33333-3333', 'Fantasia C', '22.333.444/0001-33'),
('Vendedor Autônomo D', 'vendedor_d@example.com', '(44) 44444-4444', 'Fantasia D', '33.444.555/0001-44'),
('Vendedor Autônomo E', 'vendedor_e@example.com', '(55) 55555-5555', 'Fantasia E', '44.555.666/0001-55');

INSERT INTO bank_account (seller_id, bank, agency, account, type_account, CPF)
VALUES
(1, 'Banco A', '1234', '56789-0', 'CORRENTE', '000.000.000-00'),
(2, 'Banco B', '5678', '12345-6', 'POUPANÇA', '111.111.111-11'),
(3, 'Banco C', '9876', '54321-0', 'CORRENTE', '222.222.222-22'),
(4, 'Banco D', '4321', '98765-4', 'CORRENTE', '333.333.333-33'),
(5, 'Banco E', '8765', '43210-8', 'POUPANÇA', '444.444.444-44');

INSERT INTO sales_history (seller_id, product_id, quantity, sale_date)
VALUES
(1, 1, 10, '2023-05-01 10:00:00'),
(1, 2, 5, '2023-04-02 11:30:00'),
(2, 3, 8, '2023-08-03 09:15:00'),
(2, 4, 3, '2023-08-04 14:20:00'),
(3, 5, 15, '2023-08-05 12:45:00'),
(3, 6, 7, '2023-08-06 16:10:00'),
(4, 7, 2, '2023-08-07 08:30:00'),
(4, 8, 4, '2023-07-08 13:00:00'),
(5, 9, 12, '2023-01-09 10:45:00'),
(5, 10, 6, '2023-03-10 15:30:00');
