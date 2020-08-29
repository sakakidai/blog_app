<template>
  <div>
    <div class="overflow-auto">
      <b-pagination-nav
        v-model="page.current"
        :link-gen="linkGen"
        :number-of-pages="page.total"
        use-router
        @input="changePage"
      ></b-pagination-nav>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  props: {
    page: { type: Object },
    url: { type: String },
  },
  methods: {
    linkGen(pageNum) {
      return `${this.url}?page=${pageNum}`
    },
    changePage() {
      this.$emit("changePage")
    }
  }
}
</script>