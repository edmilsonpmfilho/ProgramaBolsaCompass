## Explicação da camada Trusted e Refined

### CSV
Para o arquivo CSV utilizei a base de dados movies.csv que foi disponibilizado e estava na camada Raw. Para fazer os CSV para camada Trusted retirei as colunas que não seriam utilizadas, uma filtragem dos filmes do Gênero Romance, após isso fiz a limpeza dos id’s duplicados, retirada dos linhas com dados vazios e depois a retirada das linhas com dados \N. Com isso criei um CSV com apenas os filmes de Romance e para o CSV de filmes completos. Converti os dados para .parquet e enviei para o S3.

### JSON
Para os arquivos JSON o peguei os dados da camada Raw e fiz a junção dos mesmo em relação aos id’s únicos existentes no arquivo csv de romance para pegar os dados necessários. Depois salvei em parquet para a trusted. Para a Refined excluir os atributos que não usaria.

### Modelagem
Para o modelagem da refined crie 3 tabelas para pegar os dados de todos os filmes, os dados dos filmes de romance e os dados complementares dos filmes de romance que estavam no json do TMDB.
