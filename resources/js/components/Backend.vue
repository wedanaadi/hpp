<template>
  <Sidebar ref="sidebar" @menu="onMenu"></Sidebar>
  <Main></Main>
</template>

<script>
import Sidebar from "./layout/Sidebar.vue";
import Main from "./layout/Main.vue";
export default {
  components: {
    Sidebar,
    Main,
  },
  data() {
    return {
      //state loggedIn with localStorage
      loggedIn: localStorage.getItem("loggedIn"),
      //state token
      token: localStorage.getItem("token"),
      //state user logged In
      user: [],
      setting: [],
      iduser: localStorage.getItem("id"),
      // activename: localStorage.getItem("activename"),
    };
  },
  methods: {
    onMenu() {
      console.log("backend");
    },
    redirect() {
      const activeroute = this.$route.name;
      let url = "home";
      if (activeroute !== "backend") {
        url = activeroute;
      }
      this.$router.push({ name: url });
    },
  },
  created() {
    axios
      .get(`${this.$baseUrl}api/user`, {
        headers: { Authorization: "Bearer " + this.token },
        params: { id: this.iduser },
      })
      .then((response) => {
        this.user = response.data; // assign response to state user
        // return this.$router.push({ name: this.$router.name });
      });
  },
  mounted() {
    if (!this.loggedIn) {
      return this.$router.push({ name: "login" });
    } else {
      this.redirect();
    }
  },
};
</script>
