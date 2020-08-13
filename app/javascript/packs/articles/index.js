import Vue from 'vue'
import ArticleIndex from '../../components/articles/index.vue'

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(ArticleIndex)
  }).$mount()
  document.body.appendChild(app.$el)
})