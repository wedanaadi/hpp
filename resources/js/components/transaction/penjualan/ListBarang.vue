<template>
  <!-- modal -->
  <div
    class="modal"
    id="modalBarang"
    tabindex="-1"
    data-bs-backdrop="static"
    data-bs-keyboard="false"
  >
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">List Barang</h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <!-- data barang beli -->
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
                    <th style="width: 150px">Aksi</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(r, i) in filteredDatas" :key="i">
                    <td class="text-center">{{ i + 1 }}</td>
                    <td>{{ r.kode }}</td>
                    <td>{{ r.nama_barang }}</td>
                    <!-- <td>Menu</td>
                    <td>Sat</td> -->
                    <td class="text-center">{{ r.stock }}</td>
                    <td class="text-center">
                      {{ vueNumberFormat(r.harga_jual, { precision: 2 }) }}
                    </td>
                    <td class="text-center">
                      <button
                        @click="addItem(r)"
                        v-if="r.stock > 0"
                        type="button"
                        class="btn btn-primary"
                      >
                        <i class="bi bi-check"></i>
                      </button>
                      <span v-else class="badge bg-danger">Stoct Kosong</span>
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
          <!-- end data barang beli -->

          <hr />
          <div class="row">
            <div class="col-12 col-md-4">
              <div class="form-group">
                <label for="">Barang</label>
                <input
                  v-model="barangAdd.barangname"
                  type="text"
                  class="form-control"
                  readonly
                />
              </div>
            </div>
            <div class="col-12 col-md-2">
              <div class="form-group">
                <label for="">Qty</label>
                <input
                  v-model="barangAdd.qty"
                  type="number"
                  class="form-control"
                  placeholder="Qty...."
                  :readonly="qtyReadonly"
                />
              </div>
            </div>
            <div class="col-12 col-md-3">
              <div class="form-group">
                <label for="">P-Price</label>
                <VueNumberFormat
                  v-model:value="barangAdd.price"
                  class="form-control text-end"
                  readonly
                ></VueNumberFormat>
              </div>
            </div>
            <div class="col-12 col-md-3">
              <div class="form-group">
                <label for="">Actual Price</label>
                <VueNumberFormat
                  v-model:value="barangAdd.priceActual"
                  class="form-control text-end"
                ></VueNumberFormat>
              </div>
            </div>
            <div class="col-12 col-md-3">
              <div class="form-group">
                <label for="">Total</label>
                <VueNumberFormat
                  v-model:value="countGrand"
                  class="form-control text-end"
                  readonly
                ></VueNumberFormat>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button
            @click="addBarang()"
            type="button"
            class="btn btn-primary"
            :disabled="disabled"
          >
            <div v-show="loading" class="spinner-border text-white" role="status"></div>
            Tambah Menu
          </button>
        </div>
      </div>
    </div>
  </div>
  <!-- endmodal -->
</template>
<script>
export default {
  props: ["data"],
  data() {
    let sortOrders = {};
    let columns = [
      {
        label: "Article",
        name: "kode",
        type: "number",
        style: "cursor: pointer;",
      },
      {
        label: "Nama Barang",
        name: "nama_barang",
        type: "string",
        style: "cursor: pointer;",
      },
      //   {
      //     label: "Main - Sub Group",
      //     name: "mainsub",
      //     type: "string",
      //     style: "cursor: pointer;",
      //   },
      //   {
      //     label: "Unit",
      //     name: "unit",
      //     type: "string",
      //     style: "cursor: pointer;",
      //   },
      {
        label: "Stock",
        name: "stock",
        type: "string",
        style: "cursor: pointer;",
      },
      {
        label: "Harga",
        name: "harga_jual",
        type: "number",
        style: "cursor: pointer;",
      },
    ];
    columns.forEach((column) => {
      sortOrders[column.name] = -1;
    });
    return {
      qtyReadonly: true,
      tableLoading: false,
      columns: columns,
      sortKey: "kode",
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
      loading: false,
      disabled: false,
      barangAdd: new Form({
        barangid: null,
        barangname: null,
        unit: null,
        qty: 0,
        price: 0,
        priceActual: 0,
        stock: 0,
        grandTotal: 0,
        articleNo: null,
      }),
      tempStock: [],
    };
  },
  methods: {
    handleParentClick(e) {
      this.barangAdd.clear();
      this.barangAdd.reset();
      this.qtyReadonly = true;
    },
    handleEditClick(item) {
      this.qtyReadonly = false;
      this.barangAdd.fill(item);
    },
    addItem(item) {
      this.qtyReadonly = false;
      this.barangAdd.barangid = item.id;
      this.barangAdd.barangname = item.nama_barang;
      this.barangAdd.price = item.harga_jual;
      this.barangAdd.priceActual = item.harga_jual;
      this.barangAdd.stock = item.stock;
      this.barangAdd.unit = "-";
      this.barangAdd.articleNo = item.kode;
    },
    addBarang() {
      if (!this.barangAdd.barangid) {
        Toast.fire({
          icon: "warning",
          title: "Pilih Barang!",
        });
      } else if (this.barangAdd.qty === 0) {
        Toast.fire({
          icon: "warning",
          title: "Qty tidak valid!",
        });
      } else {
        let dataTemp = this.data;
        let objIndex = dataTemp.findIndex((obj) => obj.kode == this.barangAdd.articleNo);
        dataTemp[objIndex].stock -= this.barangAdd.qty;
        this.$emit("emitAddBarang", this.barangAdd);
      }
    },
    restoreStock(item) {
      let dataTemp = this.data;
      let objIndex = dataTemp.findIndex((obj) => obj.kode == item.articleNo);
      dataTemp[objIndex].stock += item.qty;
    },
    selected() {
      const id = this.barangAdd.barangid;
      let dataBarang = this.data;
      dataBarang = dataBarang.filter((row) => {
        return Object.keys(row).some((key) => {
          return String(row[key]).toLowerCase().indexOf(id) > -1;
        });
      });
      this.barangAdd.price = dataBarang[0].harga_beli;
      this.barangAdd.lastPrice = dataBarang[0].harga_beli;
      this.barangAdd.unit = dataBarang[0].unit.nama_satuan;
      this.barangAdd.articleNo = dataBarang[0].kode;
      this.barangAdd.barangname = dataBarang[0].nama_barang;
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
      let datas = this.data;
      if (this.search) {
        datas = datas.filter((row) => {
          return Object.keys(row).some((key) => {
            if (
              key.toLowerCase() === "kode" ||
              key.toLowerCase() === "nama_barang" ||
              key.toLowerCase() === "stock" ||
              key.toLowerCase() === "harga"
            ) {
              return (
                String(row[key]).toLowerCase().indexOf(this.search.toLowerCase()) > -1
              );
            }
            if (key.toLowerCase() === "unit") {
              return (
                String(row[key]["nama_satuan"])
                  .toLowerCase()
                  .indexOf(this.search.toLowerCase()) > -1
              );
            }
            if (key.toLowerCase() === "subcategory") {
              const text = `${String(
                row[key]["category"]["category_name"]
              ).toLowerCase()} - ${String(row[key]["subcategory_name"]).toLowerCase()}`;
              console.log(text);
              return text.indexOf(this.search.toLowerCase()) > -1;
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
    countGrand() {
      let price = parseInt(this.barangAdd.priceActual);
      let qty = parseInt(this.barangAdd.qty);
      if (qty > this.barangAdd.stock) {
        Toast.fire({
          icon: "warning",
          title: "Stoct tidak cukup!",
        });
        this.barangAdd.qty = this.barangAdd.stock;
        return "";
      } else {
        this.barangAdd.grandTotal = price * qty;
        return price * qty;
      }
    },
    selectBrg() {
      let opt = [];
      this.data.forEach((b) => {
        opt.push({ code: b.id, label: b.nama_barang });
      });
      return opt;
    },
  },
};
</script>
