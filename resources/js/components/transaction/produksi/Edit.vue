<template>
  <form @submit.prevent="saveProduksi()" autocomplete="off">
    <div class="card">
      <div class="card-header">
        <h4 class="card-title">Ubah Produksi</h4>
        <div class="card-tools">
          <router-link :to="{ name: 'backend.produksi' }" class="btn btn-secondary">
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
              <label for="">Menu</label>
              <v-select
                @option:selected="selectedMenu"
                v-model="form.menu"
                :reduce="(option) => option.code"
                :options="optMenu"
                placeholder="Menu..."
                :class="{ 'select-invalid': form.errors.has('menu') }"
              ></v-select>
              <div
                class="text-danger"
                v-if="form.errors.has('menu')"
                v-html="form.errors.get('menu')"
              />
            </div>
          </div>
          <div class="col-12 col-md-8">
            <div class="form-group">
              <label for="desc">Key Ingredient</label>
              <input
                v-model="form.key"
                id="desc"
                type="text"
                class="form-control"
                placeholder="Description/Note"
                :class="{ 'is-invalid': form.errors.has('key') }"
              />
              <div
                class="text-danger"
                v-if="form.errors.has('key')"
                v-html="form.errors.get('key')"
              />
            </div>
          </div>
          <div class="col-12 col-md-4">
            <div class="form-group">
              <label for="desc">Stock Produksi</label>
              <input
                v-model="form.stockProduksi"
                id="desc"
                type="text"
                class="form-control text-end"
                placeholder="Stock Produksi Menu"
                :class="{ 'is-invalid': form.errors.has('stockProduksi') }"
              />
              <div
                class="text-danger"
                v-if="form.errors.has('stockProduksi')"
                v-html="form.errors.get('stockProduksi')"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <div class="form-group">
              <label for="">Preparation</label>
              <textarea
                v-model="form.preparation"
                class="form-control"
                rows="3"
                :class="{ 'is-invalid': form.errors.has('preparation') }"
              ></textarea>
              <div
                class="text-danger"
                v-if="form.errors.has('preparation')"
                v-html="form.errors.get('preparation')"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-3 mt-4">
            <div class="form-group mb-0">
              <button
                :disabled="bahanDisabled"
                type="button"
                class="btn btn-info"
                @click="showListIngredient()"
              >
                Add Ingredient
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
                  <td class="text-end">{{ r.qty }}</td>
                  <td>{{ r.unit }}</td>
                  <td class="text-end">
                    {{ vueNumberFormat(r.cost, { precision: 2 }) }}
                  </td>
                  <td class="text-end">
                    {{ vueNumberFormat(r.qty * r.cost, { precision: 2 }) }}
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
                  <th class="text-end fw-bold" colspan="6">Total Ingredient Cost</th>
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
        <hr />
        <div class="row">
          <div class="col-12 col-md-3">
            <div class="form-group">
              <div class="form-group">
                <label for="">OverHead Cost</label>
                <VueNumberFormat
                  v-model:value="form.overhead"
                  class="form-control text-end"
                  readonly
                  :options="{ precision: 2 }"
                ></VueNumberFormat>
              </div>
            </div>
          </div>
          <div class="col-12 col-md-3">
            <div class="form-group">
              <div class="form-group">
                <label for="">Preliminary Selling Price</label>
                <VueNumberFormat
                  v-model:value="form.disered"
                  class="form-control text-end"
                  readonly
                ></VueNumberFormat>
              </div>
            </div>
          </div>
          <div class="col-12 col-md-3">
            <div class="form-group">
              <div class="form-group">
                <label for="">Projected Selling Cost</label>
                <VueNumberFormat
                  v-model:value="form.projectedSellCost"
                  class="form-control text-end"
                  :class="{ 'is-invalid': form.errors.has('projectedSellCost') }"
                ></VueNumberFormat>
                <div
                  class="text-danger"
                  v-if="form.errors.has('projectedSellCost')"
                  v-html="form.errors.get('projectedSellCost')"
                />
              </div>
            </div>
          </div>
          <div class="col-12 col-md-3">
            <div class="form-group">
              <div class="form-group">
                <label for="">Taxes</label>
                <VueNumberFormat
                  v-model:value="form.tax"
                  class="form-control text-end"
                  readonly
                  :options="{ precision: 2 }"
                ></VueNumberFormat>
              </div>
            </div>
          </div>
          <div class="col-12 col-md-3">
            <div class="form-group">
              <div class="form-group">
                <label for="">Selling Price</label>
                <VueNumberFormat
                  v-model:value="form.sell"
                  class="form-control text-end"
                  readonly
                ></VueNumberFormat>
              </div>
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
  <c-ingredient
    ref="listIngredient"
    :data="dataBahan"
    @emitAddIngredient="onAddIngredient"
  ></c-ingredient>
</template>

<script>
import { ref } from "vue";
import ingredient from "./Ingredient.vue";
export default {
  components: {
    "c-ingredient": ingredient,
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
        label: "Code",
        name: "code",
        type: "number",
        style: "cursor: pointer;",
      },
      {
        label: "Ingredient",
        name: "ingredient",
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
        label: "Unit",
        name: "unit",
        type: "string",
        style: "cursor: pointer;",
      },
      {
        label: "Unit Cost",
        name: "cost",
        type: "number",
        style: "cursor: pointer;",
      },
      {
        label: "Total",
        name: "total",
        type: "number",
        style: "cursor: pointer;",
      },
    ];
    columns.forEach((column) => {
      sortOrders[column.name] = -1;
    });
    return {
      bahanDisabled: true,
      tableLoading: false,
      columns: columns,
      sortKey: "code",
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
      optMenu: [],
      dataBahan: [],
      loading: false,
      disabled: false,
      form: new Form({
        tanggal: new Date(),
        notrx: "",
        key: "",
        preparation: "",
        menu: null,
        total: 0,
        projectedSellCost: 0,
        overhead: 0,
        disered: 0,
        tax: 0,
        sell: 0,
        stockProduksi: 0,
        barangbuy: [],
      }),
    };
  },
  created() {
    this.getListMenu();
    this.getEdit();
  },
  methods: {
    getEdit() {
      axios
        .get(`${this.$baseUrl}api/produksi/${this.$route.params.id}`)
        .then((response) => {
          const datafind = response.data;
          this.getListBahan();
          console.log(datafind);
          this.form.notrx = datafind.id;
          this.form.tanggal = datafind.tanggal;
          this.form.key = datafind.key_ing;
          this.form.preparation = datafind.preparation;
          this.form.total = datafind.sell_price;
          this.form.menu = datafind.barang_id;
          this.form.projectedSellCost = datafind.project_sell;
          this.form.overhead = datafind.overhead_cost;
          this.form.disered = datafind.disered;
          this.form.tax = datafind.tax_cost;
          this.form.sell = datafind.sell_cost;
          this.form.stockProduksi = datafind.stock_produksi;

          datafind.detail.forEach((value) => {
            this.form.barangbuy.push({
              articleNo: value.barang.kode,
              barangid: value.bahan_id,
              barangname: value.barang.nama_barang,
              qty: parseFloat(value.qty),
              unitmain: value.barang.unit.nama_satuan,
              cost: value.price,
              grandTotal: parseFloat(value.total),
              unit: value.unit,
              price: value.barang.harga_beli,
              stock: value.barang.stock,
            });
          });
        })
        .catch();
    },
    saveProduksi() {
      this.loading = true;
      this.disabled = true;
      this.form
        .put(`${this.$baseUrl}api/produksi/${this.form.notrx}`)
        .then((response) => {
          Toast.fire({
            icon: response.data.icon,
            title: response.data.message,
          });
          if (response.data.icon === "success") {
            this.$router.push({ name: "backend.produksi" });
          }
        })
        .catch(() => {
          this.loading = false;
          this.disabled = false;
        });
    },
    showListIngredient() {
      $("#modalBarang").modal("show");
    },
    deleteRow(index, item) {
      var idx = this.form.barangbuy.indexOf(item);
      console.log(idx, index);
      if (idx > -1) {
        this.form.barangbuy.splice(idx, 1);
      }
    },
    editRow(index, item) {
      this.$refs.listIngredient.handleEditClick(item);
      this.deleteRow(index, item);
      $("#modalBarang").modal("show");
    },
    onAddIngredient(value) {
      let dataBarang = this.form.barangbuy;
      let objIndex = dataBarang.findIndex(
        (obj) => obj.articleNo == value.articleNo && obj.unit == value.unit
      );
      if (objIndex === -1) {
        this.form.barangbuy.push({
          articleNo: value.articleNo,
          barangid: value.barangid,
          barangname: value.barangname,
          qty: parseFloat(value.qty),
          unitmain: value.unitmain,
          cost: value.cost,
          grandTotal: parseFloat(value.qty) * value.cost,
          unit: value.unit,
          price: value.price,
          stock: value.stock,
        });
      } else {
        this.form.barangbuy[objIndex].qty += value.qty;
        this.form.barangbuy[objIndex].cost = value.cost;
      }
      this.$refs.listIngredient.handleParentClick("ssss");
      $("#modalBarang").modal("hide");
    },
    getListMenu() {
      axios
        .get(`${this.$baseUrl}api/barang-jadi`)
        .then((response) => {
          response.data.forEach((row) => {
            this.optMenu.push({ code: row.id, label: row.nama_barang });
          });
        })
        .catch((error) => {
          console.log(`get Barang - ${error}`);
        });
    },
    getListBahan() {
      axios
        .get(`${this.$baseUrl}api/bahan-produksi`, {
          params: { id: btoa(this.form.menu) },
        })
        .then((response) => {
          this.dataBahan = response.data;
        })
        .catch((error) => {
          console.log(`get Barang - ${error}`);
        });
    },
    selectedMenu() {
      this.bahanDisabled = false;
      this.getListBahan();
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
        totalSaldo += parseFloat(row.qty) * parseFloat(row.cost);
      });
      this.form.total = totalSaldo;
      this.form.overhead = totalSaldo * (10 / 100);
      this.form.disered = (totalSaldo + parseFloat(this.form.overhead)) / (35 / 100);
      this.form.tax = this.form.disered * (21 / 100);
      this.form.sell = this.form.disered + this.form.tax;
      return totalSaldo;
    },
  },
};
</script>

<style></style>
