DROP DATABASE IF EXISTS db_manager;
CREATE DATABASE db_manager;

USE db_manager;

CREATE TABLE job (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  role VARCHAR(50) NOT NULL,
  contract_type VARCHAR(15) NOT NULL
);

CREATE TABLE employee (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  job_id INT NOT NULL,
  address VARCHAR(255) NOT NULL,
  phone_number CHAR(15) NOT NULL,
  salary DECIMAL(7,2),
  admission_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT employee_fk_job_id FOREIGN KEY (job_id) REFERENCES job(id)
);

CREATE TABLE credential (
  employee_id INT NOT NULL PRIMARY KEY,
  email VARCHAR(100) NOT NULL,
  password VARCHAR(100) NOT NULL,
  CONSTRAINT credential_fk_employee_id FOREIGN KEY (employee_id) REFERENCES employee(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE product (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  employee_id INT,
  address VARCHAR(255) NOT NULL,
  phone_number CHAR(15) NOT NULL,
  available BOOLEAN DEFAULT TRUE,
  price DECIMAL(10,2) NOT NULL,
  CONSTRAINT product_fk_employee_id FOREIGN KEY (employee_id) REFERENCES employee(id) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE sales_history (
  employee_id INT,
  product_id INT,
  date_sales DATETIME DEFAULT CURRENT_TIMESTAMP,
  commission DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (employee_id,product_id),
  CONSTRAINT sales_history_fk_employee_id FOREIGN KEY (employee_id) REFERENCES employee(id),
  CONSTRAINT sales_history_fk_product_id FOREIGN KEY (product_id) REFERENCES product(id)
);

INSERT INTO job (role, contract_type) VALUES
('Gerente', 'CLT'),
('Corretor', 'Autônomo'),
('Marketing', 'PJ');

INSERT INTO employee (name, job_id, address, phone_number, salary) VALUES
('Hyperion', 1, 'Rua A, 123', '(11) 98765-4321', 8000.00),
('Diamante', 2, 'Avenida B, 456', '(11) 99876-5432', 5000.00),
('Ferrari', 2, 'Rua C, 789', '(11) 98765-4321', 5000.00),
('Borges', 3, 'Avenida D, 101', '(11) 99876-5432', 4500.00),
('Bellatrix', 2, 'Rua E, 222', '(11) 98765-4321', 5000.00),
('SandraAlmeida', 2, 'Avenida F, 333', '(11) 99876-5432', 5000.00),
('Rafael', 2, 'Rua G, 444', '(11) 98765-4321', 5000.00),
('Costa', 2, 'Avenida H, 555', '(11) 99876-5432', 5000.00),
('Pereira', 2, 'Rua I, 666', '(11) 98765-4321', 5000.00),
('Dexter', 3, 'Avenida J, 777', '(11) 99876-5432', 4500.00);

INSERT INTO credential (employee_id, email, password) VALUES
(1, 'JoãoSilva@example.com', 'senha123'),
(2, 'MariaSantos@example.com', 'senha456'),
(3, 'CarlosFerreira@example.com', 'senha789'),
(4, 'AnaRodrigues@example.com', 'senha569'),
(5, 'PedroOliveira@example.com', 'senha777'),
(6, 'SandraAlmeida@example.com', 'senha738'),
(7, 'RafaelMartins@example.com', 'senha195'),
(8, 'JulianaCosta@example.com', 'senha285'),
(9, 'LucasPereira@example.com', 'senha649'),
(10, 'FernandaSouza@example.com', 'senha173');

INSERT INTO product (employee_id, address, phone_number, available, price) VALUES
(2, 'Rua A, 123', '(11) 98765-4321', 0, 300000.00),
(3, 'Avenida B, 456', '(11) 99876-5432', 0, 150000.00),
(8, 'Rua C, 789', '(11) 98765-4321', 1, 250000.00),
(5, 'Avenida D, 101', '(11) 99876-5432', 1, 180000.00),
(2, 'Rua E, 222', '(11) 98765-4321', 1, 220000.00),
(6, 'Avenida F, 333', '(11) 99876-5432', 0, 170000.00),
(3, 'Rua G, 444', '(11) 98765-4321', 1, 350000.00),
(2, 'Avenida H, 555', '(11) 99876-5432', 1, 120000.00),
(3, 'Rua I, 666', '(11) 98765-4321', 1, 280000.00),
(2, 'Avenida J, 777', '(11) 99876-5432', 0, 190000.00);

INSERT INTO sales_history (employee_id, product_id, date_sales, commission) VALUES
(6, 1, '2023-01-01', 0.06),
(3, 2, '2023-03-05', 0.05),
(2, 6, '2023-05-20', 0.07),
(2, 10, '2023-07-09', 0.08);
