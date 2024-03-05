-- Tarefa 2. Realizar consultas con datos de máis dunha táboa utilizando unha composición interna, externa e dunha táboa consigo mesma.
-- 
-- Sobre a base de datos traballadores
USE traballadores;
--     • Tarefa 2.1. Seleccionar o número e nome de departamento, xunto co nome do director, para os departamentos independentes, é dicir, que non dependen de ningún outro departamento.
SELECT 	d.depNumero,
		d.depNome,
        e.empNome
FROM departamento AS d
JOIN empregado AS e ON (e.empDepartamento = d.depNumero)
WHERE depDepende IS NULL;

--     • Tarefa 2.2. Mostrar nome (só nome, sen apelidos) e enderezo do centro ao que pertence o departamento no que traballa, dos empregados cun nome (sen ter en conta os apelidos) que empece por 'A'.
SELECT  trim(RIGHT(e.empNome, length(e.empNome) - locate(",", e.empNome))),
		c.cenEnderezo
FROM empregado AS e
JOIN departamento AS d ON (e.empDepartamento = d.depNumero)
JOIN centro AS c ON (d.depCentro = c.cenNumero)
WHERE trim(RIGHT(e.empNome, length(e.empNome) - locate(",", e.empNome))) REGEXP "^A";



--     • Tarefa 2.3. Seleccionar para todos os empregados que non son directores, o nome de departamento no que traballa, o seu nome e salario, o nome e salario do director do seu departamento, e a diferenza do seu salario e o salario do director do departamento. Ordenar o resultado polo nome do departamento.
SELECT 	d.depNome AS "Nome departamento",
		emp.empNome AS "Nome empregado",
		emp.empSalario AS "Salario empregado",
        dir.empNome AS "Nome director",
        dir.empSalario AS "Salario director",
        dir.empSalario - emp.empSalario AS "DIferenza salario"
FROM empregado AS emp
JOIN departamento AS d ON (emp.empDepartamento = d.depNumero)
JOIN empregado AS dir ON (d.depDirector = dir.empNumero)
WHERE emp.empNumero <> dir.empNumero
ORDER BY d.depNome;
        --     • Solicítase esta información para facer un estudio da diferenza de salarios entre os directores dos departamento e os traballadores que traballan no departamento.


--     • Tarefa 2.4. Mostrar o número, nome e salario de todos os empregados que teñen un salario maior que o salario do empregado número 180. Engadir na lista de selección unha columna para mostrar o salario do empregado número 180.
SELECT 	emp.empNumero,
		emp.empNome,
        emp.empSalario,
        empZ.empSalario
FROM empregado AS emp
JOIN empregado AS empZ ON (emp.empSalario <> empZ.empSalario)
WHERE empZ.empNumero = 180
AND emp.empSalario < empZ.empSalario;

-- Sobre a base de datos tendaBD
USE tendaBD;

--     • Tarefa 2.5. Para todos os clientes con identificador inferior ou igual a 10, seleccionar os datos das vendas que se lle fixeron. Hai que mostrar para cada venda, o identificador do cliente, apelidos, nome e data de venda. Se a algún deses clientes non se lle fixo ningunha venda, deberá aparecer na lista co seu identificador, nome, apelidos, e o texto 'SEN COMPRAS' na columna da data da venda.
SELECT 	c.clt_id,
		c.clt_apelidos,
        c.clt_nome,
        ifnull(v.ven_data, "SEN COMPRAS") AS "Fecha"
FROM clientes AS c
LEFT JOIN vendas AS v ON (v.ven_cliente = c.clt_id)
WHERE c.clt_id <= 10;



--     • Tarefa 2.6. Seleccionar os nomes das provincias nas que non temos ningún cliente.
-- Non hay táboa provincias


--     • Tarefa 2.7. Seleccionar o código (emp_id), apelidos e nome de todos os empregados. Engadir unha columna na lista de selección, co alias Vendas, na que se mostre o literal 'Si'  se o empregado fixo algunha venda, ou o literal 'Non' no caso de que aínda non fixera ningunha venda.
SELECT 	e.emp_id,
		e.emp_apelidos,
		e.emp_nome,
        if(v.ven_id IS NOT NULL, "Sí", "Non") AS "¿Hizo venta?"
FROM vendas AS v 
RIGHT JOIN empregados AS e ON (v.ven_empregado = e.emp_id);



--     • Tarefa 2.8. Obter unha lista de todos os artigos que teñan un prezo de compra superior ao prezo de compra do artigo con código ' 0713242'.
SELECT 	art.*
FROM artigos AS art
JOIN artigos AS artZ ON (art.art_codigo <> artZ.art_codigo)
WHERE art.art_pc > artZ.art_pc
AND artZ.art_codigo = "aaaa0003";





