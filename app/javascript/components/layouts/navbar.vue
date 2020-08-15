<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="info">
      <b-navbar-brand href="#">NavBar</b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item href="/articles">記事一覧</b-nav-item>
        </b-navbar-nav>

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <b-nav-item>
            <b-button v-b-modal.new_article_modal size="sm">新規作成</b-button>

            <b-modal id="new_article_modal" title="新規作成" hide-footer>
              <label for="title">タイトル:</label>
              <input id="title" type="text" v-model="article.title">
              <br>
              <label for="content">内容</label>
              <textarea id="content" v-model="article.content"></textarea>
              <b-button class="mt-3" block @click="createArticle">送信</b-button>
              <b-button class="mt-3" block @click="$bvModal.hide('new_article_modal')">閉じる</b-button>
            </b-modal>
          </b-nav-item>

          <b-nav-form>
            <b-form-input size="sm" class="mr-sm-2" placeholder="Search"></b-form-input>
            <b-button size="sm" class="my-2 my-sm-0" type="submit">Search</b-button>
          </b-nav-form>

          <b-nav-item-dropdown text="Lang" right>
            <b-dropdown-item href="#">EN</b-dropdown-item>
            <b-dropdown-item href="#">ES</b-dropdown-item>
            <b-dropdown-item href="#">RU</b-dropdown-item>
            <b-dropdown-item href="#">FA</b-dropdown-item>
          </b-nav-item-dropdown>

          <b-nav-item-dropdown right>
            <!-- Using 'button-content' slot -->
            <template v-slot:button-content>
              <em>User</em>
            </template>
            <b-dropdown-item href="#">Profile</b-dropdown-item>
            <b-dropdown-item href="#">Sign Out</b-dropdown-item>
          </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      article: {
        title: '',
        content: '',
      }
    }
  },
  methods: {
    createArticle() {
      axios
        .post(
          '/api/v1/articles',
          {
            article: {
              title: this.article.title,
              content: this.article.content
            },
            authenticity_token: document.getElementsByName('csrf-token')[0].content,
          },
        )
        .then(response => {
          console.log(response)
        })
        .catch(error => {
          console.log(error)
        })

      this.title = ''
      this.content = ''
    }
  }
}
</script>