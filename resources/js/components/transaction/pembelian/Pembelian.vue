<template>
  <div class="card">
    <div class="card-header">
      <h4 class="card-title">Data Pembelian</h4>
      <div class="card-tools">
        <button @click="formTambah()" type="button" class="btn btn-success">
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
                <td>{{ r.id }}</td>
                <td>{{ formatDate(r.tanggal) }}</td>
                <td>{{ r.supplier.nama }}</td>
                <td class="text-end">
                  {{ vueNumberFormat(r.jumlah_trx, { precision: 2 }) }}
                </td>
                <td class="text-center">
                  <button class="btn btn-warning" @click="formUpdate(r)">
                    <i class="bi bi-pencil-square"></i> Edit
                  </button>
                  &nbsp;
                  <button class="btn btn-success" @click="detailModal(r.detail)">
                    <i class="bi bi-eye-fill"></i> Detail
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
  <detail :data="detaildata"></detail>
</template>

<script>
import detail from "./Detail.vue";
export default {
  components: {
    detail,
  },
  data() {
    let sortOrders = {};
    let columns = [
      {
        label: "No Transaksi",
        name: "id",
        type: "string",
        style: "cursor: pointer;",
      },
      {
        label: "Tanggal",
        name: "tanggal",
        type: "string",
        style: "cursor: pointer;",
      },
      {
        label: "Supplier",
        name: "supplier_id",
        type: "string",
        style: "cursor: pointer;",
      },
      {
        label: "Jumlah",
        name: "jumlah_trx",
        type: "number",
        style: "cursor: pointer;",
      },
    ];
    columns.forEach((column) => {
      sortOrders[column.name] = -1;
    });
    return {
      detaildata: [],
      tableLoading: true,
      datas: [],
      columns: columns,
      sortKey: "id",
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
    detailModal(item) {
      this.detaildata = item;
      $("#modalDetail").modal("show");
    },
    formTambah() {
      this.$router.push({ name: "pembelian.add" });
    },
    formUpdate(item) {
      this.$router.push({
        name: "pembelian.edit",
        params: { id: item.id },
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
    getData() {
      axios
        .get(`${this.$baseUrl}api/pembelian`, { params: this.tableShow })
        .then((response) => {
          this.tableLoading = false;
          this.datas = response.data;
          this.pagination.total = this.datas.length;
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
            if (key.toLowerCase() === "id" || key.toLowerCase() === "jumlah_trx") {
              return (
                String(row[key]).toLowerCase().indexOf(this.search.toLowerCase()) > -1
              );
            }
            if (key.toLowerCase() === "tanggal") {
              return (
                this.formatDate(String(row[key]).toLowerCase()).indexOf(
                  this.search.toLowerCase()
                ) > -1
              );
            }
            if (key.toLowerCase() === "supplier") {
              return (
                String(row[key]["nama"])
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
  },
};
</script>
