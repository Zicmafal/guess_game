FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app

# Instala as dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o código da aplicação
COPY . .


EXPOSE 5000

# Executa com Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "3", "run:app"]