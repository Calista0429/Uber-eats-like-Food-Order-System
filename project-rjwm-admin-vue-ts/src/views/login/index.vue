<template>
  <div class="wm-login-page">
    <div class="login-card">
      <div class="login-logo">
        <div class="login-logo-icon">🍜</div>
        <div class="login-logo-text">Sky Takeout</div>
        <div class="login-logo-sub">Admin Console</div>
      </div>
      <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
        <el-form-item prop="username">
          <el-input
            v-model="loginForm.username"
            type="text"
            auto-complete="off"
            placeholder="Username"
            prefix-icon="iconfont icon-user"
          />
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            type="password"
            placeholder="Password"
            prefix-icon="iconfont icon-lock"
            @keyup.enter.native="handleLogin"
          />
        </el-form-item>
        <el-form-item style="width: 100%; margin-bottom: 0">
          <el-button
            :loading="loading"
            class="login-submit-btn"
            type="primary"
            style="width: 100%"
            @click.native.prevent="handleLogin"
          >
            <span v-if="!loading">Sign In</span>
            <span v-else>Signing in...</span>
          </el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Watch } from 'vue-property-decorator'
import { Route } from 'vue-router'
import { Form as ElForm, Input } from 'element-ui'
import { UserModule } from '@/store/modules/user'
import { isValidUsername } from '@/utils/validate'

@Component({
  name: 'Login',
})
export default class extends Vue {
  private validateUsername = (rule: any, value: string, callback: Function) => {
    if (!value) {
      callback(new Error('Please enter your username'))
    } else {
      callback()
    }
  }
  private validatePassword = (rule: any, value: string, callback: Function) => {
    if (value.length < 6) {
      callback(new Error('Password must be at least 6 characters'))
    } else {
      callback()
    }
  }
  private loginForm = {
    username: 'admin',
    password: '123456',
  } as {
    username: String
    password: String
  }

  loginRules = {
    username: [{ validator: this.validateUsername, trigger: 'blur' }],
    password: [{ validator: this.validatePassword, trigger: 'blur' }],
  }
  private loading = false
  private redirect?: string

  @Watch('$route', { immediate: true })
  private onRouteChange(route: Route) {}

  // Login
  private handleLogin() {
    ;(this.$refs.loginForm as ElForm).validate(async (valid: boolean) => {
      if (valid) {
        this.loading = true
        await UserModule.Login(this.loginForm as any)
          .then((res: any) => {
            if (String(res.code) === '1') {
              this.$router.push('/')
            } else {
              // this.$message.error(res.msg)
              this.loading = false
            }
          })
          .catch(() => {
            // this.$message.error('Username or password incorrect!')
            this.loading = false
          })
      } else {
        return false
      }
    })
  }
}
</script>

<style lang="scss" scoped>
.wm-login-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #2c1a0e 0%, #431407 50%, #6b2d0f 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px;
}
.login-card {
  background: #fff;
  border-radius: 20px;
  padding: 40px;
  width: 100%;
  max-width: 400px;
  box-shadow: 0 24px 64px rgba(0, 0, 0, 0.3);
}
.login-logo {
  text-align: center;
  margin-bottom: 32px;
}
.login-logo-icon { font-size: 48px; line-height: 1; margin-bottom: 10px; }
.login-logo-text { font-size: 22px; font-weight: 700; color: #2c1a0e; line-height: 1.2; }
.login-logo-sub  { font-size: 12px; color: #9a7c68; text-transform: uppercase; letter-spacing: 1px; margin-top: 2px; }
.login-form { .el-form-item { margin-bottom: 16px; } }
.login-submit-btn {
  height: 44px !important;
  font-size: 15px !important;
  font-weight: 600 !important;
  border-radius: 10px !important;
  box-shadow: 0 6px 16px rgba(249, 115, 22, 0.35) !important;
}
</style>
