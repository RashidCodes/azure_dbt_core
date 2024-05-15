FROM --platform=linux/amd64 python:3.9-slim-bookworm

WORKDIR /opt/adventureworks

COPY adventureworks .
COPY requirements.txt .

RUN pip install -r requirements.txt
RUN dbt deps
CMD ["sh", "-c", "dbt run --target prod --profiles-dir ."]
