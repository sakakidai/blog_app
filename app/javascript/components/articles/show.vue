<template>
  <b-card no-body class="overflow-hidden">
    <b-img
      v-show="article.thumbnail"
      class="preview-item-file"
      :src="article.thumbnail"
      fluid
      alt=""
    ></b-img>

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
            <b-link v-b-modal.my-modal>削除</b-link>
            <b-modal
              id="my-modal"
              hide-footer
              title="削除します本当によろしいですか？"
            >
              <b-button class="mt-3" variant="outline-danger" block @click="destroyArticle(article.id)">削除</b-button>
            </b-modal>
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
        id: '',
        title: '',
        content: '',
        thumbnail: null,
      },
      flashMessage: {
        type: '',
        content: '',
      },
    }
  },
  created() {
    axios
      .get('/api/v1/articles/' + this.$route.params.id)
      .then(response => {
        this.article.id        = response.data.article.id
        this.article.title     = response.data.article.title
        this.article.content   = response.data.article.content
        this.article.thumbnail = response.data.article.thumbnail
      })
  },
  methods: {
    destroyArticle(id) {
      axios
        .delete(
          '/api/v1/articles/' + id,
          { params: {
            authenticity_token: document.getElementsByName('csrf-token')[0].content,
            },
          },
        )
        .then(response => {
          console.log(response)
          this.flashMessage.type = 'success'
          this.flashMessage.content = '記事を削除しました'
        })
        .finally(() => {
          this.$emit("createFlashMessage", this.flashMessage)
          this.$router.push('/')
        })
    }
  }
}
</script>