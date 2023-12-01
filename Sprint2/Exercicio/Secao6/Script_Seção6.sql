
SELECT * FROM livro;
SELECT * FROM autor;
SELECT * FROM editora;



--Exportar o resultado da query que obtém os 10 livros mais caros para um arquivo CSV. 
--Utilizar o caractere ; (ponto e vírgula) como separador. 
--Lembre-se que o conteúdo do seu arquivo deverá respeitar a sequência de colunas e seus respectivos nomes de cabeçalho 
--que listamos abaixo:

--CodLivro
--Titulo
--CodAutor
--NomeAutor
--Valor
--CodEditora
--NomeEditora

SELECT 
	cod As CodLivro,
	titulo AS Titulo,
	autor AS CodAutor,
	autor.nome AS NomeAutor,
	valor AS Valor,
	editora AS CodEditora,
	editora.nome AS NomeEditora
FROM livro
JOIN autor ON autor.codautor = livro.autor
JOIN editora ON editora.codeditora = livro.editora 
ORDER BY valor DESC
LIMIT 10;



--Exportar o resultado da query que obtém as 5 editoras com maior quantidade de livros na biblioteca 
--para um arquivo CSV. Utilizar o caractere | (pipe) como separador. 
--Lembre-se que o conteúdo do seu arquivo deverá respeitar a sequência de colunas e seus respectivos nomes de cabeçalho 
--que listamos abaixo:

--CodEditora
--NomeEditora
--QuantidadeLivros

SELECT
    editora.codeditora AS CodEditora,
    editora.nome AS NomeEditora,
    COUNT(livro.cod) AS QuantidadeLivros
    
FROM
    editora
LEFT JOIN livro ON editora.codeditora = livro.editora
JOIN endereco on endereco.codendereco = editora.endereco 
GROUP BY
    editora.codeditora, editora.nome, endereco.estado, endereco.cidade
ORDER BY
    QuantidadeLivros DESC
LIMIT 5;





