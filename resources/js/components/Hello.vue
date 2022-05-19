<template>
  <h1 class="bg-success text-white"> <i class="bi bi-apple"></i> {{ greeting }}</h1>
</template>
<script>
export default {
  setup: () => ({
    greeting: "Hello World from Vue 3!",
  }),
};
</script>