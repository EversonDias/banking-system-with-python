INSERT INTO client (first_name, last_name, middle_name, CPF, birth_date, street, neighborhood, zip_code, state, city, complement)
VALUES
('João', 'Silva', 'Mendes', '123.456.789-01', '1990-05-15', 'Rua A', 'Centro', '12345-000', 'SP', 'São Paulo', NULL),
('Maria', 'Santos', 'Ferreira', '234.567.890-12', '1985-09-20', 'Rua B', 'Bairro X', '23456-000', 'RJ', 'Rio de Janeiro', 'Apto 101'),
('Carlos', 'Fernandes', 'Almeida', '345.678.901-23', '1995-01-10', 'Rua C', 'Bairro Y', '34567-000', 'MG', 'Belo Horizonte', NULL),
('Ana', 'Pereira', 'Nunes', '456.789.012-34', '2000-03-25', 'Rua D', 'Bairro Z', '45678-000', 'RS', 'Porto Alegre', NULL),
('Lucas', 'Gomes', 'Ribeiro', '567.890.123-45', '1992-11-02', 'Rua E', 'Centro', '56789-000', 'SP', 'São Paulo', 'Apto 202');

INSERT INTO wallet (client_id, type_card, card_number, expiration_date, secret_number)
VALUES
(1, 'CREDITO', '1234567890123456', '12/25', '123'),
(2, 'DEBITO', '2345678901234567', '06/24', '456'),
(3, 'CREDITO', '3456789012345678', '09/23', '789'),
(4, 'DEBITO', '4567890123456789', '03/22', '012'),
(5, 'CREDITO', '5678901234567890', '08/26', '345');

INSERT INTO product (name, category, description, assessment, price)
VALUES
('Camiseta Branca', 'Roupas', 'Camiseta básica branca tamanho M', 4.5, 29.99),
('Calça Jeans', 'Roupas', 'Calça jeans azul tamanho 34', 4.2, 79.99),
('Tênis Esportivo', 'Calçados', 'Tênis esportivo preto tamanho 42', 4.7, 99.99);

INSERT INTO orders (status, client_id, description, freight)
VALUES
('PROCESSING', 1, 'Pedido de roupas para o verão', 15.00),
('IN TRANSPOT', 2, 'Pedido de calçados variados', 12.50),
('FINISH', 3, 'Pedido de produtos eletrônicos', 8.00);

INSERT INTO payment (orders_id, type_payment, status)
VALUES
(1, 'CREDITO', 'SUCCESS'),
(2, 'DEBITO', 'SUCCESS'),
(3, 'BOLETO', 'IN PROGRESS');

INSERT INTO product_orders (product_id, orders_id, quantity)
VALUES
(1, 1, 2),
(2, 1, 1),
(3, 2, 1);

INSERT INTO stock (street, neighborhood, zip_code, state, city, complement)
VALUES
('Rua F', 'Bairro W', '67890-000', 'PR', 'Curitiba', NULL),
('Rua G', 'Centro', '78900-100', 'SP', 'São Paulo', 'Loja 101');

INSERT INTO in_stock (product_id, stock_id, quantity)
VALUES
(1, 1, 50),
(2, 2, 25),
(3, 2, 30);

INSERT INTO supplier (corporate_name, CNPJ, phone_number)
VALUES
('Fornecedor A', '12.345.678/9012-34', '(11) 1234-5678'),
('Fornecedor B', '23.456.789/0123-45', '(21) 2345-6789'),
('Fornecedor C', '34.567.890/1234-56', '(31) 3456-7890');

INSERT INTO product_provided (product_id, supplier_id, quantity)
VALUES
(1, 1, 100),
(2, 1, 75),
(3, 2, 80);

INSERT INTO seller (corporate_name, email, phone_number, fantasy_name, CNPJ)
VALUES
('Loja A', 'loja.a@email.com', '(11) 9876-5432', 'Lojinha', '12.345.678/9012-34'),
('Loja B', 'loja.b@email.com', '(21) 8765-4321', 'Boutique', '23.456.789/0123-45'),
('Loja C', 'loja.c@email.com', '(31) 7654-3210', 'Outlet', '34.567.890/1234-56');

INSERT INTO bank_account (seller_id, bank, agency, account, type_account, CPF)
VALUES
(1, 'Banco X', '1234', '56789', 'CORRENTE', '123-456-789-01'),
(2, 'Banco Y', '2345', '67890', 'POUPANÇA', '234.567.890-12'),
(3, 'Banco Z', '3456', '78901', 'CORRENTE', '345.678.901-23');

INSERT INTO product_sold (seller_id, product_id, quantity)
VALUES
(1, 1, 10),
(2, 2, 5),
(3, 3, 8);
