<template>
  <!-- modal -->
  <div
    class="modal"
    id="modalBarang"
    tabindex="-1"
    data-bs-backdrop="static"
    data-bs-keyboard="false"
  >
    <div class="modal-dialog modal-lg">
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
          <div class="row">
            <div class="form-group">
              <label for="">Barang</label>
              <v-select
                @option:selected="selected"
                v-model="ingredientAdd.barangid"
                :reduce="(option) => option.code"
                :options="selectBrg"
                placeholder="Barang..."
              ></v-select>
            </div>
          </div>
          <div v-show="isAlert" class="alert alert-danger" role="alert">
            Stock kosong!
          </div>
          <hr />
          <h3>Ingredient Hand On</h3>
          <div class="row">
            <div class="col-12 col-md-4">
              <div class="form-group">
                <label for="">Unit Ingredient</label>
                <input
                  v-model="ingredientAdd.unitmain"
                  type="text"
                  class="form-control"
                  placeholder="Ingredient Unit"
                  readonly
                />
              </div>
            </div>
            <div class="col-12 col-md-4">
              <div class="form-group">
                <label for="">Stock Ingredient</label>
                <input
                  v-model="ingredientAdd.stock"
                  type="text"
                  class="form-control text-end"
                  placeholder="Ingredient Stock"
                  readonly
                />
              </div>
            </div>
            <div class="col-12 col-md-4">
              <div class="form-group">
                <label for="">Price Ingredient</label>
                <VueNumberFormat
                  v-model:value="ingredientAdd.price"
                  class="form-control text-end"
                  readonly
                ></VueNumberFormat>
              </div>
            </div>
          </div>
          <hr />
          <template v-if="showCalculation">
            <h3>Calculation</h3>
            <div class="row">
              <label for="">Conversion Unit</label>
              <ul class="list-unstyled mb-0">
                <li class="d-inline-block me-2 mb-1">
                  <div class="form-check">
                    <div class="custom-control custom-checkbox">
                      <input
                        @change="changeStatus('kgtogram')"
                        type="checkbox"
                        class="form-check-input form-check-primary"
                        :checked="check.kgtogram"
                      />
                      <label class="form-check-label" for="customColorCheck1">
                        to Gram (Gr)
                      </label>
                    </div>
                  </div>
                </li>
                <li class="d-inline-block me-2 mb-1">
                  <div class="form-check">
                    <div class="custom-control custom-checkbox">
                      <input
                        @change="changeStatus('ltoml')"
                        type="checkbox"
                        class="form-check-input form-check-primary"
                        :checked="check.ltoml"
                      />
                      <label class="form-check-label" for="customColorCheck1">
                        to Mililiter (Ml)
                      </label>
                    </div>
                  </div>
                </li>
              </ul>
            </div>
            <div class="row">
              <div class="col-12 col-md-3">
                <div class="form-group">
                  <label for="">Unit</label>
                  <v-select
                    v-model="ingredientAdd.unit"
                    :options="optUnit"
                    placeholder="Unit Cost..."
                    :disabled="true"
                  ></v-select>
                </div>
              </div>
              <div class="col-12 col-md-4">
                <div class="form-group">
                  <label for="">Qty</label>
                  <input
                    v-model="ingredientAdd.qty"
                    step=".01"
                    type="number"
                    class="form-control"
                    placeholder="Qty"
                  />
                </div>
              </div>
              <div class="col-12 col-md-4">
                <div class="form-group">
                  <label for="">Cost</label>
                  <VueNumberFormat
                    v-model:value="ingredientAdd.cost"
                    class="form-control text-end"
                    :options="{ precision: 2 }"
                  ></VueNumberFormat>
                </div>
              </div>
            </div>
          </template>
        </div>
        <div class="modal-footer">
          <button
            @click="addBarang()"
            type="button"
            class="btn btn-primary"
            :disabled="disabled"
          >
            <div v-show="loading" class="spinner-border text-white" role="status"></div>
            Add Ingredient
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
    return {
      costOld: 0,
      isAlert: false,
      showCalculation: false,
      check: {
        kgtogram: false,
        ltoml: false,
      },
      loading: false,
      disabled: true,
      optUnit: [],
      ingredientAdd: new Form({
        barangid: null,
        barangname: null,
        articleNo: null,
        unit: null,
        qty: 0,
        stock: 0,
        cost: 0,
        unitmain: null,
        price: 0,
        total: 0,
      }),
    };
  },
  created() {
    this.getUnitMain();
  },
  methods: {
    handleEditClick(item) {
      this.ingredientAdd.fill(item);
      if (this.ingredientAdd.unit.toLowerCase() === "Gr".toLowerCase()) {
        this.check.kgtogram = true;
        this.check.ltoml = false;
      }
      if (this.ingredientAdd.unit.toLowerCase() === "Ml".toLowerCase()) {
        this.check.kgtogram = false;
        this.check.ltoml = true;
      }
      this.disabled = false;
      this.showCalculation = true;
    },
    handleParentClick(e) {
      this.ingredientAdd.clear();
      this.ingredientAdd.reset();
      this.showCalculation = false;
    },
    changeStatus(event) {
      if (event === "kgtogram") {
        this.check.kgtogram = !this.check.kgtogram;
        this.check.ltoml = false;
        if (this.check.kgtogram) {
          let hitung = parseFloat(this.ingredientAdd.price) / 1000;
          this.ingredientAdd.cost = hitung;

          let dataTemp = this.optUnit;
          let objIndex = dataTemp.findIndex((obj) => obj == "Gr".toString());
          this.ingredientAdd.unit = this.optUnit[objIndex];
        } else {
          this.ingredientAdd.unit = this.ingredientAdd.unitmain;
          this.ingredientAdd.cost = 0;
          this.ingredientAdd.cost = this.costOld;
        }
      }

      if (event === "ltoml") {
        this.check.ltoml = !this.check.ltoml;
        this.check.kgtogram = false;
        if (this.check.ltoml) {
          let hitung = parseFloat(this.ingredientAdd.price) / 1000;
          this.ingredientAdd.cost = hitung;

          let dataTemp = this.optUnit;
          let objIndex = dataTemp.findIndex((obj) => obj == "Ml".toString());
          this.ingredientAdd.unit = this.optUnit[objIndex];
        } else {
          this.ingredientAdd.unit = this.ingredientAdd.unitmain;
          this.ingredientAdd.cost = this.costOld;
        }
      }
    },
    getUnitMain() {
      axios
        .get(`${this.$baseUrl}api/unit`)
        .then((response) => {
          response.data.forEach((r) => {
            this.showCalculation = false;
            this.optUnit.push(r.nama_satuan);
          });
        })
        .catch((err) => {
          console.log(err);
        });
    },
    selected() {
      const id = this.ingredientAdd.barangid;
      let dataBarang = this.data;
      dataBarang = dataBarang.filter((row) => {
        return Object.keys(row).some((key) => {
          return String(row[key]).toLowerCase().indexOf(id) > -1;
        });
      });
      if (parseFloat(dataBarang[0].stock) > 0) {
        this.disabled = false;
        this.isAlert = false;
        this.showCalculation = true;
      } else {
        this.disabled = true;
        this.isAlert = true;
        this.showCalculation = false;
      }
      this.ingredientAdd.price = dataBarang[0].harga_beli;
      this.ingredientAdd.unitmain = dataBarang[0].unit.nama_satuan;
      this.ingredientAdd.articleNo = dataBarang[0].kode;
      this.ingredientAdd.barangname = dataBarang[0].nama_barang;
      this.ingredientAdd.stock = dataBarang[0].stock;
      //   this.showCalculation = true;
      this.ingredientAdd.unit = dataBarang[0].unit.nama_satuan;
      this.ingredientAdd.cost = dataBarang[0].harga_beli;
      this.costOld = dataBarang[0].harga_beli;
      this.check.kgtogram = false;
      this.check.ltoml = false;
    },
    addBarang() {
      if (!this.ingredientAdd.barangid) {
        Toast.fire({
          icon: "warning",
          title: "Pilih Barang!",
        });
      } else if (this.ingredientAdd.qty === 0) {
        Toast.fire({
          icon: "warning",
          title: "Qty tidak valid!",
        });
      } else if (this.ingredientAdd.unit === null) {
        Toast.fire({
          icon: "warning",
          title: "Pilih Unit Cost!",
        });
      } else {
        this.$emit("emitAddIngredient", this.ingredientAdd);
      }
    },
  },
  computed: {
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

<style></style>
