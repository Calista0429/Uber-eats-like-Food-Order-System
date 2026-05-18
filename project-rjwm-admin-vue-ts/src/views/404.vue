<template>
  <div class="wm-404">
    <div class="error-card">
      <div class="error-code">404</div>
      <div class="error-title">Page Not Found</div>
      <p class="error-desc">The page you're looking for doesn't exist or has been moved.</p>
      <el-button type="primary" @click="$router.push('/dashboard')">Back to Dashboard</el-button>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component({
    'name': 'Page404'
})
export default class extends Vue {
  private message = '404 Page Not Found'
}
</script>

<style lang="scss" scoped>
.wm-404 {
  min-height: 100vh;
  background: #f5f0eb;
  display: flex;
  align-items: center;
  justify-content: center;
}
.error-card {
  text-align: center;
  background: #fff;
  border-radius: 20px;
  padding: 48px 40px;
  border: 1px solid #f0e8e0;
  box-shadow: 0 4px 24px rgba(44, 26, 14, 0.08);
}
.error-code  { font-size: 80px; font-weight: 700; color: #f97316; line-height: 1; margin-bottom: 12px; }
.error-title { font-size: 22px; font-weight: 700; color: #2c1a0e; margin-bottom: 8px; }
.error-desc  { color: #9a7c68; font-size: 14px; margin-bottom: 24px; }
</style>
