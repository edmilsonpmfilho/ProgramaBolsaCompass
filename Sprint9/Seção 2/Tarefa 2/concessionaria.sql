SELECT
	idLocacao,
	idCliente,
	nomeCliente,
	cidadeCliente,
	estadoCliente,
	paisCliente,
	idCarro,
	kmCarro,
	classiCarro,
	marcaCarro,
	modeloCarro,
	anoCarro,
	idcombustivel,
	tipoCombustivel,
	dataLocacao,
	horaLocacao,
	qtdDiaria,
	vlrDiaria,
	dataEntrega,
	horaEntrega,
	idVendedor,
	nomeVendedor,
	sexoVendedor,
	estadoVendedor
FROM
	tb_locacao;


CREATE TABLE cliente (
    idCliente INT PRIMARY KEY,
    nomeCliente VARCHAR(255),
    cidadeCliente VARCHAR(255),
    estadoCliente VARCHAR(255),
    paisCliente VARCHAR(255)
);

INSERT INTO cliente (idCliente, nomeCliente, cidadeCliente, estadoCliente, paisCliente)
SELECT DISTINCT idCliente, nomeCliente, cidadeCliente, estadoCliente, paisCliente
FROM tb_locacao;



CREATE TABLE carro (
	idCarro INT PRIMARY KEY,
	kmCarro INT,
	classiCarro VARCHAR,
	marcaCarro VARCHAR,
	modeloCarro VARCHAR,
	anoCarro INT,
	idcombustivel INT,
	FOREIGN KEY (idcombustivel) REFERENCES combustivel(idcombustivel)
);

INSERT INTO carro (idCarro, kmCarro, classiCarro, marcaCarro, modeloCarro, anoCarro,idcombustivel)
SELECT DISTINCT idCarro, kmCarro, classiCarro, marcaCarro, modeloCarro, anoCarro, idcombustivel
FROM tb_locacao;



CREATE TABLE vendedor (
    idVendedor INT PRIMARY KEY,
	nomeVendedor VARCHAR,
	sexoVendedor SMALLINT,
	estadoVendedor VARCHAR
);

INSERT INTO vendedor (idVendedor, nomeVendedor, sexoVendedor, estadoVendedor)
SELECT DISTINCT idVendedor, nomeVendedor, sexoVendedor, estadoVendedor
FROM tb_locacao;



CREATE TABLE combustivel (
    idcombustivel INT PRIMARY KEY,
	tipoCombustivel VARCHAR
);

INSERT INTO combustivel  (idcombustivel, tipoCombustivel)
SELECT DISTINCT idcombustivel, tipoCombustivel
FROM tb_locacao;

SELECT * from combustivel c 

CREATE TABLE locacao(
	idLocacao INT PRIMARY KEY,
	idCliente INT,
	idVendedor INT,
	idCarro INT,
	dataLocacao DATETIME,
	horaLocacao TIME,
	qtdDiaria INT,
	vlrDiaria DECIMAL,
	dataEntrega DATE,
	horaEntrega TIME,
	
	FOREIGN KEY (idCarro) REFERENCES carro(idCarro)
	FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
	FOREIGN KEY (idVendedor) REFERENCES vendedor(idVendedor)	
)

INSERT INTO locacao  (idLocacao,dataLocacao,horaLocacao,qtdDiaria,vlrDiaria,dataEntrega,horaEntrega,idCliente,idVendedor,idCarro)
SELECT DISTINCT idLocacao,dataLocacao,horaLocacao,qtdDiaria,vlrDiaria,dataEntrega,horaEntrega,idCliente,idVendedor,idCarro
FROM tb_locacao;

SELECT * FROM locacao l 



create table carro_mais (
	idCarroMais INT PRIMARY KEY,
	kmCarro INT,
	classiCarro VARCHAR,
	marcaCarro VARCHAR,
	modeloCarro VARCHAR,
	anoCarro INT
	

)
INSERT INTO carro (idCarro, kmCarro, classiCarro, marcaCarro, modeloCarro, anoCarro)
SELECT DISTINCT idCarro, kmCarro, classiCarro, marcaCarro, modeloCarro, anoCarro
FROM tb_locacao;


create table locacao_carro(
	idLocacao INT PRIMARY KEY,
	idCarro INT,
	dataLocacao DATETIME,
	horaLocacao TIME,
	qtdDiaria INT,
	vlrDiaria DECIMAL,
	dataEntrega DATE,
	horaEntrega TIME,
	FOREIGN KEY (idCarro) REFERENCES carro_mais(idCarroMais)

)

INSERT INTO locacao  (idLocacao,dataLocacao,horaLocacao,qtdDiaria,vlrDiaria,dataEntrega,horaEntrega,idCarro)
SELECT DISTINCT idLocacao,dataLocacao,horaLocacao,qtdDiaria,vlrDiaria,dataEntrega,horaEntrega,idCarro
FROM tb_locacao;