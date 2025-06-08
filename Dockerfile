# Stage 1: Build
FROM python:3.9-alpine AS build-stage
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY script.py .
COPY data.csv .


# Stage 2: Run
FROM python:3.9.18-alpine3.19
WORKDIR /app
COPY --from=build-stage /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=build-stage /app/script.py .
COPY --from=build-stage /app/data.csv .
CMD ["python", "script.py"]
