<template>
  <div>
    <div>編集</div>
    <b-form-group>
      <label for="article_title">タイトル:</label>
      <b-form-input
        id="article_title"
        v-model.trim="article.title"
        :state="articleTitleStatus"
        type="text"
      ></b-form-input>
      <b-form-invalid-feedback id="article_title_feedback">
        １〜30文字で入力してください。
      </b-form-invalid-feedback>
    </b-form-group>

    <b-form-group>
      <label for="article_content">内容:</label>
      <b-form-textarea
        id="article_content"
        v-model.trim="article.content"
        :state="articleContentStatus"
        rows="5"
        max-rows="8"
      ></b-form-textarea>
      <b-form-invalid-feedback id="article_content_feedback">
        １文字以上入力してください。
      </b-form-invalid-feedback>
    </b-form-group>
    <b-button
      type="submit"
      @click="updateArticle"
      :disabled="submitStatus"
      block
      class="mt-3"
    >送信</b-button>
    <b-button class="mt-3" block @click="$bvModal.hide('new_article_modal')">閉じる</b-button>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  computed: {
    articleTitleStatus() {
      return 30 >= this.article.title.length && this.article.title.length > 0 ? true : false
    },
    articleContentStatus() {
      return this.article.content.length > 0 ? true : false
    },
    submitStatus() {
      return this.articleTitleStatus === true && this.articleContentStatus ? false :true
    }
  },
  data() {
    return {
      article: {
        title: '',
        content: '',
      },
      flashMessage: {
        type: '',
        content: '',
      },
      showDismissibleAlert: false
    }
  },
  created() {
    axios
      .get('/api/v1/articles/' + this.$route.params.id)
      .then(response => {
        this.article.title = response.data.article.title
        this.article.content = response.data.article.content
      })
  },
  methods: {
    updateArticle() {
      axios
        .put(
          '/api/v1/articles/' + this.$route.params.id,
          {
            article: {
              title: this.article.title,
              content: this.article.content,
            },
            authenticity_token: document.getElementsByName('csrf-token')[0].content,
          },
        )
        .then(response => {
          this.flashMessage.type = 'success'
          this.flashMessage.content = '編集しました'
        })
        .catch(error => {
          console.log(error.response.data)
          this.flashMessage.type = 'danger'
          this.flashMessage.content = 'エラーがあります'
        })
        .finally(() => {
          this.$emit("createFlashMessage", this.flashMessage)
          if (this.flashMessage.type === 'success') {
            this.$router.push('/articles/' + this.$route.params.id)
          }
        })
    }
  }
}
</script>