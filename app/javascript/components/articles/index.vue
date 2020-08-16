<template>
  <div>
    <Navbar @create-article="createArticle"></Navbar>
    <b-container>
      <p>記事一覧</p>
      <div>
        <div v-for="article in articles" :key=article.id>
          <p>{{article.title}}</p>
          <p>{{article.content}}</p>
          <br>
        </div>
      </div>
    </b-container>
  </div>
</template>

<script>
import axios from 'axios'
import Navbar from '../layouts/navbar.vue'

export default {
  components: {
    Navbar
  },
  data() {
    return {
      articles: []
    }
  },
  methods: {
    createArticle(article) {
      this.articles.unshift(article)
    }
  },
  created() {
    console.log('Created')
    axios
      .get('/api/v1/articles')
      .then(response => {
        this.articles = response.data.articles
      })
  },
}
</script>