-- todos os clientes que tem cartão de credito

SELECT 
	CONCAT(first_name,' ',middle_name,' ',last_name) AS nome_completo,
  phone_number AS numero_de_telefone,
  email,
  CONCAT(street,'-',neighborhood,'-',state,'-',city,'-') AS endereço,
  birth_date AS data_de_nascimento
FROM 
	client AS c, wallet AS w 
WHERE 
  c.id = w.client_id AND w.type_card = 'CREDITO';

-- todos os clientes com compras em aberto

SELECT 
	CONCAT(first_name,' ',middle_name,' ',last_name) AS nome_completo,
  phone_number AS numero_de_telefone,
  email,
  CONCAT(street,'-',neighborhood,'-',state,'-',city,'-') AS endereço,
  birth_date AS data_de_nascimento
FROM 
	client AS c,
  orders AS o,
  payment AS p
WHERE 
  c.id = o.client_id AND o.id = p.orders_id AND p.status = 'EM PROGRESSO';

-- todos os vendedores com venda acime de 10 produtos em ordem decrescente

SELECT 
	fantasy_name AS nome,
  phone_number AS numero_de_telefone,
  email,
  (
		SELECT
			SUM(quantity)
		FROM
			sales_history
		WHERE
			sales_history.seller_id = id
	) AS quantidade_de_vendas
FROM 
	seller AS s HAVING quantidade_de_vendas > 10;

-- os 5 produto mais vendido

SELECT 
	name AS nome_do_produto,
  category AS categoria,
  description AS descrição,
  assessment AS nota,
  price AS preço,
  (
		SELECT
			SUM(quantity)
		FROM
			sales_history
		WHERE
			sales_history.product_id = id
	) AS quantidade_de_vendas
FROM 
	product ORDER BY quantidade_de_vendas DESC LIMIT 5;

-- os produtos com menos de 10 vendas

SELECT 
	name AS nome_do_produto,
  category AS categoria,
  description AS descrição,
  assessment AS nota,
  price AS preço,
  (
		SELECT
			SUM(quantity)
		FROM
			sales_history
		WHERE
			sales_history.product_id = id
	) AS quantidade_de_vendas
FROM 
	product HAVING quantidade_de_vendas < 10;

-- faturamento dos vendedores no mês de agosto

SELECT 
	fantasy_name AS nome,
  phone_number AS numero_de_telefone,
  email,
  SUM((ps.quantity * p.price)) AS faturamento
FROM 
	seller AS s,
  sales_history AS ps,
  product AS p
WHERE s.id = ps.seller_id AND ps.product_id = p.id AND ps.sale_date LIKE '2023-08-%'
GROUP BY s.id;

-- Resumo das vendas

SELECT 
	fantasy_name AS nome,
  phone_number AS numero_de_telefone,
  email,
  ps.sale_date AS data_da_venda,
  ps.quantity AS quantidade_vendida,
  p.price AS preço_do_produto,
  p.name AS nome_do_produto,
  p.category AS categoria_do_produto,
  (ps.quantity * p.price) AS valor_total
FROM 
	seller AS s,
  sales_history AS ps,
  product AS p
WHERE s.id = ps.seller_id AND ps.product_id = p.id;

-- quais produtos foram estocados no mês de agosto

SELECT 
	p.name AS nome,
  pp.quantity AS quantidade,
  pp.date_provide AS data_da_compra,
  s.corporate_name AS nome_social,
  s.phone_number AS telefone
FROM 
	product AS p,
  product_provided AS  pp,
  supplier AS s
WHERE
	p.id = pp.product_id AND pp.supplier_id = s.id AND pp.date_provide LIKE '2023-08-%';