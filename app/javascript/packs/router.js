import Vue from 'vue'
import Router from 'vue-router'
import ArticleIndex from '../components/articles/index.vue'
import ArticleShow from '../components/articles/show.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {path: '/', component: ArticleIndex},
    {path: '/articles/:id', component: ArticleShow}
  ]
})