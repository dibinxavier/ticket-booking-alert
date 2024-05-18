#!/bin/bash

# heroku buildpacks:add heroku/google-chrome
# heroku buildpacks:add heroku/chromedriver

# Install Google Chrome
echo "Install Google Chrome..."
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get update
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb
sudo rm google-chrome-stable_current_amd64.deb

# Install ChromeDriver
echo "Install ChromeDriver..."
CHROMEDRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)
sudo wget -N https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip
sudo unzip chromedriver_linux64.zip
sudo rm chromedriver_linux64.zip
sudo chmod +x chromedriver
sudo mv -f chromedriver /usr/local/bin/chromedriver

# Add any setup commands here
echo "Running setup commands..."

# Example: Setting executable permissions for ChromeDriver
sudo chmod +x /usr/local/bin/chromedriver

# Start your Python script
echo "Starting Python script..."
python3 alert.py

