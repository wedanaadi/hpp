require('./bootstrap');

import { createApp } from 'vue'
import HelloWorld from './components/Hello.vue'

import { createRouter, createWebHistory } from 'vue-router'
import { routes } from './routes';


const BASE_URL = "hpp/public";
const router = createRouter({
  history: createWebHistory(BASE_URL),
  base: BASE_URL,
  routes,
});

// VFORM
import { Form } from 'vform';
import { HasError, AlertError } from 'vform/src/components/bootstrap4';
window.Form = Form;

// sweetalert
import Swal from 'sweetalert2'
window.Swal = Swal;
const Toast = Swal.mixin({
  toast: true,
  position: 'top-end',
  showConfirmButton: false,
  timer: 2000
})
window.Toast = Toast;

// v-select
import vSelect from 'vue-select'

// vue format number
import VueNumberFormat from 'vue-number-format'

// datepicker
import Datepicker from "vue3-date-time-picker";

import VCalendar from 'v-calendar';

const app = createApp({});
app.use(router)
app.use(VCalendar, {})
app.use(VueNumberFormat, { precision: 0, prefix: '', decimal: ',', thounsand: '.' })
app.config.globalProperties.$baseUrl = "http://localhost/hpp/public/";
app.component('hello-world', HelloWorld);
app.component('v-select', vSelect);
app.component(HasError.name, HasError);
app.component(AlertError.name, AlertError);
app.component('v-datepicker', Datepicker);
app.mount('#app');
