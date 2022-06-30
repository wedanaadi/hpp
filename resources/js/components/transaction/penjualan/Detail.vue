<template>
  <!-- modal -->
  <div
    class="modal"
    id="modalDetail"
    tabindex="-1"
    data-bs-backdrop="static"
    data-bs-keyboard="false"
  >
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Detail Penjualan</h5>
          <button
            @click="closeModal()"
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <div class="datatable-style">
            <!-- search and filter -->
            <div class="table-style">
              <div class="row">
                <div
                  class="col-12 d-flex flex-column flex-md-row justify-content-md-between"
                >
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
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(r, i) in paginatedDatas" :key="i">
                    <td class="text-center">{{ i + 1 }}</td>
                    <td>{{ r.articleNo }}</td>
                    <td>{{ r.barangname }}</td>
                    <!-- <td>{{ r.unit }}</td> -->
                    <td class="text-end">{{ r.qty }}</td>
                    <td class="text-end">
                      {{ vueNumberFormat(r.price, { precision: 2 }) }}
                    </td>
                    <td class="text-end">
                      {{ vueNumberFormat(r.priceActual, { precision: 2 }) }}
                    </td>
                    <td class="text-end">
                      {{ vueNumberFormat(r.qty * r.priceActual, { precision: 2 }) }}
                    </td>
                  </tr>
                  <tr v-show="tableLoading">
                    <td colspan="8" class="text-center">Loading...</td>
                  </tr>
                  <tr v-show="paginatedDatas.length === 0 && !tableLoading">
                    <td colspan="8" class="text-center">Tidak ada data...</td>
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
        </div>
      </div>
    </div>
  </div>
  <!-- endmodal -->
</template>

<script>
export default {
  props: {
    data: {
      Type: String,
      default: null,
    },
  },
  data() {
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
        label: "P-Price",
        name: "price",
        type: "number",
        style: "cursor: pointer;",
      },
      {
        label: "Actual Price",
        name: "priceActual",
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
      datas: [],
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
    };
  },
  methods: {
    closeModal() {
      this.length = 10;
      this.search = "";
      this.pagination = {
        currentPage: 1,
        total: "",
        nextPage: "",
        prevPage: "",
        from: "",
        to: "",
      };
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
      this.datas = [];
      this.data.forEach((r) => {
        this.datas.push({
          articleNo: r.barang.kode,
          barangid: r.barang_id,
          barangname: r.barang.nama_barang,
          qty: parseInt(r.qty),
          price: r.harga,
          priceActual: r.actual_harga,
          jumlah: parseInt(r.qty) * parseInt(r.actual_harga),
          unit: r.unit,
        });
      });
      let datas = this.datas;
      if (this.search) {
        datas = datas.filter((row) => {
          return Object.keys(row).some((key) => {
            if (
              key.toLowerCase() === "articleno" ||
              key.toLowerCase() === "barangname" ||
              //   key.toLowerCase() === "unit" ||
              key.toLowerCase() === "qty" ||
              key.toLowerCase() === "price" ||
              key.toLowerCase() === "priceActual" ||
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
  },
};
</script>

<style></style>
