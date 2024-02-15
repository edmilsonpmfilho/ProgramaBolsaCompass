import boto3
import os
import datetime  

AWS_ACCESS_KEY_ID="ASIA2JCCPNMRM7TYYLA6"  # Substitua '--' pelo ID da chave de acesso da AWS
AWS_SECRET_ACCESS_KEY="eie1D00AnlagvZjpnEh1Ud47spSgbzR0i43bxn1C"  # Substitua '--' pela chave secreta de acesso da AWS
AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjENL//////////wEaCXVzLWVhc3QtMSJHMEUCIEUpEX3wPFYMBAvLnkSQo3WmKlzJVond0zd50BF77WQnAiEA5TQ5IALPMB97XvrPy1VZS5B6SNlc5npq36NMXhKoqOgq+AEIq///////////ARAAGgw3MDY2NjE1NDI2OTAiDIu1DXNoYB5bdtzigyrMARP0/iCUNUegbPZGl6uGMEkL7gi9+WvNWiJVWs/TKVconqXtuf/9iscpA5AAiE/073v6nR05MeQ7jjxXaS/czNKdEjBpFcHxuJ5D+FKCcFtZkm+JwfgGBeqIVUTlEvqiRmIBe8I9/QNQm/xjUu4BCSFfjnykM9O0UvjzdnUwpC+pTUTPPeNSsfN4PFxGjnDX/zDk15LG9vn4FRTKYAOyiDI7Cs2ODTctuiihVUZ4HktNWnL1+umP+yNfmuMaepvZSDb77vf7KA4C/0w8rDDuormuBjqYAUzftUOz7lpFbtU7AJmH2991v9gDgIwduBLsBlEN1DNyGfIheuj2jZ/I7eya0SIam3ocYb0IiQENolOZ1yYuX/WLPsVbeZoIp55FHFZ7QPZYEQrhAFxOrz6Pp/djAl6CAgfvXHPHqK9QC+j/nAvEr5AzmrxYatK+SPJ2aARgHwMmg+3kBRFU4X8xWiwYEDnitW37YmJeQrze"  # Substitua '--' pelo token de sessão da AWS, se necessário
AWS_REGION='us-east-1' 

# Configurações
BUCKET_NAME = 'datalake-edmilson'
LOCAL_CSV_FOLDER = '/app/csv'

# iniciar sessão
s3_client = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    aws_session_token=AWS_SESSION_TOKEN,
    region_name=AWS_REGION
)

for csv_file in os.listdir(LOCAL_CSV_FOLDER):
 
    local_csv_path = os.path.join(LOCAL_CSV_FOLDER, csv_file)

    s3_key = f"Raw/Local/CSV/{os.path.splitext(csv_file)[0]}/{datetime.datetime.now().strftime('%Y')}/{datetime.datetime.now().strftime('%m')}/{datetime.datetime.now().strftime('%d')}/{os.path.basename(local_csv_path)}"

    s3_client.upload_file(local_csv_path, BUCKET_NAME, s3_key)

    print(f"Arquivo {local_csv_path} enviado para {s3_key} no S3.")