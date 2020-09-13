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
        thumbnailType: 'youtube',
        thumbnailTypeOptions: [
          { text: 'Youtube', value: 'youtube' },
          { text: '画像', value: 'image' }
        ],
        image: null,
        imageUrl: '',
        youtube: {
          video_id: null,
          _destroy: null
        },
        sections: [
          {
            id: null,
            title: '',
            description: '',
            _destroy: null,
            photo: null,
            photoUrl: ''
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
      const youtube_attributes = {
          video_id: this.article.youtube.video_id,
          _destroy: this.article.youtube._destroy
        }

      const sections_attributes = []
      this.article.sections.forEach(section => {
        const attributes = {
          id: section.id,
          title: section.title,
          description: section.description,
          photo: { data: section.photo },
          _destroy: section._destroy
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
              thumbnail_type: this.article.thumbnailType,
              image: { data: this.article.image },
              youtube_attributes: this.article.youtube.video_id ? youtube_attributes : {},
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

