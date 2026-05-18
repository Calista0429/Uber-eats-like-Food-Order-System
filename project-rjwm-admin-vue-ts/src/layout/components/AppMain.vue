<template>
  <section class="app-main">
    <transition
      name="fade-transform"
      mode="out-in"
    >
      <router-view />
    </transition>
  </section>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'

@Component({
  'name': 'AppMain'
})
export default class extends Vue {}
</script>

<style lang="scss" scoped>
.app-main {
  height: calc(100% - 56px);
  overflow-y: auto;
  padding: 24px;
  background: #f5f0eb;
  box-sizing: border-box;
}
</style>
