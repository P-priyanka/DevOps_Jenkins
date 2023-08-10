# Use Nginx as the base image
FROM nginx:latest

# Copy the web pages into the container
COPY index.html /usr/share/nginx/html
COPY login.html /usr/share/nginx/html
COPY signup.html /usr/share/nginx/html

# Expose port 80 for HTTP
EXPOSE 80