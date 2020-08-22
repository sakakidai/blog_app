<template>
  <div>
    <Navbar></Navbar>
    <b-container fluid = "sm" class="bv-example-row">
      <FlashMessage
        ref="child"
        :type="flashMessage.type"
        :content="flashMessage.content"
      ></FlashMessage>
      <b-row>
        <b-col md="9">
          <router-view @createFlashMessage="createFlashMessage"></router-view>
        </b-col>
        <b-col md="3">col-4</b-col>
      </b-row>
    </b-container>
  </div>

</template>

<script>
import Navbar from './components/layouts/navbar.vue'
import FlashMessage from './components/layouts/flash-message.vue'

export default {
  components: {
    Navbar,
    FlashMessage,
  },
  data() {
    return {
      flashMessage: {
        type: '',
        content: '',
      },
    }
  },
  methods: {
    createFlashMessage(response) {
      this.flashMessage.type    = response.type
      this.flashMessage.content = response.content
      this.$refs.child.showAlert()
    }
  }
}
</script>
