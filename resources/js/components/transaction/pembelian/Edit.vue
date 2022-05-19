<template>
  <form @submit.prevent="savePurchase()" autocomplete="off">
    <div class="card">
      <div class="card-header">
        <h4 class="card-title">Edit Pembelian</h4>
        <div class="card-tools">
          <router-link :to="{ name: 'backend.pembelian' }" class="btn btn-secondary">
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
          <div class="col-12 col-md-4">
            <div class="form-group">
              <label for="">Supplier</label>
              <v-select
                v-model="form.supplier"
                :reduce="(option) => option.code"
                :options="optSupplier"
                placeholder="Supplier..."
                :class="{ 'select-invalid': form.errors.has('supplier') }"
              ></v-select>
              <div
                class="text-danger"
                v-if="form.errors.has('supplier')"
                v-html="form.errors.get('supplier')"
              />
            </div>
          </div>
          <div class="col-12 col-md-4">
            <div class="form-group">
              <label for="">Akun</label>
              <v-select
                v-model="form.akun"
                :options="optAkun"
                :reduce="(option) => option.code"
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
                Tambah Barang
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
          <!-- search and filter -->
          <div class="table-style">
            <div class="row">
              <div
                class="col-12 d-flex flex-column flex-md-row justify-content-md-between"
              >
                <div class="col-12 col-sm-12 col-md-4 mb-2 mb-md-0">
                  <!-- <input
                    class="form-control"
                    type="text"
                    v-model="search"
                    placeholder="Search..."
                    @input="resetPagination()"
                  /> -->
                </div>
                <div class="col-3 col-sm-3 col-md-2">
                  <select
                    class="form-select float-md-end"
                    v-model="length"
                    @change="resetPagination()"
                    style="width: 80px"
                  >
                    <option value="10">10</option>
                    <option value="25">25</option>
                    <option value="50">50</option>
                    <option value="100">100</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <!-- end search and filter -->

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
                <tr v-for="(r, i) in paginatedDatas" :key="i">
                  <td class="text-center">{{ i + 1 }}</td>
                  <td>{{ r.articleNo }}</td>
                  <td>{{ r.barangname }}</td>
                  <td>{{ r.unit }}</td>
                  <td class="text-end">{{ r.qty }}</td>
                  <td class="text-end">
                    {{ vueNumberFormat(r.price, { precision: 2 }) }}
                  </td>
                  <td class="text-end">
                    {{ vueNumberFormat(r.qty * r.price, { precision: 2 }) }}
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
                  <td colspan="8" class="text-center">Loading...</td>
                </tr>
                <tr v-show="paginatedDatas.length === 0 && !tableLoading">
                  <td colspan="8" class="text-center">Tidak ada data...</td>
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

          <!-- pagination -->
          <div>
            <nav class="pagination" v-if="!tableShow.showdata">
              <span class="page-stats">
                {{ pagination.from }} - {{ pagination.to }} of
                {{ pagination.total }}
              </span>
              <a
                v-if="pagination.prevPageUrl"
                class="btn btn-sm btn-primary pagination-previous"
                @click="--pagination.currentPage"
                >Prev</a
              >
              <a class="btn btn-sm btn-success pagination-previous" v-else disabled
                >Prev</a
              >
              <a
                v-if="pagination.nextPageUrl"
                class="btn btn-sm pagination-next"
                @click="++pagination.currentPage"
                >Next</a
              >
              <a class="btn btn-sm btn-primary pagination-next" v-else disabled>Next</a>
            </nav>
            <nav class="pagination" v-else>
              <span class="page-stats">
                {{ pagination.from }} - {{ pagination.to }} of
                {{ filteredDatas.length }}
              </span>
              <a
                v-if="pagination.prevPage"
                class="btn btn-sm btn-primary pagination-previous"
                @click="--pagination.currentPage"
                >Prev</a
              >
              <button
                class="btn btn-sm pagination-previous btn-secondary"
                v-else
                disabled
                style="margin-right: 5px"
              >
                Prev
              </button>
              <a
                v-if="pagination.nextPage"
                class="btn btn-sm btn-primary pagination-next"
                @click="++pagination.currentPage"
                >Next</a
              >
              <button class="btn btn-sm pagination-next btn-secondary" v-else disabled>
                Next
              </button>
            </nav>
          </div>
          <!-- end pagination -->
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
  props: {
    data: {
      Type: String,
      default: null,
    },
  },
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
      {
        label: "Unit",
        name: "unit",
        type: "string",
        style: "cursor: pointer;",
      },
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
        label: "Jumlah",
        name: "jumlah",
        type: "number",
        style: "cursor: pointer;",
      },
    ];
    columns.forEach((column) => {
      sortOrders[column.name] = -1;
    });
    return {
      tableLoading: false,
      dataBrg: [],
      optSupplier: [],
      optAkun: [],
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
        supplier: "",
        akun: null,
        total: 0,
        barangbuy: [],
      }),
    };
  },
  created() {
    this.getEdit();
    this.getListBarang();
    this.getSupplier();
    this.getAkun();
  },
  methods: {
    getEdit() {
      axios
        .get(`${this.$baseUrl}api/pembelian/${this.$route.params.id}`)
        .then((response) => {
          const datafind = response.data;
          this.form.notrx = datafind.id;
          this.form.tanggal = datafind.tanggal;
          this.form.desc = datafind.desc;
          this.form.total = datafind.jumlah_trx;

          this.form.supplier = datafind.supplier_id;
          this.form.akun = datafind.akun_id;

          datafind.detail.forEach((value) => {
            this.form.barangbuy.push({
              articleNo: value.barang.kode,
              barangid: value.barang_id,
              barangname: value.barang.nama_barang,
              qty: parseInt(value.qty),
              price: value.harga,
              lastPrice: value.harga_terakhir,
              unit: value.unit,
            });
          });
        })
        .catch();
    },
    savePurchase() {
      this.loading = true;
      this.disabled = true;
      this.form
        .put(`${this.$baseUrl}api/pembelian/${this.form.notrx}`)
        .then((response) => {
          Toast.fire({
            icon: response.data.icon,
            title: response.data.message,
          });
          if (response.data.icon === "success") {
            this.$router.push({ name: "backend.pembelian" });
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
      console.log(idx, index);
      if (idx > -1) {
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
          lastPrice: value.lastPrice,
          unit: value.unit,
        });
      } else {
        this.form.barangbuy[objIndex].qty += value.qty;
        this.form.barangbuy[objIndex].price = value.price;
      }
      this.$refs.listBarang.handleParentClick("ssss");
      $("#modalBarang").modal("hide");
    },
    getListBarang() {
      axios
        .get(`${this.$baseUrl}api/barang-baku`)
        .then((response) => {
          this.dataBrg = response.data;
        })
        .catch((error) => {
          console.log(`get Barang - ${error}`);
        });
    },
    getSupplier() {
      axios
        .get(`${this.$baseUrl}api/supplier`, { params: this.tableShow })
        .then((response) => {
          response.data.forEach((row) => {
            this.optSupplier.push({ code: row.id, label: row.nama });
          });
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
              key.toLowerCase() === "articleNo" ||
              key.toLowerCase() === "barangname" ||
              key.toLowerCase() === "unit" ||
              key.toLowerCase() === "qty" ||
              key.toLowerCase() === "price" ||
              key.toLowerCase() === "jumlah"
            ) {
              return (
                String(row[key]).toLowerCase().indexOf(this.search.toLowerCase()) > -1
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
        totalSaldo += parseInt(row.qty) * parseInt(row.price);
      });
      this.form.total = totalSaldo;
      return totalSaldo;
    },
  },
};
</script>
