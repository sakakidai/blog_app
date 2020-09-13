// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import App from '../app.vue'
import router from './router'
import axios from 'axios'

Vue.config.productionTip = false
Vue.use(BootstrapVue)

Vue.mixin({
  data: function() {
    return {
      get defoultImage() {
        return 'https://placekitten.com/320/180'
      },
      get youtubeBaseUrl() {
        return 'https://www.youtube.com/embed/'
      }
    }
  }
})

document.addEventListener('DOMContentLoaded', () => {
  axios.defaults.headers.common['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].content
  axios.defaults.baseURL = 'http://localhost:3000'

  const app = new Vue({
    router,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
