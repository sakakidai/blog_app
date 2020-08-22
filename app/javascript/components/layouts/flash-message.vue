
<template>
  <div>
    <b-alert
      v-model="showDismissibleAlert"
      :variant="type"
      dismissible
    >{{ content }}</b-alert>
  </div>
</template>

<script>
export default {
  props: {
    type: String,
    content: String,
  },
  data() {
    return {
      showDismissibleAlert: false
    }
  },
  methods: {
    showAlert() {
      this.showDismissibleAlert = true
    }
  }
}
</script>
