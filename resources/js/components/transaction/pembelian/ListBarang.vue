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
                v-model="barangAdd.barangid"
                :reduce="(option) => option.code"
                :options="selectBrg"
                placeholder="Barang..."
              ></v-select>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-md-4">
              <div class="form-group">
                <label for="">Unit</label>
                <input
                  v-model="barangAdd.unit"
                  type="text"
                  class="form-control"
                  placeholder="Unit"
                  readonly
                />
              </div>
            </div>
            <div class="col-12 col-md-4">
              <div class="form-group">
                <label for="">Qty</label>
                <input
                  v-model="barangAdd.qty"
                  type="number"
                  class="form-control"
                  placeholder="Qty"
                />
              </div>
            </div>
            <div class="col-12 col-md-4">
              <div class="form-group">
                <label for="">Harga</label>
                <VueNumberFormat
                  v-model:value="barangAdd.price"
                  class="form-control text-end"
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
            Tambah Barang
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
  // props: {
  //   data: {
  //     Type: String,
  //     default: [],
  //   },
  // },
  data() {
    return {
      loading: false,
      disabled: false,
      barangAdd: new Form({
        barangid: null,
        barangname: null,
        unit: null,
        qty: 0,
        price: 0,
        lastPrice: 0,
        articleNo: null,
      }),
    };
  },
  methods: {
    handleParentClick(e) {
      this.barangAdd.clear();
      this.barangAdd.reset();
    },
    handleEditClick(item) {
      this.barangAdd.fill(item);
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
        this.$emit("emitAddBarang", this.barangAdd);
      }
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
