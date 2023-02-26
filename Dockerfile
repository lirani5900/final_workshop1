FROM python:3

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create a non-root user for running the application
RUN useradd -m -u 1000 -s /bin/bash statususer
USER statususer

# Set the working directory in the container
WORKDIR /opt/status-page

# Update the package manager and install system dependencies for PostgreSQL
USER root
RUN apt-get update && apt-get install -y libpq-dev
USER statususer

# Copy the requirements file to the container and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files to the container
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose port 8000 for the Django application
EXPOSE 8000

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
