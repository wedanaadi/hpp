import login from "./components/Login.vue";
import backend from "./components/Backend.vue";
import supplier from "./components/master/Supplier.vue";
import user from "./components/master/User.vue";
import akun from "./components/master/Akun/Akun.vue";
import akunadd from "./components/master/Akun/Add.vue";
import akunedit from "./components/master/Akun/Edit.vue";
import category from "./components/master/Category.vue";
import subcategory from "./components/master/Subcategory.vue";
import barang from "./components/master/barang/Barang.vue";
import barangadd from "./components/master/barang/Add.vue";
import barangedit from "./components/master/barang/Edit.vue";
import pembelian from "./components/transaction/pembelian/Pembelian.vue";
import pembelianadd from "./components/transaction/pembelian/Add.vue";
import pembelianedit from "./components/transaction/pembelian/Edit.vue";
import jurnal from "./components/transaction/jurnal/Jurnal.vue";
import penjualan from "./components/transaction/penjualan/Penjualan.vue";
import penjualanadd from "./components/transaction/penjualan/Add.vue";
import penjualanedit from "./components/transaction/penjualan/Edit.vue";
import produksi from "./components/transaction/produksi/Produksi.vue";
import produksiadd from "./components/transaction/produksi/Add.vue";
import produksiedit from "./components/transaction/produksi/Edit.vue";
import hpp from "./components/master/barang/Hpp.vue"
import reportpembelian from "./components/reports/Pembelian.vue";
import reportpenjualan from "./components/reports/Penjualan.vue";
import reportstock from "./components/reports/Stock.vue";
import lb from "./components/reports/LabaRugi.vue";
import neraca from "./components/reports/Neraca.vue"
import hppreport from "./components/reports/Persediaan.vue"
import dashboard from "./components/Dashboard.vue"
import menu from "./components/master/menu/Menu.vue"
import menuadd from "./components/master/menu/Add.vue"
import menuedit from "./components/master/menu/Edit.vue"

export const routes = [
    {
        name: "login",
        path: "/login",
        component: login,
    },
    {
        name: "backend",
        path: "/",
        component: backend,
        children: [
            {
                name: "home",
                path: "/dashboard",
                component: dashboard,
            },
            {
                name: "backend.supplier",
                path: "/supplier",
                component: supplier,
            },
            {
                name: "backend.user",
                path: "/user",
                component: user,
            },
            {
                name: "backend.akun",
                path: "/akun",
                component: akun,
            },
            {
                name: "akun.add",
                path: "/akunadd",
                component: akunadd,
            },
            {
                name: "akun.edit",
                path: "/akunedit",
                component: akunedit,
                props: true,
            },
            {
                name: "backend.category",
                path: "/category",
                component: category,
            },
            {
                name: "backend.subcategory",
                path: "/subcategory",
                component: subcategory,
            },
            {
                name: "backend.barang",
                path: "/barang",
                component: barang,
            },
            {
                name: "barang.add",
                path: "/barangadd",
                component: barangadd,
            },
            {
                name: "barang.hpp",
                path: "/baranghpp/:id",
                component: hpp,
            },
            {
                name: "barang.edit",
                path: "/barangedit",
                component: barangedit,
                props: true,
            },
            {
                name: "backend.pembelian",
                path: "/pembelian",
                component: pembelian,
            },
            {
                name: "pembelian.add",
                path: "/pembelian-add",
                component: pembelianadd,
            },
            {
                name: "pembelian.edit",
                path: "/pembelian-edit/:id",
                component: pembelianedit,
                // props: true,
            },
            {
                name: "backend.jurnal",
                path: "/jurnal",
                component: jurnal,
            },
            {
                name: "backend.penjualan",
                path: "/penjualan",
                component: penjualan,
            },
            {
                name: "penjualan.add",
                path: "/penjualan-add",
                component: penjualanadd,
            },
            {
                name: "penjualan.edit",
                path: "/penjualan-edit/:id",
                component: penjualanedit,
            },
            {
                name: "backend.produksi",
                path: "/produksi",
                component: produksi,
            },
            {
                name: "produksi.add",
                path: "/produksi-add",
                component: produksiadd,
            },
            {
                name: "produksi.edit",
                path: "/produksi-edit/:id",
                component: produksiedit,
            },
            {
                name: "report.pembelian",
                path: "pembelianreport",
                component: reportpembelian,
            },
            {
                name: "report.penjualan",
                path: "penjualanreport",
                component: reportpenjualan,
            },
            {
                name: "report.stock",
                path: "stockreport",
                component: reportstock,
            },
            {
                name: "report.labarugi",
                path: "labarugireport",
                component: lb,
            },
            {
                name: "report.neraca",
                path: "neracareport",
                component: neraca,
            },
            {
                name: "report.persediaan",
                path: "persediaanreport",
                component: hppreport,
            },
            {
                name: "backend.menu",
                path: "menu",
                component: menu
            },
            {
                name: "menu.add",
                path: "/menuadd",
                component: menuadd,
            },
            {
                name: "menu.edit",
                path: "/menuedit",
                component: menuedit,
                props: true,
            },
        ],
    },
];
