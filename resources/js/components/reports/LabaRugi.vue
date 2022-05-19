<template>
  <div class="card">
    <div class="card-header">
      <h4 class="card-title">Laporan Laba Rugi</h4>
    </div>
    <div class="card-body">
      <form>
        <div class="row">
          <div class="col-md-2 col-sm-12">
            <div class="form-group">
              <label for="anggota_id">Periode</label>
              <v-datepicker
                @click="reset()"
                v-model="date"
                autoApply
                monthNameFormat="long"
                :enableTimePicker="false"
                monthPicker
              ></v-datepicker>
            </div>
          </div>
          <div class="col-md-3 col-sm-12">
            <div class="form-group">
              <button @click.prevent="cetak()" type="button" class="btn btn-danger mt-4">
                <i class="fas fa-print"></i> Cetak
              </button>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      date: {
        month: new Date().getMonth(),
        year: new Date().getFullYear(),
      },
    };
  },
  methods: {
    cetak() {
      window.open(`${this.$baseUrl}api/labarugi/cetak?date=${this.formatDate}`, "_blank");
    },
  },
  computed: {
    formatDate() {
      const bulandapat = parseInt(this.date.month) + 1;
      const bulan = bulandapat < 10 ? "0" + bulandapat : bulandapat;
      const tahun = this.date.year;
      return `${tahun}-${bulan}`;
    },
  },
};
</script>

<style></style>
