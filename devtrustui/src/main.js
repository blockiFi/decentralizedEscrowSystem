import Vue from 'vue'
import App from './App.vue'
import vuetify from '@/plugins/vuetify' 
import router from './router'
Vue.config.productionTip = false
Vue.component('loader', require('./components/loader.vue').default);
Vue.component('headercom', require('./components/headercom.vue').default);
Vue.component('footercom', require('./components/footercom.vue').default);
new Vue({
  router,
  vuetify,
  render: h => h(App),
}).$mount('#app')
