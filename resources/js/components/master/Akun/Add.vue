<template>
  <form @submit.prevent="saveAkun()">
    <div class="card">
      <div class="card-header">
        <h4 class="card-title">Tambah Akun</h4>
        <div class="card-tools">
          <router-link :to="{ name: 'backend.akun' }" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Back
          </router-link>
        </div>
      </div>
      <div class="card-body">
        <div class="col-12 col-md-7">
          <div class="form-group">
            <label for="desciption">Desciption</label>
            <input
              v-model="form.desc"
              type="text"
              class="form-control"
              placeholder="Description"
              :class="{ 'is-invalid': form.errors.has('desc') }"
            />
            <div
              class="text-danger"
              v-if="form.errors.has('desc')"
              v-html="form.errors.get('desc')"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-4">
            <div class="form-group">
              <label for="kode">Kode Subklasifikasi</label>
              <v-select
                v-model="form.kode_sub"
                :options="optSub"
                placeholder="Kode Subklasifikasi..."
                :class="{ 'select-invalid': form.errors.has('kode_sub') }"
              ></v-select>
              <div
                class="text-danger select-error"
                v-if="form.errors.has('kode_sub')"
                v-html="form.errors.get('kode_sub')"
              />
            </div>
          </div>
          <div class="col-12 col-md-3 mt-4 g-0">
            <button
              type="button"
              @click="showSubklasifikasi()"
              class="btn btn-info w-100"
            >
              <i class="bi bi-plus-square float-start"></i> Tambah Subklasifikasi
            </button>
          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-4">
            <div class="form-group">
              <label for="kode">Akun Type</label>
              <v-select
                v-model="form.akuntype"
                :options="optType"
                placeholder="Akun Type..."
                :class="{ 'select-invalid': form.errors.has('akuntype') }"
              ></v-select>
              <div
                class="text-danger select-error"
                v-if="form.errors.has('akuntype')"
                v-html="form.errors.get('akuntype')"
              />
            </div>
          </div>
        </div>
      </div>
      <div class="card-footer">
        <button type="submit" class="btn btn-primary float-end" :disabled="disabled">
          <div v-show="loading" class="spinner-border text-white" role="status"></div>
          Simpan
        </button>
      </div>
    </div>
  </form>
  <!-- modal -->
  <div
    class="modal"
    id="modal"
    tabindex="-1"
    data-bs-backdrop="static"
    data-bs-keyboard="false"
  >
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Tambah Kode Subklasifikasi</h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <form @submit.prevent="savesub()">
          <div class="modal-body">
            <div class="form-group">
              <label for="kode">Kode Subklasifikasi</label>
              <input
                v-model="sub.kode_subklasifikasi"
                type="text"
                class="form-control"
                placeholder="Kode Subklasifikasi"
                :class="{ 'is-invalid': sub.errors.has('kode_subklasifikasi') }"
              />
              <div
                class="text-danger"
                v-if="sub.errors.has('kode_subklasifikasi')"
                v-html="sub.errors.get('kode_subklasifikasi')"
              />
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-primary" :disabled="disabled">
              <div v-show="loading" class="spinner-border text-white" role="status"></div>
              Simpan
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- endmodal -->
</template>
<script>
export default {
  data() {
    return {
      loading: false,
      disabled: false,
      form: new Form({
        desc: "",
        kode_sub: null,
        akuntype: null,
      }),
      sub: new Form({
        id: "",
        kode_subklasifikasi: "",
      }),
      optType: ["Aktiva", "Passiva"],
      optSub: [],
    };
  },
  created() {
    this.getDataSubklasifikasi();
  },
  methods: {
    getDataSubklasifikasi() {
      axios
        .get(`${this.$baseUrl}api/subklasifikasi`)
        .then((response) => {
          this.optSub = [];
          response.data.forEach((row) => {
            this.optSub.push(row.kode_subklasifikasi);
          });
        })
        .catch((error) => {
          console.log(error);
        });
    },
    showSubklasifikasi() {
      this.sub.reset();
      this.sub.clear();
      $("#modal").modal("show");
    },
    saveAkun() {
      this.loading = true;
      this.disabled = true;
      this.form
        .post(`${this.$baseUrl}api/akun`)
        .then((respon) => {
          Toast.fire({
            icon: respon.data.icon,
            title: respon.data.message,
          });
          if (respon.data.icon === "success") {
            this.$router.push({ name: "backend.akun" });
          }
        })
        .catch(() => {
          this.loading = false;
          this.disabled = false;
        });
    },
    savesub() {
      this.loading = true;
      this.disabled = true;
      this.sub
        .post(`${this.$baseUrl}api/akun/sub`)
        .then((respon) => {
          this.optSub = [];
          respon.data.subklasifikasi.forEach((ds) => {
            this.optSub.push(ds.kode_subklasifikasi);
          });
          $("#modal").modal("hide");
          Toast.fire({
            icon: "success",
            title: respon.data.message,
          });

          this.loading = false;
          this.disabled = false;
        })
        .catch(() => {
          this.loading = false;
          this.disabled = false;
        });
    },
  },
};
</script>
