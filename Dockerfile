FROM python:3

# Set the working directory in the container
WORKDIR /opt/status-page/

# Copy the requirements file to the container and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files to the container
COPY statuspage/manage.py /opt/status-page/
COPY statuspage/settings.py /opt/status-page/
COPY . .

# Install system dependencies for PostgreSQL
USER root
RUN apt-get update && apt-get install -y libpq-dev

# Collect static files
RUN #apt-get update && \
    bash ./upgrade.sh && \
    python -m venv /opt/status-page/venv && \
    python /opt/status-page/statuspage/manage.py createsuperuser --no-input --username ubuntu1

# Expose port 8000 for the Django application
EXPOSE 8000 5432 6379

# Start the Django development server
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "statuspage.wsgi:application"]
