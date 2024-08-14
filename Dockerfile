# Stage 1: Build Vue.js application
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Install Vue CLI globally
RUN npm install -g @vue/cli

# Create a new Vue.js project
RUN vue create my-vue-app --default --packageManager=npm

# Change working directory to the newly created project
WORKDIR /app/my-vue-app

# Install babel-eslint and other required packages
RUN npm install babel-eslint eslint-plugin-vue @vue/cli-plugin-eslint --save-dev


# Create or modify the .eslintrc.js to disable the multi-word-component-names rule
RUN echo "module.exports = { root: true, env: { node: true }, extends: ['plugin:vue/essential', 'eslint:recommended'], parserOptions: { parser: 'babel-eslint' }, rules: { 'vue/multi-word-component-names': 'off' } };" > .eslintrc.js

# Copy the App.vue file into the project
COPY frontend/App.vue src/App.vue

# Install project dependencies
RUN npm install

# Build the Vue.js project
RUN npm run build

# Install a simple web server to serve the static files
RUN npm install -g serve

# Stage 2: Use the official PHP image with Apache
FROM php:8.2-apache

# Install necessary packages and enable required Apache modules
RUN apt-get update && \
    apt-get install -y \
        supervisor \
        npm && \
    npm install -g serve && \
    a2enmod proxy && \
    a2enmod proxy_http && \
    a2enmod rewrite && \
    a2enmod headers

# Copy Apache configuration
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Copy PHP application and Vue.js build files to Apache
COPY backend /var/www/html/backend
# Copy the built Vue.js application to a public directory
COPY --from=build /app/my-vue-app/dist /var/www/html/frontend

# Expose only port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
