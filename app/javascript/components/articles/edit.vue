<template>
  <div>
    <div>編集</div>
    <ArticleForm
      :article="article"
      @submit="update"
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
        id: '',
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
  created() {
    axios
      .get(`/api/v1/articles/${this.$route.params.id}`)
      .then(response => {
        this.article.id          = response.data.article.id
        this.article.title       = response.data.article.title
        this.article.description = response.data.article.description
        this.article.thumbnail   = response.data.article.thumbnail
      })
  },
  methods: {
    update() {
      axios
        .put(
          `/api/v1/articles/${this.article.id}`,
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
          this.flashMessage = { type: 'success', content: '編集しました' }
        })
        .catch(error => {
          console.log(error.response.data)
          this.flashMessage = { type: 'danger', content: 'エラーがあります' }
        })
        .finally(() => {
          this.$emit("createFlashMessage", this.flashMessage)
          if (this.flashMessage.type === 'success') {
            this.$router.push(`/articles/${this.article.id}`)
          }
        })
    }
  }
}
</script>