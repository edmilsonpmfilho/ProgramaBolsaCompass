SELECT * FROM tbvendas;
select * from tbvendedor;
select * from tbestoqueproduto;
SELECT * FROM tbdependente;

--E8
--Apresente a query para listar o código e o nome do vendedor com maior número de vendas (contagem), 
--e que estas vendas estejam com o status concluída.  
--As colunas presentes no resultado devem ser, portanto, cdvdd e nmvdd.


SELECT
    tbvendedor.cdvdd,
    tbvendedor.nmvdd
FROM
    tbvendedor
JOIN
    tbvendas ON tbvendas.cdvdd = tbvendedor.cdvdd
WHERE
    tbvendas.status = 'Concluído'
GROUP BY
    tbvendedor.cdvdd, tbvendedor.nmvdd
ORDER BY
    COUNT(tbvendas.cdven) DESC
LIMIT 1;



--E9
--Apresente a query para listar o código e nome do produto mais vendido entre as datas de 2014-02-03 até 2018-02-02,
-- e que estas vendas estejam com o status concluída. 
--As colunas presentes no resultado devem ser cdpro e nmpro.
SELECT 
	cdpro,
	nmpro
FROM 
	tbvendas
WHERE dtven BETWEEN '2014-02-03' AND '2018-02-02' AND tbvendas.status = 'Concluído'
GROUP BY 
	cdpro, nmpro 
ORDER BY 
	COUNT(qtd) DESC
LIMIT 1;


--E10
--A comissão de um vendedor é definida a partir de um percentual sobre o total de vendas (quantidade * valor unitário) 
--por ele realizado. O percentual de comissão de cada vendedor está armazenado na coluna perccomissao, tabela tbvendedor. 
--Com base em tais informações, calcule a comissão de todos os vendedores, 
--considerando todas as vendas armazenadas na base de dados com status concluído.
--As colunas presentes no resultado devem ser vendedor, valor_total_vendas e comissao. 
--O valor de comissão deve ser apresentado em ordem decrescente arredondado na segunda casa decimal.
SELECT
    tbvendedor.nmvdd as vendedor,
    SUM(tbvendas.qtd * tbvendas.vrunt) AS valor_total_vendas,
    ROUND(SUM((tbvendas.qtd * tbvendas.vrunt * (tbvendedor.perccomissao*100))/100)) AS comissao
FROM
    tbvendedor
JOIN
    tbvendas  ON tbvendas.cdvdd = tbvendedor.cdvdd
WHERE
    tbvendas.status = 'Concluído'
GROUP BY
    tbvendedor.nmvdd, tbvendedor.perccomissao
ORDER BY
    comissao DESC;
   
   
--E11
--Apresente a query para listar o código e nome cliente com maior gasto na loja.
-- As colunas presentes no resultado devem ser cdcli, nmcli e gasto, 
--esta última representando o somatório das vendas (concluídas) atribuídas ao cliente.
   SELECT
    tbvendas.cdcli,
    tbvendas.nmcli,
    ROUND(SUM(tbvendas.qtd * tbvendas.vrunt), 2) AS gasto
FROM
    tbvendas
WHERE
    tbvendas.status = 'Concluído'
GROUP BY
    tbvendas.cdcli, tbvendas.nmcli
ORDER BY
    gasto DESC
LIMIT 1;

--E12
--Apresente a query para listar código, nome e data de nascimento dos dependentes do vendedor 
--com menor valor total bruto em vendas (não sendo zero). 
--As colunas presentes no resultado devem ser cddep, nmdep, dtnasc e valor_total_vendas.
--Observação: Apenas vendas com status concluído.
SELECT
   cddep,
    nmdep,
    dtnasc,
    ROUND(SUM(tbvendas.qtd * tbvendas.vrunt), 2) AS valor_total_vendas
FROM
    tbdependente  
JOIN
    tbvendedor  ON tbvendedor.cdvdd = tbdependente.cdvdd
JOIN
    tbvendas  ON tbvendas.cdvdd = tbvendedor.cdvdd
WHERE
    tbvendas.status = 'Concluído'
    --AND SUM(tbvendas.qtd * tbvendas.vrunt) > 0
GROUP BY
    tbdependente.cddep, tbdependente.nmdep, tbdependente.dtnasc
ORDER BY
    valor_total_vendas ASC
LIMIT 1;

--E13
--Apresente a query para listar os 10 produtos menos vendidos pelos canais de 
--E-Commerce ou Matriz (Considerar apenas vendas concluídas).  
--As colunas presentes no resultado devem ser cdpro, nmcanalvendas, nmpro e quantidade_vendas.
SELECT
    tbestoqueproduto.cdpro,
    tbvendas.nmcanalvendas,
    tbvendas.nmpro ,
    SUM(tbvendas.qtd) AS quantidade_vendas
FROM
    tbvendas
JOIN
    tbestoqueproduto  ON tbvendas.cdpro = tbestoqueproduto.cdpro
WHERE
    tbvendas.status = 'Concluído'
    AND (tbvendas.nmcanalvendas  = 'Ecommerce' OR tbvendas.nmcanalvendas = 'Matriz')
GROUP BY
    tbestoqueproduto.cdpro, tbvendas.nmcanalvendas, tbvendas.nmpro 
ORDER BY
    quantidade_vendas 
LIMIT 10;


--E14
--Apresente a query para listar o gasto médio por estado da federação.
--As colunas presentes no resultado devem ser estado e gastomedio. 
--Considere apresentar a coluna gastomedio arredondada na segunda casa decimal e ordenado de forma decrescente.
--Observação: Apenas vendas com status concluído.
SELECT
    tbvendas.estado  AS estado,
    ROUND(AVG(tbvendas.qtd * tbvendas.vrunt), 2) AS gastomedio
FROM
    tbvendas  
WHERE
    tbvendas.status = 'Concluído'
GROUP BY
    tbvendas.estado 
ORDER BY
    gastomedio DESC;

--E15
--Apresente a query para listar os códigos das vendas identificadas como deletadas. 
--Apresente o resultado em ordem crescente.
SELECT
    cdven
FROM
    tbvendas
WHERE
    deletado ="1"
ORDER BY
    cdven ASC;


--E16--
--Apresente a query para listar a quantidade média vendida de cada produto agrupado por estado da federação. 
--As colunas presentes no resultado devem ser estado e nmprod e quantidade_media. 
--Considere arredondar o valor da coluna quantidade_media na quarta casa decimal. 
--Ordene os resultados pelo estado (1º) e nome do produto (2º).
--Obs: Somente vendas concluídas.
   
SELECT
    tbvendas.estado AS estado,
    tbvendas.nmpro,
    ROUND(AVG(tbvendas.qtd), 4) AS quantidade_media
FROM
    tbvendas

WHERE
    tbvendas.status = 'Concluído'
GROUP BY
    estado, tbvendas.nmpro
ORDER BY
    estado ASC, tbvendas.nmpro ASC;



