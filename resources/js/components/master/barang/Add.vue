<template>
  <form @submit.prevent="saveBarang()">
    <div class="card">
      <div class="card-header">
        <h4 class="card-title">Tambah Barang</h4>
        <div class="card-tools">
          <router-link :to="{ name: 'backend.barang' }" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Back
          </router-link>
        </div>
      </div>
      <div class="card-body">
        <div class="row">
          <div class="col-12 col-md-5">
            <div class="form-group">
              <label for="desciption">Article No.</label>
              <input
                v-model="form.articleNo"
                type="text"
                class="form-control"
                placeholder="Article No."
                :class="{ 'is-invalid': form.errors.has('articleNo') }"
              />
              <div
                class="text-danger"
                v-if="form.errors.has('articleNo')"
                v-html="form.errors.get('articleNo')"
              />
            </div>
          </div>
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
        </div>
        <div class="row">
          <div class="col-12 col-md-3">
            <div class="form-group">
              <label for="unit">Jenis</label>
              <v-select
                v-model="form.jenis"
                :reduce="(option) => option.code"
                :options="optJenis"
                placeholder="Jenis Barang..."
                :class="{ 'select-invalid': form.errors.has('jenis') }"
              ></v-select>
              <div
                class="text-danger select-error"
                v-if="form.errors.has('jenis')"
                v-html="form.errors.get('jenis')"
              />
            </div>
          </div>
          <div class="col-12 col-md-3">
            <div class="form-group">
              <label for="unit">Subcategory</label>
              <v-select
                v-model="form.subcategory"
                :reduce="(option) => option.code"
                :options="optSubcategory"
                placeholder="Subcategory..."
                :class="{ 'select-invalid': form.errors.has('subcategory') }"
              ></v-select>
              <div
                class="text-danger select-error"
                v-if="form.errors.has('subcategory')"
                v-html="form.errors.get('subcategory')"
              />
            </div>
          </div>
          <div class="col-12 col-md-3">
            <div class="form-group">
              <label for="unit">Unit</label>
              <v-select
                v-model="form.unit"
                :options="optUnit"
                :reduce="(option) => option.code"
                placeholder="Unit..."
                :class="{ 'select-invalid': form.errors.has('unit') }"
              ></v-select>
              <div
                class="text-danger select-error"
                v-if="form.errors.has('unit')"
                v-html="form.errors.get('unit')"
              />
            </div>
          </div>
          <div class="col-12 col-md-3 mt-4 g-0">
            <button
              type="button"
              @click="showSubklasifikasi()"
              class="btn btn-info w-100"
            >
              <i class="bi bi-plus-square float-start"></i> Tambah Unit
            </button>
          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-4">
            <label for="avrg">Average Price</label>
            <VueNumberFormat
              v-model:value="form.avrg"
              class="form-control text-end"
              :class="{ 'is-invalid': form.errors.has('avrg') }"
            ></VueNumberFormat>
            <div
              class="text-danger select-error"
              v-if="form.errors.has('avrg')"
              v-html="form.errors.get('avrg')"
            />
          </div>
          <div class="col-12 col-md-3">
            <div class="form-group">
              <label for="desciption">Stock</label>
              <input
                v-model="form.stock"
                type="number"
                class="form-control text-end"
                placeholder="Stock"
                :class="{ 'is-invalid': form.errors.has('stock') }"
              />
              <div
                class="text-danger"
                v-if="form.errors.has('stock')"
                v-html="form.errors.get('stock')"
              />
            </div>
          </div>
          <div class="col-12 col-md">
            <label for="formGambar">Gambar</label>
            <input
              id="formGambar"
              class="form-control"
              type="file"
              name="file"
              @change="handleFile"
              :class="{ 'is-invalid': form.errors.has('file') }"
            />
            <HasError :form="form" field="file" />
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
        <form @submit.prevent="saveUnit()">
          <div class="modal-body">
            <div class="form-group">
              <label for="kode">Nama Unit</label>
              <input
                v-model="unit.nama_satuan"
                type="text"
                class="form-control"
                placeholder="Nama Unit"
                :class="{ 'is-invalid': unit.errors.has('nama_satuan') }"
              />
              <div
                class="text-danger"
                v-if="unit.errors.has('nama_satuan')"
                v-html="unit.errors.get('nama_satuan')"
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
        articleNo: "",
        desc: "",
        jenis: null,
        subcategory: null,
        unit: null,
        avrg: 0,
        stock: 0,
        file: null,
      }),
      unit: new Form({
        id: "",
        nama_satuan: "",
      }),
      optJenis: [
        { code: "1", label: "Barang Baku" },
        { code: "2", label: "Barang Jadi" },
      ],
      optUnit: [],
      optSubcategory: [],
    };
  },
  created() {
    this.getSubcategory();
    this.getUnit();
  },
  methods: {
    handleFile(event) {
      // We'll grab just the first file...
      // You can also do some client side validation here.
      const file = event.target.files[0];

      // Set the file object onto the form...
      this.form.file = file;
    },
    getSubcategory() {
      axios
        .get(`${this.$baseUrl}api/subcategory`, { params: { showdata: true } })
        .then((response) => {
          this.optSubcategory = [];
          response.data.forEach((row) => {
            this.optSubcategory.push({ code: row.id, label: row.subcategory_name });
          });
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getUnit() {
      axios
        .get(`${this.$baseUrl}api/unit`)
        .then((response) => {
          this.optUnit = [];
          response.data.forEach((row) => {
            this.optUnit.push({ code: row.id, label: row.nama_satuan });
          });
        })
        .catch((error) => {
          console.log(error);
        });
    },
    showSubklasifikasi() {
      this.unit.reset();
      this.unit.clear();
      $("#modal").modal("show");
    },
    saveBarang() {
      this.loading = true;
      this.disabled = true;
      this.form
        .post(`${this.$baseUrl}api/barang`)
        .then((respon) => {
          Toast.fire({
            icon: respon.data.icon,
            title: respon.data.message,
          });
          if (respon.data.icon === "success") {
            this.$router.push({ name: "backend.barang" });
          }
        })
        .catch(() => {
          this.loading = false;
          this.disabled = false;
        });
    },
    saveUnit() {
      this.loading = true;
      this.disabled = true;
      this.unit
        .post(`${this.$baseUrl}api/unit`)
        .then((respon) => {
          this.optUnit = [];
          respon.data.unit.forEach((ds) => {
            this.optUnit.push({ code: ds.id, label: ds.nama_satuan });
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
