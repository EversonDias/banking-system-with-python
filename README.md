# Potência Tech powered by iFood | Ciências de Dados com Python

![logo do curso](https://hermes.dio.me/tracks/49c408ad-800d-416d-b77c-681add1be673.png)

# índice
- [Sobre](#sobre)
- [Como executar](#criação-do-banco-de-dados)
- [Query](#query)

# Sobre

## Diagrama de EER

![Diagrama de EER](/driagrama/diagrama.png)

Este documento descreve o projeto de um banco de dados para um E-Commerce, desenvolvido como parte do bootcamp "Potência Tech powered by iFood | Ciências de Dados com Python". O projeto visa criar uma estrutura de banco de dados eficiente e escalável para um E-Commerce, abrangendo várias entidades, relacionamentos e conceitos avançados de banco de dados. O banco de dados é implementado usando o sistema de gerenciamento de banco de dados MySQL, e o design é representado por um diagrama Entidade-Relacionamento Estendido (EER).

## Objetivo
O objetivo deste projeto é criar um banco de dados robusto para um E-Commerce, considerando diversos aspectos como produtos, clientes, pedidos, pagamentos, fornecedores e vendedores. O design do banco de dados incorpora conceitos como normalização, chaves primárias e estrangeiras, relacionamentos um-para-muitos e muitos-para-muitos, além de aproveitar recursos avançados do MySQL para otimizar a performance e garantir a integridade dos dados.

## Diagrama de EER
O Diagrama de EER ilustra as entidades, seus atributos e os relacionamentos entre elas. Ele destaca como os conceitos de normalização, chaves primárias e estrangeiras são implementados no design do banco de dados. O diagrama também reflete os diferentes níveis de relacionamentos entre entidades, como clientes, produtos, pedidos, pagamentos, fornecedores e vendedores. A estrutura hierárquica e os pontos de conexão entre as tabelas são visualmente representados, proporcionando uma visão geral do sistema.

## Conceitos Implementados

Entidades Principais: Clientes, Produtos, Pedidos, Pagamentos, Fornecedores, Vendedores.
Relacionamentos Complexos: Muitos-para-Muitos (ex: produtos em um pedido), Um-para-Muitos (ex: produtos vendidos por um vendedor).
Tabelas Associativas: Utilizadas para resolver relacionamentos muitos-para-muitos (ex: produto_orders, in_stock).
Chaves Primárias e Estrangeiras: Garantindo a integridade dos dados e estabelecendo vínculos entre entidades.
Normalização: Organização eficiente dos dados, evitando redundâncias e anomalias.
Utilização de Recursos Avançados do MySQL: Chaves compostas, ENUMs para estados, constraints UNIQUE.
Atributos Calculados: Avaliação média de produtos, preço total de pedidos.
Registro de Histórico: Tabelas de histórico para rastrear fornecimentos e vendas.
Integração com Módulo de Pagamento: Registro de pagamentos com diferentes tipos de pagamento (ex: boleto, crédito).
Benefícios e Impacto:
Este projeto proporciona uma base sólida para o funcionamento de um E-Commerce, permitindo o gerenciamento eficaz de produtos, pedidos, pagamentos e relacionamentos com fornecedores e vendedores. O uso de um diagrama EER auxilia na compreensão visual do design do banco de dados, facilitando manutenções futuras e modificações.

## Conclusão
O projeto do banco de dados para um E-Commerce usando MySQL e um diagrama de EER é uma demonstração de como aplicar conceitos avançados de modelagem de banco de dados para criar uma estrutura sólida e eficiente. Isso possibilita um gerenciamento eficaz das informações, garantindo integridade, escalabilidade e desempenho. Esse projeto contribui para a formação dos participantes do bootcamp "Potência Tech powered by iFood | Ciências de Dados com Python", proporcionando uma experiência prática na aplicação de conceitos de banco de dados em um cenário real.

# Criação do banco de dados

```bash
git clone -b desafio_ecommerce https://github.com/EversonDias/potencia-tech-powered-by-iFood-ciencias-de-dados-com-python.git desafio_ecommerce
```

```bash
cd desafio_ecommerce
```

⚠️ O comando docker-compose up -d cria o contêiner cria o banco de dados cria as tabeles e incluir os dados. ⚠️

⚠️ importante ter instalado docker desktop ou docker-comose ⚠️

```bash
docker-compose up -d
```

⚠️ obs: aguarde a iniciação do banco de dados acompanhando pelo docker desktop. ⚠️

```bash
docker exec -it db_manager bash
```

```bash
mysql ecommerce -ppassword
```

# Query

<details>
<summary><strong>todos os clientes que tem cartão de credito</strong></summary>


```sql
SELECT CONCAT(first_name,' ',middle_name,' ',last_name) AS nome_completo, phone_number AS numero_de_telefone, email, CONCAT(street,'-',neighborhood,'-',state,'-',city,'-') AS endereço, birth_date AS data_de_nascimento FROM client AS c, wallet AS w WHERE c.id = w.client_id AND w.type_card = 'CREDITO';
```

</details>

<details>
<summary><strong>todos os clientes com compras em aberto</strong></summary>


```sql
SELECT CONCAT(first_name,' ',middle_name,' ',last_name) AS nome_completo, phone_number AS numero_de_telefone, email, CONCAT(street,'-',neighborhood,'-',state,'-',city,'-') AS endereço, birth_date AS data_de_nascimento FROM client AS c, orders AS o, payment AS p WHERE c.id = o.client_id AND o.id = p.orders_id AND p.status = 'EM PROGRESSO';
```

</details>

<details>
<summary><strong>todos os vendedores com venda acime de 10 produtos em ordem decrescente</strong></summary>


```sql
SELECT fantasy_name AS nome, phone_number AS numero_de_telefone, email, ( SELECT SUM(quantity) FROM sales_history WHERE sales_history.seller_id = id ) AS quantidade_de_vendas FROM seller AS s HAVING quantidade_de_vendas > 10;
```

</details>

<details>
<summary><strong>os 5 produto mais vendido</strong></summary>


```sql
SELECT name AS nome_do_produto,category AS categoria,description AS descrição,assessment AS nota, price AS preço,(SELECT SUM(quantity) FROM sales_history WHERE sales_history.product_id = id) AS quantidade_de_vendas FROM product ORDER BY quantidade_de_vendas DESC LIMIT 5;
```

</details>

<details>
<summary><strong>os produtos com menos de 10 vendas</strong></summary>


```sql
SELECT name AS nome_do_produto, category AS categoria, description AS descrição, assessment AS nota, price AS preço, ( SELECT SUM(quantity) FROM sales_history WHERE sales_history.product_id = id ) AS quantidade_de_vendas FROM product HAVING quantidade_de_vendas < 10;
```

</details>

<details>
<summary><strong>faturamento dos vendedores no mês de agosto</strong></summary>


```sql
SELECT fantasy_name AS nome, phone_number AS numero_de_telefone, email, SUM((ps.quantity * p.price)) AS faturamento FROM seller AS s,sales_history AS ps, product AS p WHERE s.id = ps.seller_id AND ps.product_id = p.id AND ps.sale_date LIKE '2023-08-%' GROUP BY s.id;
```

</details>

<details>
<summary><strong>Resumo das vendas</strong></summary>


```sql
SELECT fantasy_name AS nome, phone_number AS numero_de_telefone, email, ps.sale_date AS data_da_venda, ps.quantity AS quantidade_vendida, p.price AS preço_do_produto, p.name AS nome_do_produto, p.category AS categoria_do_produto, (ps.quantity * p.price) AS valor_total FROM seller AS s, sales_history AS ps, product AS p WHERE s.id = ps.seller_id AND ps.product_id = p.id;
```

</details>

<details>
<summary><strong>quais produtos foram estocados no mês de agosto</strong></summary>


```sql
SELECT p.name AS nome, pp.quantity AS quantidade, pp.date_provide AS data_da_compra, s.corporate_name AS nome_social, s.phone_number AS telefone FROM product AS p, product_provided AS  pp, supplier AS s WHERE p.id = pp.product_id AND pp.supplier_id = s.id AND pp.date_provide LIKE '2023-08-%';
```

</details>
