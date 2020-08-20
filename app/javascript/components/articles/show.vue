<template>
  <b-card no-body class="overflow-hidden">
    <b-row no-gutters>
      <b-col cols="5">
        <b-card-img src="https://placekitten.com/320/180" alt="Image" class="rounded-0"></b-card-img>
      </b-col>
      <b-col cols="7">
        <b-card-body>
          <b-card-title>
            <b-link :to="'/articles/' + article.id">{{ article.title }}</b-link>
          </b-card-title>
          <b-card-text>
            <pre>{{article.content}}</pre>
          </b-card-text>

          <b-card-text class="small text-muted">
            Last updated 3 mins ago
            <b-link :to="'/articles/' + article.id + '/edit'">編集</b-link>
          </b-card-text>
        </b-card-body>
      </b-col>
    </b-row>
  </b-card>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      article: {
        title: '',
        content: '',
      },
    }
  },
  created() {
    axios
      .get('/api/v1/articles/' + this.$route.params.id)
      .then(response => {
        this.article.title = response.data.article.title
        this.article.content = response.data.article.content
      })
  },
}
</script>