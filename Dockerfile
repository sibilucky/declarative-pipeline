# Use official httpd image from Docker Hub as the base image
FROM httpd:2.4

# Copy custom index.html to the web server directory
COPY ./index.html /usr/local/apache2/htdocs/

# Expose port 80 for the HTTP server
EXPOSE 80
