<template>
  <b-modal ref="error-500-modal" hide-footer title="エラー">
      <div class="d-block text-center">
        <div>APIサーバーに接続出来ません。</div>
        <div>管理者にご連絡お願いします。</div>
      </div>
      <b-button class="mt-3" variant="outline-danger" block @click="hideModal">閉じる</b-button>
    </b-modal>
</template>

<script>
export default {
  methods: {
    showModal() {
      this.$refs['error-500-modal'].show()
    },
    hideModal() {
      this.$refs['error-500-modal'].hide()
    },
  },
}
</script>