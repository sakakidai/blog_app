<template>
  <div>
    <div>新規作成</div>
    <ArticleForm
      :article="article"
      @addSectionForm="addSection"
      @removeSectionForm ="removeSection"
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
        thumbnailUrl: '',
        sections: [
          {
            id: null,
            title: '',
            description: '',
            _destroy: null,
            photo: null,
            photoUrl: '',
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
    addSection() {
      this.article.sections.push({
        id: null,
        title: '',
        description: '',
        _destroy: null,
        photo: null,
        photoUrl: '',
      })
    },
    removeSection(index) {
      this.article.sections.splice(index, 1)
    },
    create() {
      const sections_attributes = []

      this.article.sections.forEach(section => {
        const attributes = {
          id: section.id,
          title: section.title,
          description: section.description,
          photo: { data: section.photo },
        }
        sections_attributes.push(attributes)
      })

      axios
        .post(
          '/api/v1/articles',
          {
            article: {
              title: this.article.title,
              description: this.article.description,
              thumbnail: { data: this.article.thumbnail },
              sections_attributes: sections_attributes
            }
          }
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

