<template>
  <div class="card">
    <div class="card-header">
      <h4 class="card-title">Last HPP Barang</h4>
      <div class="card-tools">
        <router-link :to="{ name: 'backend.barang' }" class="btn btn-secondary">
          <i class="bi bi-arrow-left"></i> Back
        </router-link>
      </div>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered">
          <thead>
            <tr>
              <td colspan="5" class="text-center fw-bold">
                Category : <br />
                <span>{{ category }}</span
                ><br />
                Subcategory : <br />
                <span> {{ subcategory }}</span>
              </td>
              <td colspan="5" class="text-center">
                <p class="fw-bold text-center">HOTEL VILA LUMBUNG STANDARD MENU RECIPE</p>
                <img
                  :src="`${this.$baseUrl}images/barang/${
                    foto !== null ? foto : 'nopict.png'
                  }`"
                  alt="Logo"
                />
                <p v-show="foto === null">No Picture Available</p>
              </td>
            </tr>
          </thead>
          <tbody>
            <tr class="fw-bold text-center">
              <td>NO</td>
              <td>CODE</td>
              <td>INGREDIENT</td>
              <td colspan="2">MEANSURE</td>
              <td>QTY</td>
              <td>UNIT</td>
              <td colspan="2">UNIT COST</td>
              <td>TOTAL</td>
            </tr>
            <tr v-for="(r, i) in datas.detail" :key="i">
              <td class="text-center">{{ i + 1 }}</td>
              <td>{{ r.barang.kode }}</td>
              <td>{{ r.barang.nama_barang }}</td>
              <td></td>
              <td></td>
              <td class="text-end">{{ vueNumberFormat(r.qty, { precision: 2 }) }}</td>
              <td class="text-center">{{ r.unit }}</td>
              <td>{{ r.barang.kode }}</td>
              <td class="text-end">{{ vueNumberFormat(r.price, { precision: 2 }) }}</td>
              <td class="text-end">{{ vueNumberFormat(r.total, { precision: 0 }) }}</td>
            </tr>
            <tr>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="3">Total Ingridient Cost</td>
              <td colspan="4"></td>
              <td></td>
              <td></td>
              <td class="fw-bold text-end">
                {{ vueNumberFormat(datas.bahan_cost, { precision: 0 }) }}
              </td>
            </tr>
            <tr>
              <td colspan="3">Cost Over Head 10 % (Energy, Waste)</td>
              <td colspan="4"></td>
              <td></td>
              <td class="fw-bold text-center">10%</td>
              <td class="fw-bold text-end">
                {{ vueNumberFormat(datas.overhead_cost, { precision: 2 }) }}
              </td>
            </tr>
            <tr>
              <td colspan="3">Total recipe cost (per port)</td>
              <td colspan="4"></td>
              <td></td>
              <td></td>
              <td class="fw-bold text-end">
                {{
                  vueNumberFormat(datas.bahan_cost + datas.overhead_cost, {
                    precision: 0,
                  })
                }}
              </td>
            </tr>
            <tr>
              <td colspan="3">Desired Food Cost %</td>
              <td colspan="4" class="text-center">C Margin</td>
              <td></td>
              <td class="text-center fw-bold">35%</td>
              <td></td>
            </tr>
            <tr>
              <td colspan="3">Preliminary Selling Price (port)</td>
              <td colspan="4"></td>
              <td></td>
              <td></td>
              <td class="text-end fw-bold">
                {{
                  vueNumberFormat(datas.desired_cost, {
                    precision: 0,
                  })
                }}
              </td>
            </tr>
            <tr>
              <td colspan="3">Projected Selling Price</td>
              <td colspan="4"></td>
              <td></td>
              <td></td>
              <td class="text-end fw-bold">
                {{ vueNumberFormat(datas.project_sell, { precision: 0 }) }}
              </td>
            </tr>
            <tr>
              <td colspan="3">Taxes 21%</td>
              <td colspan="4"></td>
              <td></td>
              <td></td>
              <td class="text-end fw-bold">
                {{ vueNumberFormat(datas.tax_cost, { precision: 2 }) }}
              </td>
            </tr>
            <tr>
              <td colspan="3">Selling Price</td>
              <td colspan="4"></td>
              <td></td>
              <td></td>
              <td class="text-end fw-bold">
                {{ vueNumberFormat(datas.sell_price, { precision: 0 }) }}
              </td>
            </tr>
            <tr>
              <td colspan="3">Actual Food Cost</td>
              <td colspan="4"></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
            <tr class="fw-bold">
              <td colspan="10">Key Ingredients :</td>
            </tr>
            <tr>
              <td colspan="10">{{ datas.key_ing }}</td>
            </tr>
            <tr>
              <td colspan="10" class="fw-bold">Preparation:</td>
            </tr>
            <tr>
              <td colspan="10" style="white-space: pre">{{ datas.preparation }}</td>
            </tr>
          </tfoot>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      datas: [],
      category: null,
      subcategory: null,
      foto: null,
      nama_menu: null,
    };
  },
  created() {
    this.getData();
  },
  methods: {
    getData() {
      axios
        .get(`${this.$baseUrl}api/barang-hpp`, {
          params: { id: atob(this.$route.params.id) },
        })
        .then((response) => {
          this.datas = response.data;
          this.category = this.datas.menu.subcategory.category.category_name;
          this.subcategory = this.datas.menu.subcategory.subcategory_name;
          this.foto = this.datas.menu.foto;
          this.nama_menu = this.datas.menu.nama_barang;
        })
        .catch();
    },
  },
};
</script>

<style></style>
