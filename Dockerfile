FROM python:3.8.17-slim-bullseye

RUN python -m pip install --upgrade pip && pip install mkdocs

WORKDIR /app
COPY . .

RUN pip install mkdocs-material

EXPOSE 8000
