<template>
  <div>
    <h3>トップコンテンツ</h3>
    <div class="thumbnail">
      <b-embed
        v-if="article.thumbnailType === 'youtube'"
        type="iframe"
        aspect="16by9"
        :src="youtubeBaseUrl + article.youtube.video_id"
        allowfullscreen
      ></b-embed>
      <b-card-img
        v-else-if="article.thumbnailType === 'image'"
        :src="article.thumbnail || article.thumbnailUrl || defoultImage"
        fluid
        alt="Thumbnail"
      ></b-card-img>
    </div>

    <b-form
      id="article-form"
      @submit.prevent="submit"
    >
      <b-form-group label="サムネイルのタイプ:">
        <b-form-radio-group
          @change="thumbnailFormChange"
          v-model="article.thumbnailType"
          :options="article.thumbnailTypeOptions"
          plain
          name="plain-inline"
        ></b-form-radio-group>
      </b-form-group>

      <b-form-group v-if="article.thumbnailType === 'youtube'">
        <label for="article_youtube_url">サムネイル(Youtube):</label>
        <b-form-input
          v-model.trim="article.youtube.video_id"
          type="text"
          id="article_youtube_url"
        ></b-form-input>
      </b-form-group>

      <b-form-group v-else-if="article.thumbnailType === 'image'">
        <label for="article_thumbnail">サムネイル(画像):</label>
        <b-form-file
          @change="uploadThumbnail"
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
        <div v-if="section._destroy === '1'">
          <div>セクション{{index + 1}}を削除します</div>
          <b-form-group>
            <b-button @click="unRemoveSectionForm(index)">
              削除の取消
            </b-button>
          </b-form-group>
        </div>
        <div v-else>
          <b-img
            v-show="section.photo || section.photo_url"
            class="preview-item-file"
            :src="section.photo || section.photo_url"
            fluid
            alt=""
          ></b-img>

          <b-form-group>
            <label :for="`sections_attributes_${index}_photo`">写真:</label>
            <b-form-file
              @change="uploadPhoto(index, $event)"
              :id="`sections_attributes_${index}_photo`"
            ></b-form-file>
          </b-form-group>

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

          <b-form-group>
            <b-button @click="removeSectionForm(index)">
              削除
            </b-button>
          </b-form-group>
        </div>
      </div>

      <b-button @click="addSectionForm">
        セクション追加
      </b-button>

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
    thumbnailFormChange(value) {
      if (value === 'image') {
        this.article.thumbnail = null
      } else if (value === 'youtube') {
        this.article.youtube.video_id = null
      }
    },
    uploadPhoto(index, e) {
      const file   = e.target.files[0]
      const reader = new FileReader()
      reader.onload = e => {
        this.article.sections[index].photo = e.target.result
        this.$set(this.article.sections, index, this.article.sections[index])
      };
      reader.readAsDataURL(file)
    },
    uploadThumbnail(e) {
      const file   = e.target.files[0]
      const reader = new FileReader()
      reader.onload = e => {
      this.article.thumbnail = e.target.result
      };
      reader.readAsDataURL(file)
    },
    addSectionForm() {
      this.$emit('addSectionForm')
    },
    removeSectionForm(index) {
      this.$emit('removeSectionForm', index)
    },
    unRemoveSectionForm(index) {
      this.$emit('unRemoveSectionForm', index)
    },
    submit() {
      this.$emit('submit')
    },
  },
}
</script>