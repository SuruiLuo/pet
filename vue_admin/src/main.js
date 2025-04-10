import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import ElementUI from 'element-ui';
import 'vue-json-viewer/style.css'
import 'element-ui/lib/theme-chalk/index.css';
import './assets/css/global.css'
import request from "@/utils/request";
import directives from "./directives";
import JsonViewer from 'vue-json-viewer/ssr'

Vue.config.productionTip = false

Vue.prototype.request = request
Vue.use(JsonViewer)
Vue.use(ElementUI, {size: store.state.layout.currentUiSize});
Vue.use(directives)
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
