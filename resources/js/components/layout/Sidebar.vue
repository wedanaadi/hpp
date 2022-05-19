<template>
  <div id="sidebar" class="active">
    <div class="sidebar-wrapper active">
      <div class="sidebar-header">
        <div class="d-flex justify-content-between">
          <div class="logo">
            <a href="index.html"
              ><img :src="`${this.$baseUrl}images/vila.png`" alt="Logo"
            /></a>
          </div>
          <div class="toggler">
            <a href="#" class="sidebar-hide d-xl-none d-block"
              ><i class="bi bi-x bi-middle"></i
            ></a>
          </div>
        </div>
      </div>
      <div class="login-header">
        <div class="d-flex">
          <div>
            <a href="index.html"
              ><img :src="`${this.$baseUrl}images/login.png`" alt="Logo"
            /></a>
          </div>
          <div class="ps-2 d-flex flex-column">
            <span>Selamat Datang!</span>
            <span>{{ nameLogin }}</span>
            <a href="#" @click="logout()" class="logout bg-info text-dark"
              >Logout <i class="bi bi-power"></i
            ></a>
          </div>
        </div>
      </div>
      <div class="sidebar-menu">
        <ul class="menu">
          <li class="sidebar-title">Menu</li>

          <li class="sidebar-item" :class="[routeactive === 'home' ? 'active' : '']">
            <router-link :to="{ name: 'home' }" class="sidebar-link">
              <i class="bi bi-house-door-fill"></i>
              <span>Beranda</span>
            </router-link>
          </li>

          <li class="sidebar-title">Masterdata</li>

          <li
            v-if="level === '3' || level === '0'"
            class="sidebar-item"
            :class="[menuactive === 'supplier' ? 'active' : '']"
          >
            <router-link :to="{ name: 'backend.supplier' }" class="sidebar-link">
              <i class="bi bi-person-workspace"></i>
              <span>Supplier</span>
            </router-link>
          </li>
          <li
            v-if="level === '1' || level === '0'"
            class="sidebar-item"
            :class="[menuactive === 'category' ? 'active' : '']"
          >
            <router-link :to="{ name: 'backend.category' }" class="sidebar-link">
              <i class="bi bi-card-list"></i>
              <span>Category</span>
            </router-link>
          </li>
          <li
            v-if="level === '1' || level === '0'"
            class="sidebar-item"
            :class="[menuactive === 'subcategory' ? 'active' : '']"
          >
            <router-link :to="{ name: 'backend.subcategory' }" class="sidebar-link">
              <i class="bi bi-card-list"></i>
              <span>Subcategory</span>
            </router-link>
          </li>
          <li
            v-if="level === '1' || level === '4' || level === '0'"
            class="sidebar-item"
            :class="[menuactive === 'barang' ? 'active' : '']"
          >
            <router-link :to="{ name: 'backend.barang' }" class="sidebar-link">
              <i class="bi bi-house-door-fill"></i>
              <span>Barang</span>
            </router-link>
          </li>
          <li
            v-if="level === '2' || level === '0'"
            class="sidebar-item"
            :class="[menuactive === 'akun' ? 'active' : '']"
          >
            <router-link :to="{ name: 'backend.akun' }" class="sidebar-link">
              <i class="bi bi-currency-exchange"></i>
              <span>Akun</span>
            </router-link>
          </li>
          <li
            v-if="level === '3' || level === '4' || level === '0'"
            class="sidebar-item"
            :class="[menuactive === 'user' ? 'active' : '']"
          >
            <router-link :to="{ name: 'backend.user' }" class="sidebar-link">
              <i class="bi bi-people-fill"></i>
              <span>User</span>
            </router-link>
          </li>

          <li v-if="level !== '1'" class="sidebar-title">Transaction</li>

          <li
            v-if="level === '3' || level === '0'"
            class="sidebar-item"
            :class="[
              menuactive === 'pembelian' && routeactive === 'backend' ? 'active' : '',
            ]"
          >
            <router-link :to="{ name: 'backend.pembelian' }" class="sidebar-link">
              <i class="bi bi-basket"></i>
              <span>Pembelian</span>
            </router-link>
          </li>
          <li
            v-if="level === '2' || level === '0'"
            class="sidebar-item"
            :class="[
              menuactive === 'penjualan' && routeactive === 'backend' ? 'active' : '',
            ]"
          >
            <router-link :to="{ name: 'backend.penjualan' }" class="sidebar-link">
              <i class="bi bi-bag"></i>
              <span>Penjualan</span>
            </router-link>
          </li>
          <li
            v-if="level === '2' || level === '0'"
            class="sidebar-item"
            :class="[
              menuactive === 'jurnal' && routeactive === 'backend' ? 'active' : '',
            ]"
          >
            <router-link :to="{ name: 'backend.jurnal' }" class="sidebar-link">
              <i class="bi bi-bag"></i>
              <span>Jurnal Umum</span>
            </router-link>
          </li>
          <li
            v-if="level === '4' || level === '0'"
            class="sidebar-item"
            :class="[
              menuactive === 'produksi' && routeactive === 'backend' ? 'active' : '',
            ]"
          >
            <router-link :to="{ name: 'backend.produksi' }" class="sidebar-link">
              <i class="bi bi-box2"></i>
              <span>Produksi</span>
            </router-link>
          </li>

          <li class="sidebar-title">Report</li>
          <li
            v-if="level === '3' || level === '0'"
            class="sidebar-item"
            :class="[
              menuactive === 'pembelian' && routeactive === 'report' ? 'active' : '',
            ]"
          >
            <router-link :to="{ name: 'report.pembelian' }" class="sidebar-link">
              <i class="bi bi-file-earmark-text"></i>
              <span>Pembelian</span>
            </router-link>
          </li>
          <li
            v-if="level === '2' || level === '0'"
            class="sidebar-item"
            :class="[
              menuactive === 'penjualan' && routeactive === 'report' ? 'active' : '',
            ]"
          >
            <router-link :to="{ name: 'report.penjualan' }" class="sidebar-link">
              <i class="bi bi-file-earmark-text"></i>
              <span>Penjualan</span>
            </router-link>
          </li>
          <li
            v-if="level === '1' || level === '0'"
            class="sidebar-item"
            :class="[menuactive === 'stock' && routeactive === 'report' ? 'active' : '']"
          >
            <router-link :to="{ name: 'report.stock' }" class="sidebar-link">
              <i class="bi bi-file-earmark-text"></i>
              <span>Stock Barang</span>
            </router-link>
          </li>
          <li
            v-if="level === '2' || level === '0'"
            class="sidebar-item"
            :class="[
              menuactive === 'labarugi' && routeactive === 'report' ? 'active' : '',
            ]"
          >
            <router-link :to="{ name: 'report.labarugi' }" class="sidebar-link">
              <i class="bi bi-file-earmark-text"></i>
              <span>Laba Rugi</span>
            </router-link>
          </li>
          <li
            v-if="level === '2' || level === '0'"
            class="sidebar-item"
            :class="[menuactive === 'neraca' && routeactive === 'report' ? 'active' : '']"
          >
            <router-link :to="{ name: 'report.neraca' }" class="sidebar-link">
              <i class="bi bi-file-earmark-text"></i>
              <span>Neraca</span>
            </router-link>
          </li>
          <li
            v-if="level === '4' || level === '0'"
            class="sidebar-item"
            :class="[
              menuactive === 'persediaan' && routeactive === 'report' ? 'active' : '',
            ]"
          >
            <router-link :to="{ name: 'report.persediaan' }" class="sidebar-link">
              <i class="bi bi-file-earmark-text"></i>
              <span>HPP</span>
            </router-link>
          </li>
        </ul>
      </div>
      <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      level: localStorage.getItem("level"),
      iduser: localStorage.getItem("id"),
      reload: false,
      treeviewData: {
        master: {
          class: false,
          display: "none",
        },
        transaction: {
          class: false,
          display: "none",
        },
        report: {
          class: false,
          display: "none",
        },
      },
    };
  },
  methods: {
    logout() {
      axios.post(`${this.$baseUrl}api/logout`, { id: this.iduser }).then(() => {
        //remove localStorage
        localStorage.removeItem("loggedIn");
        localStorage.removeItem("token");
        localStorage.removeItem("id");

        //redirect
        return this.$router.push({ name: "login" });
      });
    },
  },
  computed: {
    nameLogin() {
      let name = "Super Admin";
      const level = localStorage.getItem("level");
      if (level === "1") {
        name = "STORE KEEPER";
      } else if (level === "2") {
        name = "KEUANGAN";
      } else if (level === "3") {
        name = "F&B SERVICE";
      } else if (level === "4") {
        name = "F&B PRODUCT";
      } else {
        name = "ADMINISTRATOR";
      }
      return name;
    },
    routeactive() {
      // this.treeviewOnLoad();
      return this.$route.name.split(".")[0];
    },
    menuactive() {
      // this.treeviewOnLoad();
      return this.$route.name.split(".")[1];
    },
  },
};
</script>
