# Use the official Python 3.9 slim image as a base
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Expose port 8080 for communication
EXPOSE 8080

# Command to run the calculator application
CMD ["python", "calculator.py"]