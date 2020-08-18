import Vue from 'vue'
import ArticleShow from '../../components/articles/show.vue'
import BootstrapVue from 'bootstrap-vue'

Vue.config.productionTip = false
Vue.use(BootstrapVue)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(ArticleShow)
  }).$mount()
  document.body.appendChild(app.$el)
})