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
