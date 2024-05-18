# Use a base image with Python
FROM python:3.9-slim

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    libxkbcommon0 \
    libxrandr2 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libcurl4 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libu2f-udev \
    libvulkan1 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    fonts-liberation \
    xdg-utils \
    --no-install-recommends

# Install Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp && \
    dpkg -i /tmp/google-chrome-stable_current_amd64.deb && \
    rm /tmp/google-chrome-stable_current_amd64.deb

# Download and install ChromeDriver from the provided URL
RUN wget -N https://storage.googleapis.com/chrome-for-testing-public/125.0.6422.60/linux64/chromedriver-linux64.zip -P /tmp && \
    unzip /tmp/chromedriver-linux64.zip -d /usr/local/bin && \
    rm /tmp/chromedriver-linux64.zip

# Copy your Python script into the container
COPY alert.py /app/

# Set the working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Start your Python script
CMD ["python", "alert.py"]
