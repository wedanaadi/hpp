<template>
  <div class="card">
    <div class="card-header">
      <h4 class="card-title">Jurnal Umum</h4>
      <div class="card-tools">
        <button @click="modalCreate()" type="button" class="btn btn-success">
          <i class="bi bi-plus-square"></i> Tambah
        </button>
      </div>
    </div>
    <div class="card-body">
      <div class="datatable-style">
        <!-- search and filter -->
        <div class="table-style">
          <div class="row">
            <div class="col-12 d-flex flex-column flex-md-row justify-content-md-between">
              <div class="col-12 col-sm-12 col-md-4 mb-2 mb-md-0">
                <input
                  class="form-control"
                  type="text"
                  v-model="search"
                  placeholder="Search..."
                  @input="resetPagination()"
                />
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
                <th style="width: 5%">No</th>
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
                <th style="width: 15%">Aksi</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(r, i) in paginatedDatas" :key="i">
                <td class="text-ce">{{ i + 1 }}</td>
                <td>{{ formatDate(r.date) }}</td>
                <td>{{ r.akuns.kode_sub }}</td>
                <td class="text-end">{{ vueNumberFormat(r.debet, { precision: 2 }) }}</td>
                <td class="text-end">
                  {{ vueNumberFormat(r.kredit, { precision: 2 }) }}
                </td>
                <td>{{ r.remark }}</td>
                <td class="text-center">
                  <button
                    @click="modalEdit(r)"
                    v-if="r.link_id === '0'"
                    class="btn btn-warning"
                  >
                    <i class="bi bi-pencil-square"></i> Edit
                  </button>
                  <span v-else class="badge bg-primary">From Transaction</span>
                </td>
              </tr>
              <tr v-show="tableLoading">
                <td colspan="7" class="text-center">Loading...</td>
              </tr>
              <tr v-show="paginatedDatas.length === 0 && !tableLoading">
                <td colspan="7" class="text-center">Tidak ada data...</td>
              </tr>
            </tbody>
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
            <a class="btn btn-sm btn-success pagination-previous" v-else disabled>Prev</a>
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
    </div>
  </div>
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
          <h5 v-if="isSave" class="modal-title">Tambah Data</h5>
          <h5 v-else class="modal-title">Ubah Data</h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <form @submit.prevent="isSave ? simpanData() : ubahData()">
          <div class="modal-body">
            <div class="row">
              <div class="col-12 col-md-6">
                <div class="form-group">
                  <label for="tanggal">Date</label>
                  <v-datepicker
                    :format="format"
                    v-model="form.date"
                    autoApply
                    monthNameFormat="long"
                    :enableTimePicker="false"
                    :class="{ 'is-invalid': form.errors.has('date') }"
                  />
                  <div
                    class="text-danger"
                    v-if="form.errors.has('date')"
                    v-html="form.errors.get('date')"
                  />
                </div>
              </div>
              <div class="col-12 col-md-6">
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
            </div>
            <div class="row">
              <div class="col-12 col-md-6">
                <div class="form-group">
                  <label for="">Debet</label>
                  <VueNumberFormat
                    v-model:value="form.debet"
                    class="form-control text-end"
                    placeholder="Debet...."
                    :class="{ 'is-invalid': form.errors.has('debet') }"
                  ></VueNumberFormat>
                  <div
                    class="text-danger"
                    v-if="form.errors.has('debet')"
                    v-html="form.errors.get('debet')"
                  />
                </div>
              </div>
              <div class="col-12 col-md-6">
                <div class="form-group">
                  <label for="">Credit</label>
                  <VueNumberFormat
                    v-model:value="form.kredit"
                    class="form-control text-end"
                    placeholder="Credit...."
                    :class="{ 'is-invalid': form.errors.has('kredit') }"
                  ></VueNumberFormat>
                  <div
                    class="text-danger"
                    v-if="form.errors.has('kredit')"
                    v-html="form.errors.get('kredit')"
                  />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-12">
                <div class="form-group">
                  <label for="">Remark</label>
                  <textarea
                    v-model="form.remark"
                    class="form-control"
                    placeholder="Remark"
                    rows="2"
                    :class="{ 'is-invalid': form.errors.has('remark') }"
                  ></textarea>
                  <div
                    class="text-danger"
                    v-if="form.errors.has('remark')"
                    v-html="form.errors.get('remark')"
                  />
                </div>
              </div>
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
import { ref } from "vue";
export default {
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
        label: "Date",
        name: "date",
        type: "date",
        style: "cursor: pointer;",
      },
      {
        label: "Account No.",
        name: "kode_sub",
        type: "number",
        style: "cursor: pointer;",
      },
      {
        label: "Debit",
        name: "debet",
        type: "number",
        style: "cursor: pointer;",
      },
      {
        label: "Credit",
        name: "kredit",
        type: "number",
        style: "cursor: pointer;",
      },
      {
        label: "Remark",
        name: "remark",
        type: "number",
        style: "cursor: pointer;",
      },
    ];
    columns.forEach((column) => {
      sortOrders[column.name] = -1;
    });
    return {
      format,
      tableLoading: true,
      loading: false,
      disabled: false,
      isSave: true,
      datas: [],
      optAkun: [],
      form: new Form({
        id: "",
        akun: null,
        debet: 0,
        kredit: 0,
        remark: "",
        date: new Date(),
      }),
      columns: columns,
      sortKey: "date",
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
    };
  },
  created() {
    this.getJurnal();
    this.getAkun();
  },
  methods: {
    modalCreate() {
      this.isSave = true;
      this.form.reset();
      this.form.clear();
      this.form.date = new Date();
      $("#modal").modal("show");
    },
    simpanData() {
      this.loading = true;
      this.disabled = true;
      this.form
        .post(`${this.$baseUrl}api/jurnal`)
        .then((response) => {
          this.getJurnal();
          $("#modal").modal("hide");
          Toast.fire({
            icon: response.data.icon,
            title: response.data.message,
          });
          this.loading = false;
          this.disabled = false;
        })
        .catch(() => {
          this.loading = false;
          this.disabled = false;
        });
    },
    modalEdit(item) {
      this.isSave = false;
      this.form.reset();
      this.form.clear();
      const dataEdit = {
        id: item.id,
        akun: item.akun,
        debet: item.debet,
        kredit: item.kredit,
        remark: item.remark,
        date: item.date,
      };
      this.form.fill(dataEdit);
      $("#modal").modal("show");
    },
    ubahData() {
      this.loading = true;
      this.disabled = true;
      this.form
        .put(`${this.$baseUrl}api/jurnal/${this.form.id}`)
        .then((response) => {
          this.getJurnal();
          $("#modal").modal("hide");
          Toast.fire({
            icon: response.data.icon,
            title: response.data.message,
          });
          this.loading = false;
          this.disabled = false;
        })
        .catch(() => {
          this.loading = false;
          this.disabled = false;
        });
    },
    formatDate(date) {
      let tgl = new Date(date);
      const day = tgl.getDate();
      const month =
        parseInt(tgl.getMonth() + 1) < 10 ? `0${tgl.getMonth() + 1}` : tgl.getMonth() + 1;
      const year = tgl.getFullYear();
      return `${day}/${month}/${year}`;
    },
    getJurnal() {
      axios
        .get(`${this.$baseUrl}api/jurnal`, { params: this.tableShow })
        .then((response) => {
          this.tableLoading = false;
          this.datas = response.data;
          this.pagination.total = this.datas.length;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getAkun() {
      axios
        .get(`${this.$baseUrl}api/akun`, { params: this.tableShow })
        .then((response) => {
          response.data.forEach((a) => {
            this.optAkun.push({ code: a.id, label: `${a.kode_sub} | ${a.nama_akun}` });
          });
        })
        .catch((error) => {
          console.log(error);
        });
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
      let datas = this.datas;
      if (this.search) {
        datas = datas.filter((row) => {
          return Object.keys(row).some((key) => {
            if (
              key.toLowerCase() === "akun" ||
              key.toLowerCase() === "debet" ||
              key.toLowerCase() === "kredit" ||
              key.toLowerCase() === "remark"
            ) {
              return (
                String(row[key]).toLowerCase().indexOf(this.search.toLowerCase()) > -1
              );
            }

            if (key.toLowerCase() === "akuns") {
              return (
                String(row[key]["kode_sub"])
                  .toLowerCase()
                  .indexOf(this.search.toLowerCase()) > -1
              );
            }
            if (key.toLowerCase() === "date") {
              return (
                this.formatDate(String(row[key]).toLowerCase()).indexOf(
                  this.search.toLowerCase()
                ) > -1
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
  },
};
</script>
