-- E1
--Apresente a query para listar todos os livros publicados após 2014. 
--Ordenar pela coluna cod, em ordem crescente, as linhas.  
--Atenção às colunas esperadas no resultado final: cod, titulo, autor, editora, valor, publicacao, edicao, idioma

SELECT 
	* 
FROM livro
WHERE publicacao > "2014-12-31"
ORDER BY cod
LIMIT 10;


--E2
--Apresente a query para listar os 10 livros mais caros. 
--Ordenar as linhas pela coluna valor, em ordem decrescente.  
--Atenção às colunas esperadas no resultado final:  titulo, valor.
SELECT  
	cod
    titulo, 
	valor 
FROM livro
ORDER BY valor DESC
LIMIT 10;


--E3
 --Apresente a query para listar as 5 editoras com mais livros na biblioteca. 
 --O resultado deve conter apenas as colunas quantidade, nome, estado e cidade. 
 --Ordenar as linhas pela coluna que representa a quantidade de livros em ordem decrescente.

SELECT
   COUNT(livro.cod) AS quantidade,
    editora.nome,
    endereco.estado,
    endereco.cidade
FROM
    editora
LEFT JOIN livro ON editora.codeditora = livro.editora
JOIN endereco on endereco.codendereco = editora.endereco 
GROUP BY
    editora.codeditora, editora.nome, endereco.estado, endereco.cidade
HAVING quantidade > 0
ORDER BY
    quantidade DESC
LIMIT 5;




--E4
--Apresente a query para listar a quantidade de livros publicada por cada autor. 
--Ordenar as linhas pela coluna nome (autor), em ordem crescente. 
--Além desta, apresentar as colunas codautor, nascimento e quantidade (total de livros de sua autoria)

SELECT
    autor.codautor,
    autor.nome,
    autor.nascimento,
    COALESCE(COUNT(livro.cod), 0) AS quantidade
FROM
    autor
LEFT JOIN livro ON autor.codautor = livro.autor
GROUP BY
    autor.codautor, autor.nome, autor.nascimento
ORDER BY
    autor.nome ASC;
   
   
--E5
--Apresente a query para listar o nome dos autores que publicaram livros através de editoras 
--NÃO situadas na região sul do Brasil. Ordene o resultado pela coluna nome, em ordem crescente.
-- Não podem haver nomes repetidos em seu retorno.
 
   
SELECT DISTINCT
    autor.nome
FROM
    autor
JOIN livro ON autor.codautor = livro.autor
JOIN editora ON livro.editora = editora.codeditora
JOIN  endereco ON endereco.codendereco = editora.endereco 
WHERE
    endereco.estado <> 'PARANÁ' OR  'RIO GRANDE DO SUL'
ORDER BY
    autor.nome;
   
   
--E6
--Apresente a query para listar o autor com maior número de livros publicados. 
--O resultado deve conter apenas as colunas codautor, nome, quantidade_publicacoes.
SELECT
  	autor.codautor,
	autor.nome,
    COUNT(livro.cod) AS quantidade_publicacoes
FROM
    autor
JOIN livro ON autor.codautor = livro.autor
GROUP BY
    autor.codautor, autor.nome
ORDER BY
    quantidade_publicacoes DESC
LIMIT 1;

   

--E7
--Apresente a query para listar o nome dos autores com nenhuma publicação. 
--Apresentá-los em ordem crescente.
SELECT
    autor.nome
FROM
    autor
LEFT JOIN livro ON autor.codautor = livro.autor
WHERE
    livro.cod IS NULL
ORDER BY
    autor.nome;


