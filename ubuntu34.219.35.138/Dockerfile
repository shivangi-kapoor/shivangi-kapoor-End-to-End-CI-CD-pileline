# Base image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements first
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the remaining application files
COPY . .

# Expose Flask port
EXPOSE 5000

# Start the Flask application
CMD ["python", "app.py"]