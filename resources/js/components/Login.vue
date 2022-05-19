<template>
  <div class="login">
    <div class="container">
      <div class="d-flex flex-row justify-content-center p-5">
        <img class="ps-2" :src="`${this.$baseUrl}images/vila.png`" width="200" />
      </div>
      <div class="row justify-content-center">
        <div class="col-md-5">
          <div v-if="loginFailed" class="alert alert-danger">
            Username atau Password Anda salah.
          </div>
          <div class="card">
            <div class="card-body">
              LOGIN
              <hr />
              <form @submit.prevent="login">
                <div class="form-group">
                  <label>USERNAME</label>
                  <input
                    type="text"
                    class="form-control"
                    v-model="user.username"
                    placeholder="Masukkan Username"
                  />
                  <div v-if="validation.username" class="mt-2 alert alert-danger">
                    Masukkan Username
                  </div>
                </div>

                <div class="form-group">
                  <label>PASSWORD</label>
                  <input
                    type="password"
                    v-model="user.password"
                    class="form-control"
                    placeholder="Masukkan Password"
                  />
                  <div v-if="validation.password" class="mt-2 alert alert-danger">
                    Masukkan Password
                  </div>
                </div>
                <button type="submit" class="btn btn-primary mt-3" :disabled="disabled">
                  <i v-show="loading" class="fas fa-spinner fa-pulse"></i> LOGIN
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      setting: [],
      //state loggedIn with localStorage
      loggedIn: localStorage.getItem("loggedIn"),
      //state token
      token: localStorage.getItem("token"),
      //state user
      user: {
        username: null,
        password: null,
      },
      //state validation
      validation: [],
      //state login failed
      loginFailed: null,
      loading: false,
      disabled: false,
    };
  },
  methods: {
    login() {
      if (this.user.username && this.user.password) {
        this.loading = true;
        this.disabled = true;
        axios.get(`${this.$baseUrl}sanctum/csrf-cookie`).then((response) => {
          //debug cookie
          // console.log(response);

          axios
            .post(`${this.$baseUrl}api/login`, {
              username: this.user.username,
              password: this.user.password,
            })
            .then((res) => {
              //debug user login
              console.log(res);

              if (res.data.success) {
                //set localStorage
                localStorage.setItem("loggedIn", "true");

                //set localStorage Token
                localStorage.setItem("token", res.data.token);
                localStorage.setItem("id", res.data.user.id);
                // const act =
                //   res.data.user.ksm_id === "0" ? "Admin" : res.data.user.ksm.nama_ksm;
                // localStorage.setItem("activename", act);
                localStorage.setItem("level", res.data.user.hak_akses);

                //change state
                this.loggedIn = true;

                //redirect dashboard
                return this.$router.push({ name: "home" });
              } else {
                //set state login failed
                this.loginFailed = true;
                this.loading = false;
                this.disabled = false;
              }
            })
            .catch((error) => {
              console.log(error);
              this.loading = false;
              this.disabled = false;
            });
        });
      }

      this.validation = [];

      if (!this.user.username) {
        this.validation.username = true;
      }

      if (!this.user.password) {
        this.validation.password = true;
      }
    },
  },
  // created() {
  //   this.getSetting();
  // },
  mounted() {
    if (this.loggedIn) {
      return this.$router.push({ name: "backend" });
    }
  },
};
</script>

<style></style>
