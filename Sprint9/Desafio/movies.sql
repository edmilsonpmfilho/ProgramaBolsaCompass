CREATE table movies(
	id varchar primary key,
	tituloPrincipal varchar(50),
	anoLancamento date,
	genero varchar(100),
	notaMedia double,
	numeroVotos int,
	id_romance varchar,
	FOREIGN KEY (id_romance) REFERENCES movies_romance(id_romance)
	
)

CREATE table movies_romance(
	id_romance varchar primary key,
	tituloPrincipal varchar(50),
	anoLancamento date,
	genero varchar(100),
	notaMedia double,
	numeroVotos int,
	id_tmdb varchar,
	FOREIGN KEY (id_tmdb) REFERENCES movies_TMDB(imdb_id)
)

CREATE table movies_TMDB(
	imdb_id varchar primary key,
	orçamento double,
	receita double,
	popularidade double,
	classificacao_media double,
	contagem_votos double
)