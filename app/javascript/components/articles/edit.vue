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
        thumbnailType: '',
        image: null,
        imageUrl: '',
        youtube: {
          video_id: null,
          _destroy: null
        },
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
        this.article.id               = response.data.article.id
        this.article.title            = response.data.article.title
        this.article.description      = response.data.article.description
        this.article.thumbnailType    = response.data.article.thumbnail_type
        this.article.youtube.video_id = response.data.article.youtube.video_id
        this.article.imageUrl         = response.data.article.image_url
        this.article.sections         = response.data.article.sections
        const mergeAttributes         = { _destroy: null, photo: null }
        this.article.sections.forEach((section) => { Object.assign(section, mergeAttributes) })
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
        .put(
          `/api/v1/articles/${this.article.id}`,
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