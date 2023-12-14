import csv

# Função para encontrar o ator com o maior número de filmes
def ator_com_maior_numero_de_filmes(dados):
    ator_mais_filmes = max(dados, key=lambda x: int(x['Number of Movies']))
    return f"{ator_mais_filmes['Actor']} - {ator_mais_filmes['Number of Movies']} filmes"

# Função para calcular a média da receita bruta dos principais filmes
def media_receita_bruta(dados):
    gross_list = [float(x['Gross']) for x in dados if x['Gross'] != '']
    return f"Média de receita bruta : {sum(gross_list) / len(gross_list):.2f} milhões"

# Função para encontrar o ator com a maior média de receita bruta por filme
def ator_com_maior_media_receita_por_filme(dados):
    ator_maior_media = max(dados, key=lambda x: float(x['Average per Movie']))
    return f"{ator_maior_media['Actor']} - {ator_maior_media['Average per Movie']} milhões de dólares por filme"

# Função para contar e listar os filmes principais
def contar_e_listar_filmes_principais(dados):
    filmes_principais = [x['#1 Movie'] for x in dados if x['#1 Movie'] != '']
    filmes_contagem = {filme: filmes_principais.count(filme) for filme in set(filmes_principais)}
    filmes_ordenados = sorted(filmes_contagem.items(), key=lambda x: (-x[1], x[0]))

    resultado = []
    for filme, contagem in filmes_ordenados:
        resultado.append(f"{filme} aparece {contagem} vez(es) na tabela")

    return resultado

# Função para listar os atores ordenados pela receita bruta
def listar_atores_por_receita_bruta(dados):
    atores_ordenados = sorted(dados, key=lambda x: float(x['Total Gross']), reverse=True)

    resultado = []
    for ator in atores_ordenados:
        resultado.append(f"{ator['Actor']} - {ator['Total Gross']} milhões de dólares")

    return resultado

# Função para ler o arquivo CSV e retornar os dados
def ler_dados_csv(nome_arquivo):
    with open(nome_arquivo, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        return list(reader)

# Função para escrever resultados em um arquivo de texto
def escrever_resultados_em_arquivo(nome_arquivo, resultados):
    with open(nome_arquivo, 'w', encoding='utf-8') as file:
        for resultado in resultados:
            file.write(resultado + '\n')

# Leitura dos dados do arquivo CSV
dados_atores = ler_dados_csv('actors.csv')

# Execução das operações e escrita nos arquivos de texto
escrever_resultados_em_arquivo('etapa-1.txt', [ator_com_maior_numero_de_filmes(dados_atores)])
escrever_resultados_em_arquivo('etapa-2.txt', [media_receita_bruta(dados_atores)])
escrever_resultados_em_arquivo('etapa-3.txt', [ator_com_maior_media_receita_por_filme(dados_atores)])
escrever_resultados_em_arquivo('etapa-4.txt', contar_e_listar_filmes_principais(dados_atores))
escrever_resultados_em_arquivo('etapa-5.txt', listar_atores_por_receita_bruta(dados_atores))