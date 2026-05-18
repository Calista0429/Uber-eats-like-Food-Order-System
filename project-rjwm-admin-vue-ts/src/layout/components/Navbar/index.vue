<template>
  <div class="wm-navbar">
    <!-- Left: Hamburger + Breadcrumb -->
    <div class="navbar-left">
      <hamburger
        id="hamburger-container"
        :is-active="sidebar.opened"
        class="hamburger-btn"
        @toggleClick="toggleSideBar"
      />
      <div class="breadcrumb">
        <span class="breadcrumb-home">Home</span>
        <span class="breadcrumb-sep">›</span>
        <span class="breadcrumb-current">{{ $route.meta && $route.meta.title ? $route.meta.title : 'Dashboard' }}</span>
      </div>
    </div>

    <!-- Right: Status + Notif + User -->
    <div class="navbar-right">
      <!-- Operating status toggle -->
      <div class="status-toggle" @click="handleStatus">
        <span class="status-indicator" :class="status === 1 ? 'is-open' : 'is-closed'" />
        <span class="status-text">{{ status === 1 ? 'Open' : 'Closed' }}</span>
      </div>

      <!-- Notifications -->
      <router-link to="/inform" class="notif-btn">
        <svg width="18" height="18" viewBox="0 0 16 16" fill="currentColor"><path d="M8 1a5 5 0 00-5 5v3l-1.5 2H14.5L13 9V6a5 5 0 00-5-5zm0 14a2 2 0 01-2-2h4a2 2 0 01-2 2z"/></svg>
        <span v-if="$store.state.app.statusNumber > 0" class="notif-count">{{ $store.state.app.statusNumber > 99 ? '99+' : $store.state.app.statusNumber }}</span>
      </router-link>

      <!-- User menu -->
      <div
        class="user-chip"
        :class="{ 'is-open': shopShow }"
        @mouseenter="toggleShow"
        @mouseleave="mouseLeaves"
      >
        <div class="user-avatar">{{ name ? name.charAt(0).toUpperCase() : 'A' }}</div>
        <span class="user-name">{{ name }}</span>
        <svg class="chevron" :class="{ rotated: shopShow }" width="12" height="12" viewBox="0 0 12 12" fill="currentColor"><path d="M2 4l4 4 4-4"/></svg>

        <div v-if="shopShow" class="user-dropdown">
          <div class="dropdown-item" @click="handlePwd">
            <svg width="14" height="14" viewBox="0 0 16 16" fill="currentColor"><path d="M8 1a4 4 0 014 4v1h1a1 1 0 011 1v7a1 1 0 01-1 1H3a1 1 0 01-1-1V7a1 1 0 011-1h1V5a4 4 0 014-4zm0 2a2 2 0 00-2 2v1h4V5a2 2 0 00-2-2z"/></svg>
            Change Password
          </div>
          <div class="dropdown-item dropdown-item--danger" @click="logout">
            <svg width="14" height="14" viewBox="0 0 16 16" fill="currentColor"><path d="M6 2H3a1 1 0 00-1 1v10a1 1 0 001 1h3M10 11l3-3-3-3M13 8H6"/></svg>
            Sign Out
          </div>
        </div>
      </div>
    </div>

    <!-- Audio elements (keep for websocket notifications) -->
    <audio ref="audioVo" hidden>
      <source src="./../../../assets/preview.mp3" type="audio/mp3" />
    </audio>
    <audio ref="audioVo2" hidden>
      <source src="./../../../assets/reminder.mp3" type="audio/mp3" />
    </audio>

    <!-- Operating Status Dialog -->
    <el-dialog
      title="Operating Status"
      :visible.sync="dialogVisible"
      width="420px"
      :show-close="false"
    >
      <el-radio-group v-model="setStatus">
        <el-radio :label="1">
          Open for Orders
          <span>Restaurant is open. Accepting all orders automatically. Click to switch to Closed.</span>
        </el-radio>
        <el-radio :label="0">
          Closed
          <span>Restaurant is closed. Only accepting pre-orders during business hours. Click Open to resume.</span>
        </el-radio>
      </el-radio-group>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">Cancel</el-button>
        <el-button type="primary" @click="handleSave">Save</el-button>
      </span>
    </el-dialog>

    <!-- Change Password dialog -->
    <Password :dialog-form-visible="dialogFormVisible" @handleclose="handlePwdClose" />
  </div>
</template>

<script lang="ts">
import { Component, Vue, Watch } from 'vue-property-decorator'
import { AppModule } from '@/store/modules/app'
import { UserModule } from '@/store/modules/user'
import Breadcrumb from '@/components/Breadcrumb/index.vue'
import Hamburger from '@/components/Hamburger/index.vue'
import { getStatus, setStatus } from '@/api/users'
import Cookies from 'js-cookie'
import { debounce, throttle } from '@/utils/common'
import { setNewData, getNewData } from '@/utils/cookies'

// 接口
import { getCountUnread } from '@/api/inform'
// 修改密码弹层
import Password from '../components/password.vue'

@Component({
  name: 'Navbar',
  components: {
    Breadcrumb,
    Hamburger,
    Password,
  },
})
export default class extends Vue {
  private storeId = this.getStoreId
  private restKey: number = 0
  private websocket = null
  private newOrder = ''
  private message = ''
  private audioIsPlaying = false
  private audioPaused = false
  private statusValue = true
  private audioUrl: './../../../assets/preview.mp3'
  private shopShow = false
  private dialogVisible = false
  private status = 1
  private setStatus = 1
  private dialogFormVisible = false
  private ountUnread = 0
  // get ountUnread() {
  //   return Number(getNewData())
  // }
  get sidebar() {
    return AppModule.sidebar
  }

  get device() {
    return AppModule.device.toString()
  }

  getuserInfo() {
    return UserModule.userInfo
  }

  get name() {
    return (UserModule.userInfo as any).name
      ? (UserModule.userInfo as any).name
      : JSON.parse(Cookies.get('user_info') as any).name
  }

  get getStoreId() {
    let storeId = ''
    if (UserModule.storeId) {
      storeId = UserModule.storeId
    } else if ((UserModule.userInfo as any).stores != null) {
      storeId = (UserModule.userInfo as any).stores[0].storeId
    }
    return storeId
  }
  mounted() {
    document.addEventListener('click', this.handleClose)
    //console.log(this.$store.state.app.statusNumber)
    // const msg = {
    //   data: {
    //     type: 2,
    //     content: '订单1653904906519客户催单，已下单23分钟，仍未接单。',
    //     details: '434'
    //   }
    // }
    this.getStatus()
  }
  created() {
    this.webSocket()
  }
  onload() {
  }
  destroyed() {
    this.websocket.close() //离开路由之后断开websocket连接
  }

  // 添加新订单提示弹窗
  webSocket() {
    const that = this as any
    let clientId = Math.random().toString(36).substr(2)
    let socketUrl = process.env.VUE_APP_SOCKET_URL + clientId
    console.log(socketUrl, 'socketUrl')
    if (typeof WebSocket == 'undefined') {
      that.$notify({
        title: '提示',
        message: '当前浏览器无法接收实时报警信息，请使用谷歌浏览器！',
        type: 'warning',
        duration: 0,
      })
    } else {
      this.websocket = new WebSocket(socketUrl)
      // 监听socket打开
      this.websocket.onopen = function () {
        console.log('浏览器WebSocket已打开')
      }
      // 监听socket消息接收
      this.websocket.onmessage = function (msg) {
        // 转换为json对象
        that.$refs.audioVo.currentTime = 0
        that.$refs.audioVo2.currentTime = 0

        console.log(msg, JSON.parse(msg.data), 'msg')
        // const h = this.$createElement
        const jsonMsg = JSON.parse(msg.data)
        if (jsonMsg.type === 1) {
          that.$refs.audioVo.play()
        } else if (jsonMsg.type === 2) {
          that.$refs.audioVo2.play()
        }
        that.$notify({
          title: jsonMsg.type === 1 ? '待接单' : '催单',
          duration: 0,
          dangerouslyUseHTMLString: true,
          onClick: () => {
            that.$router
              .push(`/order?orderId=${jsonMsg.orderId}`)
              .catch((err) => {
                console.log(err)
              })
            setTimeout(() => {
              location.reload()
            }, 100)
          },
          // 这里也可以把返回信息加入到message中显示
          message: `${
            jsonMsg.type === 1
              ? `<span>您有1个<span style=color:#419EFF>订单待处理</span>,${jsonMsg.content},请及时接单</span>`
              : `${jsonMsg.content}<span style='color:#419EFF;cursor: pointer'>去处理</span>`
          }`,
        })
      }
      // 监听socket错误
      this.websocket.onerror = function () {
        that.$notify({
          title: '错误',
          message: '服务器错误，无法接收实时报警信息',
          type: 'error',
          duration: 0,
        })
      }
      // 监听socket关闭
      this.websocket.onclose = function () {
        console.log('WebSocket已关闭')
      }
    }
  }

  private toggleSideBar() {
    AppModule.ToggleSideBar(false)
  }
  // 退出
  private async logout() {
    this.$store.dispatch('LogOut').then(() => {
      // location.href = '/'
      this.$router.replace({ path: '/login' })
    })
    // this.$router.push(`/login?redirect=${this.$route.fullPath}`)
  }
  // 获取未读消息
  async getCountUnread() {
    const { data } = await getCountUnread()
    if (data.code === 1) {
      // this.ountUnread = data.data
      AppModule.StatusNumber(data.data)
      // setNewData(data.data)
      // this.$message.success('操作成功！')
    } else {
      this.$message.error(data.msg)
    }
  }
  // 营业状态
  async getStatus() {
    const { data } = await getStatus()
    this.status = data.data
    this.setStatus = this.status
  }
  // 下拉菜单显示
  toggleShow() {
    this.shopShow = true
  }
  // 下拉菜单隐藏
  mouseLeaves() {
    this.shopShow = false
  }
  // 触发空白处下来菜单关闭
  handleClose() {
    // clearTimeout(this.leave)
    // this.shopShow = false
  }
  // 设置营业状态
  handleStatus() {
    this.dialogVisible = true
  }
  // 营业状态设置
  async handleSave() {
    const { data } = await setStatus(this.setStatus)
    if (data.code === 1) {
      this.dialogVisible = false
      this.getStatus()
    }
  }
  // 修改密码
  handlePwd() {
    this.dialogFormVisible = true
  }
  // 关闭密码编辑弹层
  handlePwdClose() {
    this.dialogFormVisible = false
  }
}
</script>

<style lang="scss" scoped>
.wm-navbar {
  height: 56px;
  background: #fff;
  border-bottom: 1px solid #f0e8e0;
  box-shadow: 0 1px 4px rgba(44, 26, 14, 0.06);
  display: flex;
  align-items: center;
  padding: 0 20px 0 0;
  position: relative;
}

.navbar-left {
  display: flex;
  align-items: center;
  gap: 4px;
  flex: 1;
}
.hamburger-btn { padding: 0 12px; cursor: pointer; }

.breadcrumb {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
}
.breadcrumb-home    { color: #9a7c68; }
.breadcrumb-sep     { color: #d5c4b8; }
.breadcrumb-current { color: #2c1a0e; font-weight: 600; }

.navbar-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.status-toggle {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 5px 12px;
  border-radius: 20px;
  border: 1px solid #e8d5c4;
  background: #fef3e8;
  cursor: pointer;
  font-size: 12px;
  font-weight: 600;
  color: #6b4c3b;
  transition: border-color 0.15s;
  &:hover { border-color: #f97316; }
}
.status-indicator {
  width: 7px; height: 7px; border-radius: 50%; flex-shrink: 0;
  &.is-open  { background: #22c55e; animation: pulse 2s infinite; }
  &.is-closed { background: #ef4444; }
}
@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }
.status-text { color: #2c1a0e; }

.notif-btn {
  width: 36px; height: 36px; border-radius: 50%;
  background: #fef3e8; border: 1px solid #fed7aa;
  display: flex; align-items: center; justify-content: center;
  color: #9a7c68; text-decoration: none; position: relative;
  &:hover { border-color: #f97316; color: #f97316; }
}
.notif-count {
  position: absolute; top: -3px; right: -3px;
  background: #ef4444; color: #fff;
  font-size: 9px; font-weight: 700;
  min-width: 16px; height: 16px; border-radius: 20px;
  display: flex; align-items: center; justify-content: center;
  padding: 0 3px;
}

.user-chip {
  display: flex; align-items: center; gap: 8px;
  background: #fef3e8; border: 1px solid #fed7aa;
  border-radius: 20px; padding: 4px 12px 4px 4px;
  cursor: pointer; position: relative;
  transition: border-color 0.15s;
  &:hover, &.is-open { border-color: #f97316; }
}
.user-avatar {
  width: 28px; height: 28px; border-radius: 50%;
  background: #f97316; color: #fff;
  display: flex; align-items: center; justify-content: center;
  font-size: 12px; font-weight: 700; flex-shrink: 0;
}
.user-name { color: #2c1a0e; font-size: 13px; font-weight: 600; white-space: nowrap; }
.chevron { color: #9a7c68; transition: transform 0.2s; &.rotated { transform: rotate(180deg); } }

.user-dropdown {
  position: absolute; top: calc(100% + 6px); right: 0;
  background: #fff; border: 1px solid #f0e8e0;
  border-radius: 10px; box-shadow: 0 8px 24px rgba(44, 26, 14, 0.12);
  min-width: 160px; overflow: hidden; z-index: 999;
}
.dropdown-item {
  display: flex; align-items: center; gap: 8px;
  padding: 10px 16px; font-size: 13px; color: #2c1a0e;
  cursor: pointer; transition: background 0.1s;
  &:hover { background: #fef3e8; }
  &--danger { color: #ef4444; &:hover { background: #fff5f5; } }
}
</style>
<style lang="scss">
.el-notification {
  // background: rgba(255, 255, 255, 0.71);
  width: 419px !important;
  .el-notification__title {
    margin-bottom: 14px;
    color: #333;
    .el-notification__content {
      color: #333;
    }
  }
}
.navbar {
  .el-dialog {
    min-width: auto !important;
  }
  .el-dialog__header {
    height: 61px;
    line-height: 60px;
    background: #fbfbfa;
    padding: 0 30px;
    font-size: 16px;
    color: #333;
    border: 0 none;
  }
  .el-dialog__body {
    padding: 10px 30px 30px;
    .el-radio,
    .el-radio__input {
      white-space: normal;
    }
    .el-radio__label {
      padding-left: 5px;
      color: #333;
      font-weight: 700;
      span {
        display: block;
        line-height: 20px;
        padding-top: 12px;
        color: #666;
        font-weight: normal;
      }
    }
    .el-radio__input.is-checked .el-radio__inner {
      &::after {
        background: #333;
      }
    }
    .el-radio-group {
      & > .is-checked {
        border: 1px solid #ffc200;
      }
    }
    .el-radio {
      width: 100%;
      background: #fbfbfa;
      border: 1px solid #e5e4e4;
      border-radius: 4px;
      padding: 14px 22px;
      margin-top: 20px;
    }
    .el-radio__input.is-checked + .el-radio__label {
      span {
      }
    }
  }
  .el-badge__content.is-fixed {
    top: 24px;
    right: 2px;
    width: 18px;
    height: 18px;
    font-size: 10px;
    line-height: 16px;
    font-size: 10px;
    border-radius: 50%;
    padding: 0;
  }
  .badgeW {
    .el-badge__content.is-fixed {
      width: 30px;
      border-radius: 20px;
    }
  }
}
.el-icon-arrow-down {
  background: url('./../../../assets/icons/up.png') no-repeat 50% 50%;
  background-size: contain;
  width: 8px;
  height: 8px;
  transform: rotate(0eg);
  margin-left: 16px;
  position: absolute;
  right: 16px;
  top: 12px;
  &:before {
    content: '';
  }
}

.userInfo {
  background: #fff;
  position: absolute;
  top: 0px;
  left: 0;
  z-index: 99;
  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.14);
  width: 100%;
  border-radius: 4px;
  line-height: 32px;
  padding: 0 0 5px;
  height: 105px;
  // .active {
  //   top: 0;
  //   left: 0;
  // }
  .userList {
    width: 95%;
    // // margin-top: -5px;
    // position: absolute;
    // top: 35px;
    padding-left: 5px;
  }
  p {
    cursor: pointer;
    height: 32px;
    line-height: 32px;
    padding: 0 5px 0 7px;
    i {
      margin-left: 10px;

      vertical-align: middle;
      margin-top: 4px;
      float: right;
    }
    &:hover {
      background: #f6f1e1;
    }
  }
}
.msgTip {
  color: #419eff;
  padding: 0 5px;
}
// .el-dropdown{
//   .el-button--primary{
//     height: 32px;
//     background: rgba(255,255,255,0.52);
//     border-radius: 4px;
//     padding-top: 0px;
//     padding-bottom: 0px;
//   }
//   margin-top: 2px;
// }
// .el-popper{
//   top: 45px !important;
//   padding-top: 50px !important;
//   border-radius: 0 0 4px 4px;
// }
// .el-popper[x-placement^=bottom] .popper__arrow::after,.popper__arrow{
//   display: none !important;
// }
</style>
