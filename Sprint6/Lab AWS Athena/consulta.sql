WITH Decada AS (
	SELECT nome,
	SUM(total) as total_nomes,
		FLOOR(ano / 10) * 10 AS decada,
		DENSE_RANK() OVER (
			PARTITION BY FLOOR(ano / 10) * 10
			ORDER BY SUM(total) DESC
		) AS ranked
	FROM nome
	WHERE ano >= 1950
	GROUP BY FLOOR(ano / 10) * 10,
		nome
)
SELECT decada,
	nome,
	total_nomes,
	ranked
FROM Decada
WHERE ranked <= 3
ORDER BY decada,
	ranked;