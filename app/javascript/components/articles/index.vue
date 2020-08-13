<template>
  <div>
    <p>記事一覧</p>
    <div>
      <div v-for="(article, key) in articles" :key="key">
        <p>{{article.title}}</p>
        <p>{{article.content}}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      articles: [
        {
          title: 'サンプル１',
          content: 'aaaaaaaaaaaaaaaaaaaaaaa',
          created_at: '2020-08-13',
          updated_at: '2020-08-14'
        },
        {
          title: 'サンプル2',
          content: 'bbbbbbbbbbbbbbbbbbbbbbbb',
          created_at: '2020-08-13',
          updated_at: '2020-08-14'
        },
        {
          title: 'サンプル3',
          content: 'cccccccccccccccccccccccc',
          created_at: '2020-08-13',
          updated_at: '2020-08-14'
        },
      ]
    }
  }
}
</script>