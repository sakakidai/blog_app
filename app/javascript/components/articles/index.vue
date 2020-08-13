<template>
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
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      articles: []
    }
  },
  created() {
    axios
      .get('/api/v1/articles')
      .then(response => {
        this.articles = response.data.articles
      })
  }
}
</script>