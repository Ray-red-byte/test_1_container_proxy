# Use the official PHP image with Apache
FROM php:8.2-apache

# Copy the PHP application to the Apache root directory
COPY . /var/www/html/

# Expose port 8080
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
