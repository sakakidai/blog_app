<template>
  <div>
    <div>新規作成</div>
    <ArticleForm
      :article="article"
      @submit="create"
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
        thumbnail: null,
        sections: [
          {
            id: null,
            title: '',
            description: '',
          }
        ],
      },
      flashMessage: {
        type: '',
        content: '',
      },
    }
  },
  methods: {
    create() {
      console.log(this.article.sections)
      axios
        .post(
          '/api/v1/articles',
          {
            article: {
              title: this.article.title,
              description: this.article.description,
              thumbnail: { data: this.article.thumbnail },
              sections_attributes: this.article.sections
            },
            authenticity_token: document.getElementsByName('csrf-token')[0].content,
          },
        )
        .then(response => {
          this.flashMessage = { type: 'success', content: '作成しました' }
        })
        .catch(error => {
          console.log(error.response.data)
          this.flashMessage = { type: 'danger', content: 'エラーがあります' }
        })
        .finally(() => {
          this.$emit("createFlashMessage", this.flashMessage)
          if (this.flashMessage.type === 'success') {
            this.$router.push('/articles')
          }
        })
    }
  }
}
</script>

