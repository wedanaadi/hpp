<template>
  <!-- modal -->
  <div
    class="modal"
    id="modalDetail"
    tabindex="-1"
    data-bs-backdrop="static"
    data-bs-keyboard="false"
  >
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Detail Menu {{ data.nama_barang }}</h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <div class="table-responsive">
            <table v-show="isShow" class="w-100 table table-bordered">
              <tr>
                <td>Main Group</td>
                <td>: {{ detil.main }}</td>
                <td></td>
                <td>Harga Jual</td>
                <td>: {{ vueNumberFormat(detil.price, { precision: 2 }) }}</td>
              </tr>
              <tr>
                <td>Sub Main Group</td>
                <td>: {{ detil.sub }}</td>
                <td></td>
                <!-- <td>Last Harga Beli</td>
                <td>
                  :
                  {{ vueNumberFormat(detil.last, { precision: 2 }) }}
                </td> -->
              </tr>
            </table>
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
      default: [],
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
      isShow: false,
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
  computed: {
    detil() {
      const data = this.data;
      console.log(data);
      if (data.length > 0) {
        this.isShow = true;
        return {
          main: data[0].main,
          sub: data[0].sub,
          price: data[0].price,
          last: data[0].last,
        };
      } else {
        this.isShow = false;
        return {};
      }
    },
  },
};
</script>

<style></style>
