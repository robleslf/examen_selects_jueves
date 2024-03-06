-- Sobre a base de datos tendaBD
USE tendaBD;

       -- 2.1. Mostrar apelidos e nome nunha mesma columna separados por unha coma, e o número de letras que ten o nome.
SELECT 	concat(clt_apelidos, ", ", clt_nome) AS "Nombre y apellidos",
		length(clt_nome)
FROM clientes;
       
       -- 2.2. Mostrar  nomes e apelidos dos clientes en minúscula.
SELECT 	lower(clt_nome),
		lower(clt_apelidos)
FROM clientes;
       
       
       -- 2.7. Calcular a media do peso, o marxe máximo ( máxima diferenza entre o prezo de venda e o prezo de compra) e a diferenza que se dá entre o maior prezo de venda e o menor prezo de compra. Estes cálculos terán que facerse para aqueles artigos que teñan descrito a cor cun valor distinto do NULL.
SELECT 	AVG(art_peso) AS "Peso medio",
		MAX(art_pv - art_pc) AS "Margen máximo",
        MAX(art_pv) - MIN(art_pc) AS "Diferencia entre  el mayor precio de venta y el menor de compra"
FROM artigos
WHERE art_color IS NOT NULL;
       
       --  2.8. Contar o número de cores distintos que existen na táboa de artigos.
SELECT COUNT(DISTINCT art_color)
FROM artigos;


​       
       -- 2.9. Mostrar nome e cor dos artigos. Se a cor é descoñecida, débese mostrar o texto ‘DESCOÑECIDO’.
SELECT 	art_nome,
		ifnull(art_color, "DESCOÑECIDO")
FROM artigos;


       -- Sobre a base de datos traballadores
USE traballadores;       

       -- 2.10. A xubilación na empresa está establecida aos 60 anos. O empregado xubilado ten dereito a unha liquidación que equivale ao salario dun mes por cada ano de servizo na empresa. Mostrar nome, data de nacemento, salario mensual base, antigüidade (número de anos dende que entrou a traballar na empresa ata a data de xubilación) e importe da liquidación que lle corresponde aos empregados que se xubilarán no ano actual.
SELECT empNome AS 'Nombre', 
	empDataNacemento AS 'Nacimiento',
    empSalario AS "Nómina",
	YEAR(CURDATE()) - YEAR(empDataIngreso) AS "Antigüedade",
    CONCAT(empSalario * TIMESTAMPDIFF(YEAR, empDataIngreso, current_date())," €") AS "Bonificación"
FROM empregado
WHERE YEAR(ADDDATE(empDataNacemento, INTERVAL 60 YEAR)) = YEAR(current_date());      
       
-- TIMESTAMPDIFF(YEAR, empDataIngreso, current_date()) AS "Antigüedad",
       
/* SELECT empNome AS 'Nombre', 
	empDataNacemento AS 'Nacimiento',
    ADDDATE(empDataNacemento, INTERVAL 60 YEAR) AS 'JUBILACION'
    FROM empregado
	WHERE ADDDATE(empDataNacemento, INTERVAL 59 YEAR) <= current_date();
*/
    


​    
​    
       -- 2.11.  Mostrar nome, día e mes do aniversario dos empregados dos departamentos 110 e 111.

SELECT empNOme,
		day(empDataNacemento) AS "DÍA",
        month(empDataNacemento) AS "MES"
FROM empregado
WHERE empDepartamento BETWEEN 110 AND 111; -- Esto porque no hay un departamento 110,5, pero si no mejor con el = y el OR
		


       -- 2.12. Mostrar o número de empregados que este ano cumpren 20 anos traballando na empresa e o salario medio de todos eles.
SELECT 	COUNT(*) AS "Número de trabajadores",
		AVG(empSalario) AS "Salario medio"
FROM empregado
WHERE TIMESTAMPDIFF(YEAR, empDataIngreso, current_date()) = 20;

-- el COUNT y el AVG  solo lo hace a los que cumplen la condición del WHERE.


​       
       -- 2.14. Mostrar o número de departamentos que existen e o presuposto anual medio de todos eles.
SELECT 	COUNT(*) AS "Número de departamentos",
		CONCAT(ROUND(AVG(depPresuposto), 2), " €") AS "Presupuesto medio de todos y cada uno de los departamentos existentes"
FROM departamento;
       
       
       -- 2.15. Mostrar o importe total das comisións dos empregados.
SELECT SUM(empComision) AS "Importe o COmisiones totale so importe toptal de comisin32swxdfdgh"
FROM empregado
WHERE empComision IS NOT NULL; -- esto se pone porque como haya un NULL, el valor que devuelve es un NULL en la suma; no ocurre lo mismo si es un 0, que lo suma como 0.
       
       -- 2.19.Mostrar nome, data de entrada na empresa con formato dd/mm/aaaa e o número de anos completos que leva traballando na empresa, para os empregados que cumpren anos no mes actual.
SELECT	empNome,
		DATE_FORMAT(empDataIngreso, "%d/%m%/%Y") AS "Ingreso",
        TIMESTAMPDIFF(YEAR, empDataIngreso, current_date()) AS "Antgiuedad"
FROM empregado
WHERE MONTH(empDataNacemento) = MONTH(current_date());
       
       