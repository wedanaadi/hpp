<template>
  <div class="card">
    <div class="card-header">
      <h4 class="card-title">Data Supplier</h4>
      <div class="card-tools">
        <button type="button" @click="modalCreate()" class="btn btn-success">
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
              <tr v-for="(r, i) in filteredDatas" :key="i">
                <td>{{ i + 1 }}</td>
                <td>{{ r.kode_pemasok }}</td>
                <td>{{ r.nama }}</td>
                <td>{{ r.alamat }}</td>
                <td>{{ r.telp }}</td>
                <td class="text-center">
                  <button class="btn btn-warning" @click="modalUpdate(r)">
                    <i class="bi bi-pencil-square"></i> Edit
                  </button>
                  &nbsp;
                  <button class="btn btn-danger" @click="hapusData(r.id)">
                    <i class="bi bi-trash"></i> Hapus
                  </button>
                </td>
              </tr>
              <tr v-show="tableLoading">
                <td colspan="6" class="text-center">Loading...</td>
              </tr>
              <tr v-show="paginatedDatas.length === 0 && !tableLoading">
                <td colspan="6" class="text-center">Tidak ada data...</td>
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
            <div class="form-group">
              <label for="kode">Kode Pemasok</label>
              <input
                type="text"
                v-model="form.kode_pemasok"
                class="form-control"
                placeholder="Kode Pemasok"
                :class="{ 'is-invalid': form.errors.has('kode_pemasok') }"
              />
              <has-error :form="form" field="kode_pemasok"></has-error>
            </div>
            <div class="form-group">
              <label for="nama">Nama Supplier</label>
              <input
                type="text"
                v-model="form.nama"
                class="form-control"
                placeholder="Nama Supplier"
                :class="{ 'is-invalid': form.errors.has('nama') }"
              />
              <has-error :form="form" field="nama"></has-error>
            </div>
            <div class="form-group">
              <label for="telepon">Telepon</label>
              <input
                type="text"
                v-model="form.telepon"
                class="form-control"
                placeholder="telepon Supplier"
                :class="{ 'is-invalid': form.errors.has('telepon') }"
              />
              <has-error :form="form" field="telepon"></has-error>
            </div>
            <div class="form-group">
              <label for="alamat">Alamat</label>
              <textarea
                v-model="form.alamat"
                class="form-control"
                placeholder="Alamat"
                cols="10"
                rows="3"
                :class="{ 'is-invalid': form.errors.has('alamat') }"
              ></textarea>
              <has-error :form="form" field="alamat"></has-error>
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
    let sortOrders = {};
    let columns = [
      {
        label: "Kode Pemasok",
        name: "kode_pemasok",
        type: "number",
        style: "width: 12%; cursor: pointer;",
      },
      {
        label: "Nama Supplier",
        name: "nama",
        type: "string",
        style: "cursor: pointer;",
      },
      {
        label: "Alamat",
        name: "alamat",
        type: "string",
        style: "cursor: pointer;",
      },
      {
        label: "Telepon",
        name: "telepon",
        type: "string",
        style: "cursor: pointer;",
      },
    ];
    columns.forEach((column) => {
      sortOrders[column.name] = -1;
    });
    return {
      tableLoading: true,
      loading: false,
      disabled: false,
      isSave: true,
      datas: [],
      form: new Form({
        id: "",
        kode_pemasok: "",
        nama: "",
        alamat: "",
        telepon: "",
      }),
      columns: columns,
      sortKey: "kode_pemasok",
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
    this.getData();
  },
  methods: {
    getData() {
      axios
        .get(`${this.$baseUrl}api/supplier`, { params: this.tableShow })
        .then((response) => {
          this.tableLoading = false;
          this.datas = response.data;
          this.pagination.total = this.datas.length;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    modalCreate() {
      this.isSave = true;
      this.form.reset();
      this.form.clear();
      $("#modal").modal("show");
    },
    simpanData() {
      this.loading = true;
      this.disabled = true;
      this.form
        .post(`${this.$baseUrl}api/supplier`)
        .then((respon) => {
          this.getData();
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
    modalUpdate(item) {
      this.isSave = false;
      this.form.reset();
      this.form.clear();
      const dataEdit = {
        id: item.id,
        kode_pemasok: item.kode_pemasok,
        nama: item.nama,
        alamat: item.alamat,
        telepon: item.telp,
      };
      this.form.fill(dataEdit);
      $("#modal").modal("show");
    },
    ubahData() {
      this.loading = true;
      this.disabled = true;
      this.form
        .put(`${this.$baseUrl}api/supplier/${this.form.id}`)
        .then((respon) => {
          this.getData();
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
    hapusData(id) {
      Swal.fire({
        title: "Hapus data?",
        text: "Klik batal untuk membatalkan penghapusan",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Hapus",
        cancelButtonText: "Batal",
        cancelButtonColor: "#d33",
      }).then((result) => {
        if (result.isConfirmed) {
          this.form
            .delete(`${this.$baseUrl}api/supplier/${id}`)
            .then((respon) => {
              this.getData();
              Toast.fire({
                icon: "success",
                title: respon.data.message,
              });
            })
            .catch((error) => {
              console.log(error);
              Toast.fire({
                icon: "error",
                title: respon.data.message,
              });
            });
        }
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
            return String(row[key]).toLowerCase().indexOf(this.search.toLowerCase()) > -1;
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

<style></style>
