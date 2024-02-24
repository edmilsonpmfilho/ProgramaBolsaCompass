#import
import boto3
import os
import datetime  
import pandas as pd
import requests
import json
from IPython.display import display

#Credenciais
AWS_ACCESS_KEY_ID=""  # Substitua '--' pelo ID da chave de acesso da AWS
AWS_SECRET_ACCESS_KEY=""  # Substitua '--' pela chave secreta de acesso da AWS
AWS_SESSION_TOKEN=""  # Substitua '--' pelo token de sessão da AWS, se necessário
AWS_REGION='us-east-1' 
api_key = "Coloque aqui sua key"


# Configurações
BUCKET_NAME = 'datalake-edmilson'
LOCAL_JSON_FOLDER = 'Coloque aqui o local onde o arquivo q deseja upar na S3 está'
base_url = "https://api.themoviedb.org/3/discover/movie"


# iniciar sessão
s3_client = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    aws_session_token=AWS_SESSION_TOKEN,
    region_name=AWS_REGION
)


def obter_caminho_arquivo(arquivo, pasta):
    return os.path.join(pasta, arquivo)

generos_filmes = {
    "Ação": 28,
    "Aventura": 12,
    "Animação": 16,
    "Comédia": 35,
    "Crime": 80,
    "Documentário": 99,
    "Drama": 18,
    "Família": 10751,
    "Fantasia": 14,
    "História": 36,
    "Terror": 27,
    "Música": 10402,
    "Mistério": 9648,
    "Romance": 10749,
    "Ficção científica": 878,
    "Filme de TV": 10770,
    "Suspense": 53,
    "Guerra": 10752,
    "Faroeste": 37
}

print("Códigos dos gêneros de filmes no TMDb:")
for genero, codigo in generos_filmes.items():
    print(f"{genero}: {codigo}")
genero = input("Digite o ID do gênero dos filmes : ")
ano_inicio = input("Digite o ano de início do período de tempo (por exemplo, 2000): ")
ano_fim = input("Digite o ano de fim do período de tempo (por exemplo, 2022): ")


movies = []
total_filmes = 0
pagina = 1


# Loop para percorrer as páginas até que o total de 100 filmes seja alcançado
while total_filmes < 100:
    # Construindo a URL com os parâmetros de consulta
    url = f"{base_url}?api_key={api_key}&language=pt-BR&page={pagina}&with_genres={genero}&primary_release_date.gte={ano_inicio}-01-01&primary_release_date.lte={ano_fim}-12-31&sort_by=popularity.desc"
    # Obtendo os dados da API
    response = requests.get(url)
    data = response.json()
    
    # Selecionando os detalhes dos filmes e adicionando à lista
    for movie in data['results']:
        detalhes = {
            'Titulo': movie['title'],
            'Data de lancamento': movie['release_date'],
            'Visao geral': movie['overview'].split('.'),
            'Votos': movie['vote_count'],
            'Media de votos:': movie['vote_average'],
            'Popularidade:':movie['popularity']
            
        }
        movies.append(detalhes)
        total_filmes += 1
    pagina += 1


#criando o arquivo json e salvando na pasta
arquivo = input("Digite o nome do Arquivo: ")
arquivo = arquivo +".json"
caminho_completo = obter_caminho_arquivo(arquivo, LOCAL_JSON_FOLDER)
with open(caminho_completo, 'w',encoding='utf-8') as json_file:
    json.dump(movies, json_file, indent=4, ensure_ascii=False)
print(f"Dados dos filmes foram gravados em '{caminho_completo}'.")


#Enviando para o S3
for csv_file in os.listdir(LOCAL_JSON_FOLDER):
    local_csv_path = os.path.join(LOCAL_JSON_FOLDER, csv_file)
    s3_key = f"Raw/tmdb/json/{os.path.splitext(csv_file)[0]}/{datetime.datetime.now().strftime('%Y')}/{datetime.datetime.now().strftime('%m')}/{datetime.datetime.now().strftime('%d')}/{os.path.basename(local_csv_path)}"
    s3_client.upload_file(local_csv_path, BUCKET_NAME, s3_key)
    print(f"Arquivo {local_csv_path} enviado para {s3_key} no S3.")