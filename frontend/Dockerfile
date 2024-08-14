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
COPY App.vue src/App.vue

# Install project dependencies
RUN npm install

# Build the Vue.js project
RUN npm run build

# Install a simple web server to serve the static files
RUN npm install -g serve

# Expose port 5000
EXPOSE 5000

# Command to run the static file server
CMD ["serve", "-s", "dist", "-l", "5000"]