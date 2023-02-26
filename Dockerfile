FROM python:latest

WORKDIR /opt/status-page/

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ~/final_workshop1/statuspage/manage.py /opt/status-page/
COPY ~/final_workshop1/statuspage/statuspage/setting.py /opt/status-page/statuspage/
COPY . .

RUN #apt-get update && \
    bash ./upgrade.sh && \
    python -m venv /opt/status-page/venv && \
    python /opt/status-page/statuspage/manage.py createsuperuser --no-input --username ub>

EXPOSE 8000 5432 6379

CMD ["python", "/opt/status-page/statuspage/manage.py", "runserver", "0.0.0.0:8000"]
