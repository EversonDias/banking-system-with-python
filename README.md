# Potência Tech powered by iFood | Ciências de Dados com Python

![logo do curso](https://hermes.dio.me/tracks/49c408ad-800d-416d-b77c-681add1be673.png)

# índice
- [Sobre](#sobre)
- [Como executar](#criação-do-banco-de-dados)
- [Query](#query)

# Sobre

## Diagrama de EER

![Diagrama de EER](/driagrama/imobiliaria.png)

Este documento descreve o projeto de um banco de dados para uma imobiliária, desenvolvido como parte do bootcamp "Potência Tech powered by iFood | Ciências de Dados com Python". O projeto visa criar uma estrutura de banco de dados eficiente e escalável para uma imobiliária, abrangendo várias entidades, relacionamentos e conceitos avançados de banco de dados. O banco de dados é implementado usando o sistema de gerenciamento de banco de dados MySQL, e o design é representado por um diagrama Entidade-Relacionamento Estendido (EER).


# Criação do banco de dados

```bash
git clone -b desafio_4 https://github.com/EversonDias/potencia-tech-powered-by-iFood-ciencias-de-dados-com-python.git desafio_4
```

```bash
cd desafio_4
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
mysql db_manager -ppassword
```

# Query

<details>
<summary><strong>todos os produtos disponíveis</strong></summary>


```sql
SELECT e.name AS corretor, p.address As endereço, p.phone_number As telefone, p.price AS valor FROM employee AS e, product AS p, job AS j WHERE p.employee_id = e.id AND e.job_id = j.id AND j.role = 'Corretor';
```

</details>

<details>
<summary><strong>ver todos os produtos vendidos</strong></summary>


```sql
SELECT (SELECT employee.name FROM product, employee WHERE product.employee_id = employee.id AND product.id = sh.product_id) AS capitador, e.name AS vendedor, p.price AS valor, sh.commission AS comissão FROM employee AS e, product AS p, sales_history AS sh WHERE sh.employee_id = e.id AND sh.product_id = p.id;
```

</details>
