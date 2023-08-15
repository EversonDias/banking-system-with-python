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
