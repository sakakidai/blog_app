<template>
  <div>
    <div>編集</div>
    <ArticleForm
      :article="article"
      @addSectionForm="addSection"
      @removeSectionForm ="removeSection"
      @unRemoveSectionForm="unRemoveSection"
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
        thumbnail: null,
        thumbnailUrl: '',
        sections: [],
      },
      flashMessage: {
        type: '',
        content: '',
      },
    }
  },
  created() {
    axios
      .get(`/api/v1/articles/${this.$route.params.id}/edit`)
      .then(response => {
        this.article.id           = response.data.article.id
        this.article.title        = response.data.article.title
        this.article.description  = response.data.article.description
        this.article.thumbnailUrl = response.data.article.thumbnail_url
        this.article.sections     = response.data.article.sections
        this.article.sections.forEach((section) => { Object.assign(section, {_destroy: null}) })
      })
  },
  methods: {
    addSection() {
      this.article.sections.push({
        id: null,
        title: '',
        description: '',
        _destroy: null,
      })
    },
    removeSection(index) {
      if (this.article.sections[index].id === null) {
        this.article.sections.splice(index, 1)
      } else {
        this.article.sections[index]._destroy = "1"
        this.$set(this.article.sections, index, this.article.sections[index])
      }
    },
    unRemoveSection(index) {
      this.article.sections[index]._destroy = null
      this.$set(this.article.sections, index, this.article.sections[index])
    },
    update() {
      axios
        .put(
          `/api/v1/articles/${this.article.id}`,
          {
            article: {
              title: this.article.title,
              description: this.article.description,
              thumbnail: { data: this.article.thumbnail },
              sections_attributes: this.article.sections
            }
          }
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