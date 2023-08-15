-- todos os produtos disponíveis

SELECT 
	e.name AS corretor,
  p.address As endereço,
  p.phone_number As telefone,
  p.price AS valor
FROM 
	employee AS e, product AS p, job AS j 
WHERE 
  p.employee_id = e.id AND e.job_id = j.id AND j.role = 'Corretor';

-- ver todos os produtos vendidos

SELECT 
	(SELECT e.name FROM product as p, employee as e WHERE p.employee_id = e.id AND p.id = sh.product_id) AS capitador,
  e.name AS vendedor,
  p.price AS valor,
  sh.commission AS comissão,
FROM 
	employee AS e, product AS p, sales_history AS sh 
WHERE 
  sh.employee_id = e.id AND sh.product_id = p.id;
