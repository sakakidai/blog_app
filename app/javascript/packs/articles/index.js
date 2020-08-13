import Vue from 'vue'
import ArticleIndex from '../../components/articles/index.vue'
import BootstrapVue from 'bootstrap-vue'

Vue.config.productionTip = false
Vue.use(BootstrapVue)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(ArticleIndex)
  }).$mount()
  document.body.appendChild(app.$el)
})