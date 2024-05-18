#!/bin/bash

# heroku buildpacks:add heroku/google-chrome
# heroku buildpacks:add heroku/chromedriver

#!/bin/bash

# Install Google Chrome
echo "Install Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt-get update
apt-get install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Install ChromeDriver
echo "Install ChromeDriver..."
CHROMEDRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)
wget -N https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
rm chromedriver_linux64.zip
chmod +x chromedriver
mv -f chromedriver /usr/local/bin/chromedriver

# Add any setup commands here
echo "Running setup commands..."

# Example: Setting executable permissions for ChromeDriver
chmod +x ./chromedriver

# Start your Python script
echo "Starting Python script..."
python3 alert.py
