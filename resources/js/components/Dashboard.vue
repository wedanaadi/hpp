<template>
  <div class="card">
    <div class="card-header">
      <h4 class="card-title">Dashboard</h4>
    </div>
    <div class="card-body">
      <div class="d-flex justify-content-center">
        <v-calendar />
      </div>
      <hr />
      <h3>Grafik Penjualan Periode Tahun {{ GrafikYear }}</h3>
      <Bar
        :chart-options="chartOptions"
        :chart-data="chartData"
        :chart-id="chartId"
        :dataset-id-key="datasetIdKey"
        :plugins="plugins"
        :css-classes="cssClasses"
        :styles="styles"
        :width="width"
        :height="height"
      />
    </div>
  </div>
</template>

<script>
import { Bar } from "vue-chartjs";
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);
export default {
  name: "BarChart",
  components: { Bar },
  props: {
    chartId: {
      type: String,
      default: "bar-chart",
    },
    datasetIdKey: {
      type: String,
      default: "label",
    },
    width: {
      type: Number,
      default: 400,
    },
    height: {
      type: Number,
      default: 400,
    },
    cssClasses: {
      default: "",
      type: String,
    },
    styles: {
      type: Object,
      default: () => {},
    },
    plugins: {
      type: Object,
      default: () => {},
    },
  },
  data() {
    return {
      GrafikYear: "",
      chartData: {
        labels: [
          "Januari",
          "Februari",
          "Maret",
          "April",
          "Mei",
          "Juni",
          "Agustus",
          "September",
          "Oktober",
          "November",
          "Desember",
        ],
        datasets: [],
      },
      chartOptions: {
        responsive: true,
      },
    };
  },
  created() {
    this.getChart();
  },
  methods: {
    getChart() {
      axios
        .get(`${this.$baseUrl}api/chart`)
        .then((response) => {
          this.chartData.datasets.push({ data: response.data.dataSet });
          this.GrafikYear = response.data.year;
        })
        .catch();
    },
  },
};
</script>

<style></style>
