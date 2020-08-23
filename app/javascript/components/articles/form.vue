<template>
  <div>
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
      @click="sendData"
      :disabled="submitStatus"
      block
      class="mt-3"
    >送信</b-button>

    <b-button class="mt-3" block to='/'>戻る</b-button>
  </div>
</template>

<script>
export default {
  props: {
    article: {
      type: Object,
      required: true,
    },
  },
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
  methods: {
    sendData() {
      this.$emit('send-data')
    }
  }
}
</script>