<template>
  <div>
    <h3>トップコンテンツ</h3>
    <b-img
      v-show="article.thumbnail"
      class="preview-item-file"
      :src="article.thumbnail"
      fluid
      alt=""
    ></b-img>

    <b-form
      id="article-form"
      @submit.prevent="submit"
    >
      <b-form-group>
        <label for="article_thumbnail">サムネイル:</label>
        <b-form-file
          @change="uploadFile"
          id="article_thumbnail"
        ></b-form-file>
      </b-form-group>

      <b-form-group>
        <label for="article_title">タイトル:</label>
        <b-form-input
          v-model.trim="article.title"
          :state="articleTitleStatus"
          type="text"
          id="article_title"
        ></b-form-input>
        <b-form-invalid-feedback id="article_title_feedback">
          １〜30文字で入力してください。
        </b-form-invalid-feedback>
      </b-form-group>

      <b-form-group>
        <label for="article_description">内容:</label>
        <b-form-textarea
          v-model.trim="article.description"
          :state="articleDescriptionStatus"
          rows="5"
          max-rows="8"
          id="article_description"
        ></b-form-textarea>
        <b-form-invalid-feedback id="article_description_feedback">
          １文字以上入力してください。
        </b-form-invalid-feedback>
      </b-form-group>

      <div v-for="(section, index) in article.sections" :key="index">
        <h3>セクション{{ index + 1 }}</h3>
        <b-form-group>
          <label :for="`sections_attributes_${index}_title`">タイトル:</label>
          <b-form-input
            v-model.trim="section.title"
            type="text"
            :id="`sections_attributes_${index}_title`"
          ></b-form-input>
        </b-form-group>

        <b-form-group>
          <label :for="`sections_attributes_${index}_description`">内容:</label>
          <b-form-textarea
            v-model.trim="section.description"
            rows="5"
            max-rows="8"
            :id="`sections_attributes_${index}_description`"
          ></b-form-textarea>
        </b-form-group>
      </div>

      <b-button
        type="submit"
        :disabled="submitStatus"
        block
        class="mt-3"
      >送信</b-button>
    </b-form>

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
    articleDescriptionStatus() {
      return this.article.description.length > 0 ? true : false
    },
    submitStatus() {
      return this.articleTitleStatus === true && this.articleDescriptionStatus ? false :true
    }
  },
  methods: {
    uploadFile(e) {
      console.log('Upload')
      const file   = e.target.files[0]
      const reader = new FileReader()
      reader.onload = e => {
        this.article.thumbnail = e.target.result
      };
      reader.readAsDataURL(file)
    },
    submit() {
      this.$emit('submit')
    },
  },
}
</script>