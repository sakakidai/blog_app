
<template>
  <div>
    <b-alert
      v-model="showDismissibleAlert"
      :variant="flashMessage.type"
      dismissible
    >{{ flashMessage.content }}</b-alert>
  </div>
</template>

<script>
export default {
  props: {
    flashMessage: {
      type: Object
    },
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
