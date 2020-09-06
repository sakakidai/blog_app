<template>
  <div>
    <div class="article">
      <b-img
        v-show="article.thumbnailUrl"
        :src="article.thumbnailUrl"
        alt="ThumbnailUrl"
        fluid-grow
      ></b-img>
      <div class="article-main-info">
        <h3>{{ article.title }}</h3>
        <b-link :to="'/articles/' + article.id + '/edit'">編集</b-link>
        <b-link v-b-modal.my-modal>削除</b-link>
        <b-card-text>
          <pre>{{article.description}}</pre>
        </b-card-text>
      </div>
    </div>

    <div v-for="(section, index) in article.sections" :key=index class="sections">
      <b-img
        v-show="section.photo_url"
        :src="section.photo_url"
        alt="PhotoUrl"
        fluid-grow
      ></b-img>

      <div class="section-main-info">
        <h3>{{ section.title }}</h3>
        <b-card-text>
          <pre>{{section.description}}</pre>
        </b-card-text>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      article: {
        id: '',
        title: '',
        description: '',
        thumbnailUrl: '',
        sections: [],
      },
      defoultThumbnail: 'https://placekitten.com/320/180',
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
        this.article.id           = response.data.article.id
        this.article.title        = response.data.article.title
        this.article.description  = response.data.article.description
        this.article.thumbnailUrl = response.data.article.thumbnail_url || this.defoultThumbnail
        this.article.sections     = response.data.article.sections
      })
  },
  methods: {
    destroy(id) {
      axios
        .delete('/api/v1/articles/' + id)
        .then(response => {
          console.log(response)
          this.flashMessage.type = 'success'
          this.flashMessage.content = '記事を削除しました'
        })
        .finally(() => {
          this.$emit("createFlashMessage", this.flashMessage)
          this.$router.push('/')
        })
    },
  },
}
</script>