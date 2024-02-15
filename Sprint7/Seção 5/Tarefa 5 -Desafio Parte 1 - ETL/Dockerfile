FROM python:3

WORKDIR /app

COPY upload.py /app/

COPY csv /app/csv/

RUN pip install boto3

CMD ["python3", "/app/upload.py"]