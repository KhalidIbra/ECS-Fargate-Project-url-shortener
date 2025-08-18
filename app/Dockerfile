
FROM python:3.12-alpine AS build
WORKDIR /w
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir --prefix=/out -r requirements.txt
COPY src/ ./src



FROM python:3.12-slim
RUN useradd --no-create-home --uid 10001 newuser
ENV PYTHONPATH=/app \
    TABLE_NAME=changeme
WORKDIR /app
COPY --from=build /out /usr/local
COPY --from=build /w/src /app
USER newuser
EXPOSE 8080
CMD ["python", "-m", "uvicorn", "main:app", "--host=0.0.0.0", "--port=8080"]

