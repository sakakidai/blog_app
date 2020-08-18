<template>
  <b-container fluid = "sm" class="bv-example-row">
    <b-row>
      <b-col md="9">
        <div v-for="article in articles" :key=article.id class="mt-4">
          <b-card no-body class="overflow-hidden">
            <b-row no-gutters>
              <b-col cols="5">
                <b-card-img src="https://placekitten.com/320/180" alt="Image" class="rounded-0"></b-card-img>
              </b-col>
              <b-col cols="7">
                <b-card-body>
                  <b-card-title>
                    <a href="#">{{ article.title }}</a>
                  </b-card-title>
                  <b-card-text>
                    <pre>{{article.content}}</pre>
                  </b-card-text>
                </b-card-body>
              </b-col>
            </b-row>
          </b-card>
        </div>
      </b-col>
      <b-col md="3">col-4</b-col>
    </b-row>
  </b-container>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      articles: [],
    }
  },
  methods: {
    createArticle(article) {
      this.articles.unshift(article)
    },
  },
  created() {
    console.log('Created')
    axios
      .get('/api/v1/articles')
      .then(response => {
        this.articles = response.data.articles
      })
      .catch(error => {
        if (error.response.status === 500) {
          this.$refs['error-500-modal'].showModal()
        }
      })
  },
}
</script>
