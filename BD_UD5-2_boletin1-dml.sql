-- Tarefa 1. Realizar consultas con datos de máis dunha táboa utilizando unha composición interna
-- Sobre a base de datos tendaBD
USE tendaBD;

-- Tarefa 1.1. Seleccionar os artigos de cor negra e mostrar o seu número, nome e peso, así como o nome do provedor.
SELECT 	ar.art_codigo,
		ar.art_nome,
        ar.art_peso,
        pr.prv_nome
FROM artigos AS ar
JOIN provedores AS pr ON (ar.art_provedor = pr.prv_id)
WHERE ar.art_color LIKE "negro";


-- Tarefa 1.2. Seleccionar para todos os apelidos, nome e o nome da provincia na que residen. Os dous primeiros díxitos do código postal (clt_cp) corresponden ao código da provincia na que reside o cliente. Ordenar o resultado polo nome da provincia, e dentro da provincia, polos apelidos e nome, alfabeticamente.

-- Falta tabla provincias



-- Tarefa 1.3. Mostrar para cada venda: nome e apelidos do cliente, día, mes, e ano da venda (cada un nunha columna).
SELECT 	clt.clt_nome,
		clt.clt_apelidos,
        DAY(ven.ven_data), 
        MONTH(ven.ven_data), 
		YEAR(ven.ven_data),
        ven.ven_data
FROM vendas AS ven
JOIN clientes AS clt;


-- Tarefa 1.4. Mostrar unha lista que conteña: número de vendas, número de artigos vendidos, suma de unidades vendidas e a media dos prezos unitarios dos artigos vendidos.
SELECT 	COUNT(ven.ven_id) AS "Número de ventas",
		COUNT(DISTINCT dev.dev_artigo) AS "Número de artículos vendidos",
        SUM(dev.dev_cantidade) AS "Suma de unidades vendidas",
        AVG(dev.dev_prezo_unitario) AS "Media de precios unitarios"
FROM vendas AS ven
JOIN detalle_vendas AS dev ON (dev.dev_venda = ven.ven_id);


-- Tarefa 1.5. Seleccionar para cada artigo o seu número, nome, peso e o nome que corresponde ao peso (peso_nome), tendo en conta a información contida na táboa pesos, que da un nome aos pesos en función do intervalo ao que pertence. Ordenar o resultado polo peso do artigo, de maior a menor.
SELECT 	art.art_codigo,
		art.art_nome,
        art.art_peso,
        pes.peso_nome
FROM artigos AS art        
JOIN pesos pes ON (art.art_peso BETWEEN pes.peso_min AND pes.peso_max)
ORDER BY art.art_peso DESC;        
        
-- SELECT * FROM pesos;

-- Tarefa 1.6. Mostrar para cada venta: nome e apelidos do cliente, a data da venta con formato dd/mm/aa e os días transcorridos dende que se fixo a venta. Ordenar o resultado polo número de días transcorridos dende a venta.
SELECT 	clt.clt_nome,
		clt.clt_apelidos,
        date_format(ven.ven_data, "%d/%m/%y") AS "Fecha de venta",
        timestampdiff(day, ven.ven_data, current_date) AS "Días transcurridos"
FROM vendas AS ven
JOIN clientes AS clt ON (ven.ven_cliente = clt.clt_id)
ORDER BY timestampdiff(day, ven.ven_data, current_date);
	


-- Tarefa 1.7. Seleccionar os nomes das provincias nas que temos clientes.
-- Falta tabla provincias

-- Tarefa 1.8. Seleccionar para cada venda:
    --  • Datos da venda: identificador e data da venda.
	-- • Datos do cliente: nome do cliente (nome e apelidos separados por coma).
--     • Datos do empregado: nome do empregado (nome e apelidos separados por coma).
--     • Mostrar os datos ordenados polos apelidos e nome do cliente.

SELECT 	ven.ven_id,
		ven.ven_data,
        CONCAT(clt.clt_nome, ", ", clt_apelidos) AS "Datos del cliente",
        CONCAT(emp.emp_nome, ", ", emp.emp_apelidos) AS "Datos del empleado"
FROM vendas AS ven
JOIN clientes AS clt ON (ven.ven_cliente = clt.clt_id)
JOIN empregados AS emp ON (emp.emp_id = ven.ven_empregado)
ORDER BY clt.clt_apelidos, clt.clt_nome;
        

-- Tarefa 1.9. Seleccionar información sobre os artigos vendidos. Para cada liña de detalle interesa:
--     • Datos do cliente: apelidos e nome separados por coma, nunha única columna.
--     • Datos do artigo: nome, cantidade,  prezo unitario, desconto e o importe final para o cliente (resultado de multiplicar a cantidade polo prezo unitario e aplicar o desconto que corresponde). Mostrar os resultados ordenados polo nome do artigo.

SELECT all	CONCAT(clt.clt_apelidos, ", ",clt.clt_nome),
			art.art_nome,
            dev.dev_cantidade,
            dev.dev_prezo_unitario,
            dev.dev_desconto,
            ROUND(dev.dev_cantidade * dev.dev_prezo_unitario - (dev.dev_cantidade * dev.dev_prezo_unitario * dev.dev_desconto/100), 2) AS "Importe final"
FROM detalle_vendas AS dev
JOIN artigos AS art ON (dev.dev_artigo = art.art_codigo)
JOIN vendas AS ven ON (ven.ven_id = dev.dev_venda)
JOIN clientes AS clt ON (clt.clt_id = ven.ven_id)
ORDER BY art.art_nome;
            
            


