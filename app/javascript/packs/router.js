import Vue from 'vue'
import Router from 'vue-router'
import ArticleIndex from '../components/articles/index.vue'
import ArticleShow from '../components/articles/show.vue'
import ArticleEdit from '../components/articles/edit.vue'
import ArticleNew from '../components/articles/new.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {path: '/', component: ArticleIndex},
    {path: '/articles', component: ArticleIndex},
    {path: '/articles/new', component: ArticleNew},
    {path: '/articles/:id', component: ArticleShow},
    {path: '/articles/:id/edit', component: ArticleEdit},
  ]
})