<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <p>Welcome to your Vue.js app running inside Docker!</p>
    <p>Message from PHP backend: {{ backendMessage }}</p>
  </div>
</template>

<script>
export default {
  name: "Hello",
  data() {
    return {
      msg: "Hello, Vue.js in Docker!",
      backendMessage: "",
    };
  },
  mounted() {
    // Make a request to the PHP backend
    fetch("/backend/hello.php")
      .then(response => response.json())
      .then(data => {
        this.backendMessage = data.message;
      })
      .catch(error => {
        console.error("Error fetching data from PHP backend:", error);
      });
  },
};
</script>

<style scoped>
.hello {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
