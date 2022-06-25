<template>
  <form @submit.prevent="saveSale()" autocomplete="off">
    <div class="card">
      <div class="card-header">
        <h4 class="card-title">Tambah Penjualan</h4>
        <div class="card-tools">
          <router-link :to="{ name: 'backend.penjualan' }" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Back
          </router-link>
        </div>
      </div>
      <div class="card-body">
        <div class="row">
          <div class="col-12 col-md-3">
            <div class="form-group">
              <label for="tanggal">Tanggal</label>
              <v-datepicker
                :format="format"
                v-model="form.tanggal"
                autoApply
                monthNameFormat="long"
                :enableTimePicker="false"
                :class="{ 'is-invalid': form.errors.has('tanggal') }"
              />
              <div
                class="text-danger"
                v-if="form.errors.has('tanggal')"
                v-html="form.errors.get('tanggal')"
              />
            </div>
          </div>
          <div class="col-12 col-md-3">
            <div class="form-group">
              <label for="tx">Kode Transaksi</label>
              <input
                v-model="form.notrx"
                type="text"
                class="form-control"
                placeholder="auto"
                readonly
              />
            </div>
          </div>
          <div class="col-12 col-md-6">
            <div class="form-group">
              <label for="desc">Deskripsi/Note</label>
              <input
                v-model="form.desc"
                id="desc"
                type="text"
                class="form-control"
                placeholder="Description/Note"
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
          <div class="col-12 col-md-5">
            <div class="form-group">
              <label for="">Akun</label>
              <v-select
                v-model="form.akun"
                :reduce="(option) => option.code"
                :options="optAkun"
                placeholder="Akun..."
                :class="{ 'select-invalid': form.errors.has('akun') }"
              ></v-select>
              <div
                class="text-danger"
                v-if="form.errors.has('akun')"
                v-html="form.errors.get('akun')"
              />
            </div>
          </div>
          <div class="col-12 col-md-3 mt-4">
            <div class="form-group mb-0">
              <button type="button" class="btn btn-info" @click="showListBarang()">
                Tambah Menu
              </button>
            </div>
          </div>
        </div>
        <hr />
        <div v-if="form.errors.has('barangbuy')" class="alert alert-danger" role="alert">
          {{ form.errors.get("barangbuy") }}
        </div>
        <!-- data barang beli -->
        <div class="datatable-style">
          <!-- table -->
          <div class="table-responsive">
            <table class="table table-bordered nowrap">
              <thead class="table-dark">
                <tr class="text-center">
                  <th style="width: 50px">No</th>
                  <th
                    v-for="column in columns"
                    :key="column.name"
                    @click="sortBy(column.name)"
                    :class="
                      sortKey === column.name
                        ? sortOrders[column.name] > 0
                          ? 'sorting_asc'
                          : 'sorting_desc'
                        : 'sorting'
                    "
                    :style="column.style"
                  >
                    {{ column.label }}
                  </th>
                  <th style="width: 150px">Aksi</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(r, i) in filteredDatas" :key="i">
                  <td class="text-center">{{ i + 1 }}</td>
                  <td>{{ r.articleNo }}</td>
                  <td>{{ r.barangname }}</td>
                  <!-- <td>{{ r.unit }}</td> -->
                  <td class="text-end">{{ r.qty }}</td>
                  <td class="text-end">
                    {{ vueNumberFormat(r.price, { precision: 0 }) }}
                  </td>
                  <td class="text-end">
                    {{ vueNumberFormat(r.priceActual, { precision: 0 }) }}
                  </td>
                  <td class="text-end">
                    {{ vueNumberFormat(r.qty * r.priceActual, { precision: 0 }) }}
                  </td>
                  <td class="text-center">
                    <button
                      @click="editRow(i, r)"
                      type="button"
                      class="btn btn-outline-warning"
                    >
                      <i style="cursor: pointer" class="bi bi-pencil-fill"></i>
                    </button>
                    ||
                    <button
                      @click="deleteRow(i, r)"
                      type="button"
                      class="btn btn-outline-danger"
                    >
                      <i style="cursor: pointer" class="bi bi-trash2-fill"></i>
                    </button>
                  </td>
                </tr>
                <tr v-show="tableLoading">
                  <td colspan="7" class="text-center">Loading...</td>
                </tr>
                <tr v-show="paginatedDatas.length === 0 && !tableLoading">
                  <td colspan="7" class="text-center">Tidak ada data...</td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <th class="text-end fw-bold" colspan="6">Total</th>
                  <th class="text-end fw-bold">
                    {{ vueNumberFormat(countSaldo, { precision: 2 }) }}
                  </th>
                  <th></th>
                </tr>
              </tfoot>
            </table>
          </div>
          <!-- end table -->
        </div>
        <!-- end data barang beli -->
      </div>
      <div class="card-footer">
        <button type="submit" class="btn btn-primary float-end" :disabled="disabled">
          <div v-show="loading" class="spinner-border text-white" role="status"></div>
          Simpan
        </button>
      </div>
    </div>
  </form>
  <listBarang ref="listBarang" :data="dataBrg" @emitAddBarang="onAddBarang"></listBarang>
</template>

<script>
import { ref } from "vue";
import ListBarangComponent from "./ListBarang.vue";
export default {
  components: {
    listBarang: ListBarangComponent,
  },
  data() {
    // format date
    const date = ref(new Date());
    const format = (date) => {
      const day = date.getDate();
      const month =
        parseInt(date.getMonth() + 1) < 10
          ? `0${date.getMonth() + 1}`
          : date.getMonth() + 1;
      const year = date.getFullYear();

      return `${day}/${month}/${year}`;
    };
    // end format date
    let sortOrders = {};
    let columns = [
      {
        label: "Article No",
        name: "articleNo",
        type: "string",
        style: "cursor: pointer;",
      },
      {
        label: "Nama Barang",
        name: "barangname",
        type: "string",
        style: "cursor: pointer;",
      },
      //   {
      //     label: "Unit",
      //     name: "unit",
      //     type: "string",
      //     style: "cursor: pointer;",
      //   },
      {
        label: "Qty",
        name: "qty",
        type: "string",
        style: "cursor: pointer;",
      },
      {
        label: "Harga",
        name: "price",
        type: "number",
        style: "cursor: pointer;",
      },
      {
        label: "Actual Harga",
        name: "priceActual",
        type: "number",
        style: "cursor: pointer;",
      },
      {
        label: "Jumlah",
        name: "lastPrice",
        type: "number",
        style: "cursor: pointer;",
      },
    ];
    columns.forEach((column) => {
      sortOrders[column.name] = -1;
    });
    return {
      dataBrg: [],
      optSupplier: [],
      optAkun: [],
      tableLoading: false,
      columns: columns,
      sortKey: "articleNo",
      sortOrders: sortOrders,
      isAsc: 1,
      length: 10,
      search: "",
      tableShow: {
        showdata: true,
      },
      pagination: {
        currentPage: 1,
        total: "",
        nextPage: "",
        prevPage: "",
        from: "",
        to: "",
      },
      format,
      loading: false,
      disabled: false,
      form: new Form({
        tanggal: new Date(),
        notrx: "",
        desc: "",
        akun: null,
        total: 0,
        barangbuy: [],
      }),
    };
  },
  created() {
    this.getListBarang();
    this.getAkun();
  },
  methods: {
    saveSale() {
      this.loading = true;
      this.disabled = true;
      this.form
        .post(`${this.$baseUrl}api/penjualan`)
        .then((response) => {
          Toast.fire({
            icon: response.data.icon,
            title: response.data.message,
          });
          if (response.data.icon === "success") {
            this.$router.push({ name: "backend.penjualan" });
          }
        })
        .catch(() => {
          this.loading = false;
          this.disabled = false;
        });
    },
    editRow(index, item) {
      this.$refs.listBarang.handleEditClick(item);
      this.deleteRow(index, item);
      $("#modalBarang").modal("show");
    },
    deleteRow(index, item) {
      var idx = this.form.barangbuy.indexOf(item);
      if (idx > -1) {
        this.$refs.listBarang.restoreStock(item);
        this.form.barangbuy.splice(idx, 1);
      }
    },
    onAddBarang(value) {
      let dataBarang = this.form.barangbuy;
      let objIndex = dataBarang.findIndex((obj) => obj.articleNo == value.articleNo);
      if (objIndex === -1) {
        this.form.barangbuy.push({
          articleNo: value.articleNo,
          barangid: value.barangid,
          barangname: value.barangname,
          qty: parseInt(value.qty),
          price: value.price,
          priceActual: value.priceActual,
          grandTotal: parseInt(value.qty) * value.priceActual,
          unit: value.unit,
        });
      } else {
        this.form.barangbuy[objIndex].qty += value.qty;
        this.form.barangbuy[objIndex].price = value.price;
        this.form.barangbuy[objIndex].priceActual = value.priceActual;
      }
      this.$refs.listBarang.handleParentClick("ssss");
      $("#modalBarang").modal("hide");
    },
    getListBarang() {
      axios
        .get(`${this.$baseUrl}api/barang-jual`)
        .then((response) => {
          this.dataBrg = response.data;
        })
        .catch((error) => {
          console.log(`get Barang - ${error}`);
        });
    },
    getAkun() {
      axios
        .get(`${this.$baseUrl}api/akun`, { params: this.tableShow })
        .then((response) => {
          response.data.forEach((row) => {
            this.optAkun.push({
              code: row.id,
              label: `${row.kode_sub} | ${row.nama_akun}`,
            });
          });
        })
        .catch((error) => {
          console.log(`get Barang - ${error}`);
        });
    },
    showListBarang() {
      this.$refs.listBarang.handleParentClick("ssss");
      $("#modalBarang").modal("show");
    },
    paginate(array, length, pageNumber) {
      this.pagination.from = array.length ? (pageNumber - 1) * length + 1 : " ";
      this.pagination.to =
        pageNumber * length > array.length ? array.length : pageNumber * length;
      this.pagination.prevPage = pageNumber > 1 ? pageNumber : "";
      this.pagination.nextPage = array.length > this.pagination.to ? pageNumber + 1 : "";
      return array.slice((pageNumber - 1) * length, pageNumber * length);
    },
    resetPagination() {
      this.pagination.currentPage = 1;
      this.pagination.prevPage = "";
      this.pagination.nextPage = "";
    },
    sortBy(key) {
      this.resetPagination();
      this.sortKey = key;
      this.sortOrders[key] = this.sortOrders[key] * -1;
      this.isAsc = this.isAsc * -1;
    },
    getIndex(array, key, value) {
      return array.findIndex((i) => i[key] == value);
    },
  },
  computed: {
    filteredDatas() {
      let datas = this.form.barangbuy;
      if (this.search) {
        datas = datas.filter((row) => {
          return Object.keys(row).some((key) => {
            if (
              key.toLowerCase() === "subcategory_name" ||
              key.toLowerCase() === "code_subcategory"
            ) {
              return (
                String(row[key]).toLowerCase().indexOf(this.search.toLowerCase()) > -1
              );
            }
            if (key.toLowerCase() === "category") {
              return (
                String(row[key]["category_name"])
                  .toLowerCase()
                  .indexOf(this.search.toLowerCase()) > -1
              );
            }
          });
        });
      }
      let sortKey = this.sortKey;
      let order = this.isAsc;
      this.sortOrders[sortKey] = this.isAsc;
      if (sortKey) {
        datas = datas.slice().sort((a, b) => {
          let index = this.getIndex(this.columns, "name", sortKey);
          a = String(a[sortKey]).toLowerCase();
          b = String(b[sortKey]).toLowerCase();
          if (this.columns[index].type && this.columns[index].type === "date") {
            return (
              (a === b ? 0 : new Date(a).getTime() > new Date(b).getTime() ? 1 : -1) *
              order
            );
          } else if (this.columns[index].type && this.columns[index].type === "number") {
            return (+a === +b ? 0 : +a > +b ? 1 : -1) * order;
          } else {
            return (a === b ? 0 : a > b ? 1 : -1) * order;
          }
        });
      }
      return datas;
    },
    paginatedDatas() {
      return this.paginate(this.filteredDatas, this.length, this.pagination.currentPage);
    },
    countSaldo() {
      let totalSaldo = 0;
      this.paginatedDatas.forEach((row) => {
        totalSaldo += parseInt(row.qty) * parseInt(row.priceActual);
      });
      this.form.total = totalSaldo;
      return totalSaldo;
    },
  },
};
</script>
