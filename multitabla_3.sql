-- Tarefa 3. Realizar consultas con datos de máis dunha táboa utilizando composición externa.

-- Sobre a base de datos tendaBD
USE tendaBD;

   -- • Tarefa 3.1. Para cada provedor obtén o seu nome e o nome dos artigos que fornece (un artigo por fila). No caso de que non forneza ningún artigo mostrarase o texto ‘NINGÚN’.
SELECT 	prv.prv_nome AS "Nome do provedor",
		ifnull(art.art_nome, "NINGÚN") AS "Nome do artigo"
FROM provedores AS prv
LEFT JOIN artigos AS art ON (prv.prv_id = art.art_provedor);
	

   
   -- • Tarefa 3.2. Obtén o listado de países nos que non hai ningún cliente.
   SELECT pai.pai_nome AS "Nome país"
   FROM paises;
   
   
   
   -- • Tarefa 3.3. Obtén o listado de empregados xunto coa localidade da tenda da que son xerentes, titulando esta columna como loclidade_e_xerente. Se algún empregado non é xerente mostrarase o texto ‘NON É XERENTE’.
SELECT 	emp.*,
        ifnull(tda.tda_poboacion, "NON É XERENTE") AS "localidade_e_xerente"
FROM empregados AS emp
LEFT JOIN tendas AS tda on (tda.tda_xerente = emp.emp_id);
   
   
   
   -- • Tarefa 3.4. Obtén o nome, stock e prezo de venta actual dos artigos, xunto co prezo e data (formato YYYYMMDD) de cada unha das súas vendas. 
SELECT 	art.art_nome "Nome artigo",
		art.art_stock AS "Stock",
        art.art_pv AS "Precio de venta actual",
        dev.dev_prezo_unitario AS "Prezo",
        ven.ven_data AS "Data de compra"
FROM artigos AS art
LEFT JOIN detalle_vendas AS dev ON (dev.dev_artigo = art.art_codigo)
JOIN vendas AS ven ON (dev.dev_venda = ven.ven_id);


   -- • Tarefa 3.5. Obtén o nome, stock e prezo de venta actual dos artigos, xunto co prezo, data (formato YYYYMMDD) e nome do cliente de cada unha das súas vendas. Para os artigos para os que non haxa ningunha venda mostrarase no prezo o valor 0, na data o valor NULL e no nome de cliente o texto ‘NON HAI VALOR’.
SELECT 	art.art_nome AS "Nome artigo",
		art.art_stock AS "Stock artigo",
        art.art_pv AS "Prezo de venda actual",
        ifnull(dev.dev_prezo_unitario, 0) AS "Prezo en el que se vendió",
        ven.ven_data AS "Data venda",
        ifnull(clt.clt_nome, "NON HAI VALOR") AS "Nome cliente"
FROM artigos AS art
LEFT JOIN detalle_vendas AS dev ON (dev.dev_artigo = art.art_codigo)
LEFT JOIN vendas AS ven ON (ven.ven_id = dev.dev_venda)
LEFT JOIN clientes AS clt ON (ven.ven_cliente = clt.clt_id);
	



