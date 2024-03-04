-- Tarefa 2. Realizar consultas con datos de máis dunha táboa utilizando unha composición interna, externa e dunha táboa consigo mesma.

-- Sobre a base de datos traballadores
USE traballadores;

    -- • Tarefa 2.1. Seleccionar o número e nome de departamento, xunto co nome do director, para os departamentos independentes, é dicir, que non dependen de ningún outro departamento.
SELECT 	d.depNumero, 
		d.depNome, 
        e.empNome AS NomeDirector
FROM departamento AS d
JOIN empregado AS e ON d.depDirector = e.empNumero
WHERE d.depDepende IS NULL;

    
    -- • Tarefa 2.2. Mostrar nome (só nome, sen apelidos) e enderezo do centro ao que pertence o departamento no que traballa, dos empregados cun nome (sen ter en conta os apelidos) que empece por 'A'.
SELECT trim(right(emp.empNome, length(emp.empNome)-locate(',', emp.empNome))) AS Nome, -- esto no cae en examen
       cen.cenNome AS NomeCentro,
       cen.cenEnderezo AS EnderecoCentro
FROM empregado AS emp
JOIN departamento AS dep ON emp.empDepartamento = dep.depNumero
JOIN centro AS cen ON dep.depCentro = cen.cenNumero
WHERE emp.empNome LIKE 'A%';


    -- • Tarefa 2.3. Seleccionar para todos os empregados que non son directores, o nome de departamento no que traballa, o seu nome e salario, o nome e salario do director do seu departamento, e a diferenza do seu salario e o salario do director do departamento. Ordenar o resultado polo nome do departamento.
SELECT dep.depNome AS NomeDepartamento,
       emp.empNome AS NomeEmpregado,
       emp.empSalario AS SalarioEmpregado,
       dir.empNome AS NomeDirector,
       dir.empSalario AS SalarioDirector,
       (dir.empSalario - emp.empSalario) AS DiferenzaSalarios
FROM empregado AS emp
JOIN departamento AS dep ON (emp.empDepartamento = dep.depNumero)
JOIN empregado AS dir ON (dep.depDirector = dir.empNumero)
WHERE emp.empNumero <> dep.depDirector
ORDER BY dep.depNome;
-- • Solicítase esta información para facer un estudio da diferenza de salarios entre os directores dos departamento e os traballadores que traballan no departamento.
    
    
-- • Tarefa 2.4. Mostrar o número, nome e salario de todos os empregados que teñen un salario maior que o salario do empregado número 180. Engadir na lista de selección unha columna para mostrar o salario do empregado número 180.
SELECT 	emp.empNumero AS "Número de empleado",
		emp.empNome AS "Nombre empleado",
        emp.empSalario AS "Salario empleado",
        empZ.empSalario AS "Salario del 180"
FROM empregado AS emp
JOIN empregado AS empZ ON (emp.empSalario <> empZ.empSalario)
WHERE empZ.empNumero = 180
AND emp.empSalario > empZ.empSalario;




-- Sobre a base de datos tendaBD
USE tendaBD;

    --  • Tarefa 2.5. Para todos os clientes con identificador inferior ou igual a 10, seleccionar os datos das vendas que se lle fixeron. Hai que mostrar para cada venda, o identificador do cliente, apelidos, nome e data de venda. Se a algún deses clientes non se lle fixo ningunha venda, deberá aparecer na lista co seu identificador, nome, apelidos, e o texto 'SEN COMPRAS' na columna da data da venda.
SELECT 	clt.clt_id AS "Identificador cliente",
		clt.clt_nome AS "Nome cliente",
		clt.clt_apelidos AS "Apelidos cliente",
        ifnull(ven.ven_data, "SEN COMPRAS") AS "Data de venda"
FROM clientes AS clt
LEFT JOIN vendas AS ven ON (clt.clt_id = ven.ven_cliente)
WHERE clt.clt_id <= 10;
        

	-- • Tarefa 2.6. Seleccionar os nomes das provincias nas que non temos ningún cliente.
-- No hay tabla provincias :/
SELECT pro_nome
FROM provincias AS pr
LEFT JOIN clientes AS cl ON pr.pro_id = LEFT(trim(cl.clt_cp),2)
WHERE clt_id IS NULL; -- Vale cualquier columna que sea obligatoria, con el id aseguras que no haya NULL
 
    
    
-- • Tarefa 2.7. Seleccionar o código (emp_id), apelidos e nome de todos os empregados. Engadir unha columna na lista de selección, co alias Vendas, na que se mostre o literal 'Si'  se o empregado fixo algunha venda, ou o literal 'Non' no caso de que aínda non fixera ningunha venda.
SELECT 	DISTINCT 	emp_id, 
					emp_dni, 
                    emp_apelidos, 
                    emp_nome,
					if(ven_id IS NULL, "Non", "si") AS Vendas
FROM empregados
LEFT JOIN vendas ON emp_id = ven_empregado;

        

    
    
-- • Tarefa 2.8. Obter unha lista de todos os artigos que teñan un prezo de compra superior ao prezo de compra do artigo con código ' 0713242'.
-- SELECT *
-- FROM artigos
-- WHERE art_pc > (SELECT art_pc FROM artigos WHERE art_codigo = 0713242);

SELECT art1.*
FROM artigos AS art1
JOIN artigos AS art2 ON (art1.art_pc > art2.art_pc)
WHERE art2.art_pc = '0713242';