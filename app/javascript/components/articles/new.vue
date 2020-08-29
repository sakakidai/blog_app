<template>
  <div>
    <div>新規作成</div>
    <ArticleForm
      :article="article"
      @send-data="createArticle"
    ></ArticleForm>
  </div>
</template>

<script>
import axios from 'axios'
import ArticleForm from './form.vue'

export default {
  components: {
    ArticleForm
  },
  data() {
    return {
      article: {
        title: '',
        description: '',
        thumbnail: '',
      },
      flashMessage: {
        type: '',
        content: '',
      },
    }
  },
  methods: {
    createArticle() {
      axios
        .post(
          '/api/v1/articles',
          {
            article: {
              title: this.article.title,
              description: this.article.description,
              thumbnail: { data: this.article.thumbnail },
            },
            authenticity_token: document.getElementsByName('csrf-token')[0].content,
          },
        )
        .then(response => {
          this.flashMessage.type = 'success'
          this.flashMessage.content = '作成しました'
          this.article.title = ''
          this.article.description = ''
        })
        .catch(error => {
          console.log(error.response.data)
          this.flashMessage.type = 'danger'
          this.flashMessage.content = 'エラーがあります'
        })
        .finally(() => {
          this.$emit("createFlashMessage", this.flashMessage)
        })
    }
  }
}
</script>

