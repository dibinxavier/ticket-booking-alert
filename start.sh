#!/bin/bash

# heroku buildpacks:add heroku/google-chrome
# heroku buildpacks:add heroku/chromedriver

# Add any setup commands here
echo "Running setup commands..."

# Example: Setting executable permissions for ChromeDriver
chmod +x ./chromedriver

# Start your Python script
echo "Starting Python script..."
python3 alert.py
