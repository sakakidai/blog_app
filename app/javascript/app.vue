<template>
  <div>
    <Navbar></Navbar>
    <b-container>
      <router-view></router-view>
    </b-container>
  </div>
</template>

<script>
import Navbar from './components/layouts/navbar.vue'

export default {
  components: {
    Navbar
  }
}
</script>
