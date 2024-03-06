-- Tarefa 1. Escribir e probar consultas simples
-- Sobre a base de datos tendaBD:
USE tendaBD;
-- 1.1. Mostrar os datos de todas as tendas.
SELECT * 
FROM tendas;

-- 1.2. Mostrar os nomes de todos os provedores.
SELECT prv_nome 
FROM provedores;


-- 1.3. Obter a lista das poboacións nas que existen clientes. 
SELECT DISTINCT clt_poboacion 
FROM clientes;


-- 1.4. Mostrar o prezo de venda de todos os artigos e o prezo que resultaría despois de aplicarlles un incremento do 10%. 
SELECT 	art_nome, 
	art_pv, 
	(art_pv) + (art_pv*10/100) AS "Nuevo Precio" 
FROM artigos;


-- 1.5. Mostrar o número de cliente, apelidos e nome de todos os clientes de Madrid. 
SELECT clt_id,  clt_apelidos, clt_nome 
FROM clientes
WHERE clt_poboacion LIKE "Madrid"; -- Las cadenas de texto mejor con "LIKE" que con "=".

-- 1.6. Seleccionar o código, descrición e peso dos artigos que pesen máis de 500 gramos. 
SELECT art_codigo, art_nome, art_peso 
FROM artigos
WHERE art_peso > 500;

-- 1.7. Seleccionar todos os artigos que teñan prezo de venda superior ou igual ao dobre do prezo de compra. 
SELECT * 
FROM artigos
WHERE art_pv >= (2 * art_pc);

-- 1.8. Seleccionar apelidos, nome, poboación e desconto, de todos clientes de Asturias ou Valencia que teñan un desconto superior ao 2% ou que non teñan desconto. 
SELECT clt_apelidos, clt_nome, clt_poboacion, clt_desconto 
FROM clientes 
WHERE clt_desconto > 2 
OR (clt_desconto = 0 OR clt_desconto IS NULL);

-- 1.9. Seleccionar todos os artigos de cor negra que pesen máis de 5000 gramos. 
SELECT * 
FROM artigos 
WHERE art_color LIKE "negro" 
AND art_peso > 5000;

-- 1.10. Obter todos os artigos que non son de cor negra ou que teñan un peso menor ou igual de 5000 gramos. 
SELECT * 
FROM artigos 
WHERE art_color NOT LIKE "negro"
OR art_peso <= 5000
OR art_color IS NULL;

-- 1.11. Seleccionar os artigos que son de cor negra e pesan máis de 100 gramos, ou ben son de cor cyan. 
SELECT * 
FROM artigos
WHERE (art_color = "negro" AND art_peso > 100) -- no son obligatorios los paréntesis en este caso porque daría prioridad al AND, pero ante la duda ponerlos que no sobran.
OR (art_color = "cyan");

-- 1.12. Facer unha lista dos artigos que teñan un prezo de compra entre 12 e 18 euros, ambos prezos incluídos.
SELECT * 
FROM artigos 
WHERE art_pc BETWEEN 12 AND 18;
 
-- 1.13. Mostrar unha lista de artigos de cor negra ou de cor cyan. 
SELECT * 
FROM artigos
WHERE art_color = "negro" 
OR art_color = "cyan";

-- WHERE art_color IN ("negor","cyan");  Esta también vale.


-- 1.14. Buscar un cliente do que se descoñece o apelido exacto, pero se sabe que as dúas primeiras letras son 'RO'. 
SELECT * 
FROM clientes 
WHERE clt_apelidos LIKE "RO%";

-- También con REGEXP "^RO";

-- 1.15. Buscar clientes que teñan o nome de 5 letras, empezando por 'B' e terminando por 'A'.
SELECT * 
FROM clientes
WHERE length(clt_nome) = 5 
AND clt_nome LIKE "B%A";

SELECT * FROM clientes
WHERE clt_nome LIKE "B___A";


-- 1.16. Buscar todos os artigos para os que non se gravou o seu color. 
SELECT * 
FROM artigos
WHERE art_color IS NULL;

-- 1.17. Clasificar os artigos tendo en conta o seu peso, por orden decrecente.
SELECT * 
FROM artigos
ORDER BY art_peso DESC;

-- 1.18. Mostrar código de artigo, nome, prezo de compra, prezo de venda e marxe de beneficio (prezo de venda – prezo de compra) dos artigos que teñen un prezo de compra superior  a 3000 euros, ordenados pola marxe.
SELECT art_codigo, 
	art_nome, 
	art_pc, art_pv, 
	(art_pv - art_pc) AS "Margen de beneficio" 
FROM artigos
WHERE art_pc > 3000
ORDER BY "Margen de beneficio";


-- 1.19. Clasificar nome, provedor, stock e peso dos artigos que teñen un peso menor ou igual de 1000 gramos, por orden crecente do provedor. Cando os provedores coincidan, deben clasificarse polo stock en orden decrecente.
SELECT art_nome, art_provedor, art_stock, art_peso 
FROM artigos
WHERE art_peso <= 1000
ORDER BY art_provedor ASC, -- el ASC no es obligatorio porque ya lo ordena así
art_stock DESC;


-- 1.20. Seleccionar nome e apelidos dos clientes que teñan un apelido que empece por 'F' e remate por 'Z'.
SELECT clt_nome, clt_apelidos 
FROM clientes
WHERE clt_apelidos LIKE "F%Z %"
OR clt_apelidos LIKE "% F%Z";



-- 1.21. Seleccionar todos os artigos que leven a palabra LED, en maiúsculas, na súa descrición.
SELECT *
FROM artigos
WHERE art_nome LIKE "%LED%";

-- WHERE art_nome REGEXP BINARY "LED";


-- 1.22. Seleccionar todos os artigos que teñan unha descrición que empece por 'CABI', sen diferenciar maiúsculas de minúsculas.	
SELECT * FROM artigos
WHERE UPPER(art_nome) LIKE "CABI%";


-- 1.23. Comprobar que un número é un valor enteiro, que pode empezar polos símbolos + ou -.
SELECT n
REGEXP "^[+-]?[0-9]+";



-- 1.24. Seleccionar os clientes que teñan un apelido que empece pola letra 'a' ou pola letra 'f'.
SELECT *
FROM clientes 
WHERE clt_apelidos LIKE "A%" 
OR clt_apelidos LIKE "F%" 
OR clt_apelidos LIKE "% A%"
OR clt_apelidos LIKE "% F%";

-- regexp "^[AF]"

-- 1.25. Seleccionar os clientes que teñan un apelido que non empece por 'a','b','c', ou 'd'.
SELECT *
FROM clientes
WHERE clt_apelidos NOT LIKE 'A%' 
AND clt_apelidos NOT LIKE 'B%'
AND clt_apelidos NOT LIKE 'C%'
AND clt_apelidos NOT LIKE 'D%'
AND clt_apelidos NOT LIKE '% A%'
AND clt_apelidos NOT LIKE '% B%'
AND clt_apelidos NOT LIKE '% C%'
AND clt_apelidos NOT LIKE '% D%';


-- 1.26. Seleccionar os artigos que teñan un prezo de venta que remata en .00.
SELECT * FROM artigos
WHERE art_pv LIKE "%.00";


-- 1.27. Seleccionar os clientes que teñen un nome que teña exactamente 5 caracteres.
SELECT * FROM clientes
WHERE clt_nome LIKE "_____";
