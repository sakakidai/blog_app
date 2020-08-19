<template>
  <div>
    <Navbar></Navbar>
    <b-container fluid = "sm" class="bv-example-row">
      <b-row>
        <b-col md="9">
          <router-view></router-view>
        </b-col>
        <b-col md="3">col-4</b-col>
      </b-row>
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
