<template>
  <div>
    <div v-for="(article, index) in articles" :key=index class="mt-4">
      <b-card no-body class="overflow-hidden">
        <b-row no-gutters>
          <b-col cols="5">
            <div class="thumbnail">
              <b-embed
                v-if="article.thumbnail_type === 'youtube'"
                type="iframe"
                aspect="16by9"
                :src="article.youtube_url"
                allowfullscreen
              ></b-embed>
              <b-card-img
                v-else-if="article.thumbnail_type === 'image'"
                :src="article.image_url || defoultImage"
                alt="ThumbnailImage"
              ></b-card-img>
            </div>
          </b-col>
          <b-col cols="7">
            <b-card-body>
              <b-card-title>
                <span>{{ article.id }}</span>
                <b-link :to="'/articles/' + article.id">{{ article.title }}</b-link>
              </b-card-title>
              <b-card-text>
                <pre>{{article.description}}</pre>
              </b-card-text>

              <b-card-text class="small text-muted">
                Last updated 3 mins ago
                <b-link :to="'/articles/' + article.id + '/edit'">編集</b-link>
                <b-link v-b-modal="'destroy-article' + article.id">削除</b-link>
                <b-modal
                  :id="'destroy-article' + article.id"
                  hide-footer
                  title="削除します本当によろしいですか？"
                >
                  <b-button class="mt-3" variant="outline-danger" block @click="destroy(article.id, index)">削除</b-button>
                </b-modal>
              </b-card-text>
            </b-card-body>
          </b-col>
        </b-row>
      </b-card>
    </div>

    <Pagination
      v-if="page.total !== 0"
      :page="page"
      url='articles'
      @changePage="fetchArticles"
    ></Pagination>
  </div>
</template>

<script>
import axios from 'axios'
import Pagination from '../layouts/pagination.vue'

export default {
  components: {
    Pagination
  },
  data() {
    return {
      articles: [],
      flashMessage: {
        type: '',
        content: '',
      },
      page: {
        current: null,
        total: null,
      }
    }
  },
  methods: {
    destroy(id, index) {
      axios
        .delete('/api/v1/articles/' + id)
        .then(response => {
          this.flashMessage.type = 'success'
          this.flashMessage.content = '記事を削除しました'
          this.$delete(this.articles, index)
          this.$emit("createFlashMessage", this.flashMessage)
        })
    },
    fetchArticles() {
      axios
        .get(
          'api/v1/articles',
          { params: { page: this.page.current } }
        )
        .then(response => {
          this.articles   = response.data.articles
          this.page.total = response.data.total_pages
        })
    }
  },
  created() {
    this.page.current = this.$route.query.page || 1
    this.fetchArticles()
  },
}
</script>
