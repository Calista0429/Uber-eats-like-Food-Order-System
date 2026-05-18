<template>
  <div class="wm-sidebar">
    <!-- Logo -->
    <div class="sidebar-logo">
      <div class="logo-icon">🍜</div>
      <div v-if="!isCollapse" class="logo-text-wrap">
        <div class="logo-name">Sky Takeout</div>
        <div class="logo-sub">ADMIN CONSOLE</div>
      </div>
    </div>

    <!-- Navigation -->
    <nav class="sidebar-nav">
      <div class="nav-section">
        <div v-if="!isCollapse" class="nav-section-label">Main</div>
        <router-link to="/dashboard" class="nav-item" active-class="nav-item--active" exact>
          <svg class="nav-icon" viewBox="0 0 16 16" fill="currentColor"><rect x="1" y="1" width="6" height="6" rx="1"/><rect x="9" y="1" width="6" height="6" rx="1"/><rect x="1" y="9" width="6" height="6" rx="1"/><rect x="9" y="9" width="6" height="6" rx="1"/></svg>
          <span v-if="!isCollapse">Dashboard</span>
        </router-link>
        <router-link to="/order" class="nav-item" active-class="nav-item--active">
          <svg class="nav-icon" viewBox="0 0 16 16" fill="currentColor"><path d="M2 3a1 1 0 011-1h10a1 1 0 011 1v1H2V3zm0 3h12v7a1 1 0 01-1 1H3a1 1 0 01-1-1V6z"/></svg>
          <span v-if="!isCollapse">Orders</span>
          <span v-if="!isCollapse && $store.state.app.statusNumber > 0" class="nav-badge">{{ $store.state.app.statusNumber > 99 ? '99+' : $store.state.app.statusNumber }}</span>
        </router-link>
        <router-link to="/statistics" class="nav-item" active-class="nav-item--active">
          <svg class="nav-icon" viewBox="0 0 16 16" fill="currentColor"><path d="M1 11l3-4 3 2 3-5 3 3v4H1z"/></svg>
          <span v-if="!isCollapse">Statistics</span>
        </router-link>
      </div>

      <div class="nav-section">
        <div v-if="!isCollapse" class="nav-section-label">Menu</div>
        <router-link to="/category" class="nav-item" active-class="nav-item--active">
          <svg class="nav-icon" viewBox="0 0 16 16" fill="currentColor"><path d="M1 3h14v2H1zM1 7h14v2H1zM1 11h14v2H1z"/></svg>
          <span v-if="!isCollapse">Categories</span>
        </router-link>
        <router-link to="/dish" class="nav-item" active-class="nav-item--active">
          <svg class="nav-icon" viewBox="0 0 16 16" fill="currentColor"><circle cx="8" cy="8" r="6" stroke="currentColor" stroke-width="1.5" fill="none"/><circle cx="8" cy="8" r="2"/></svg>
          <span v-if="!isCollapse">Dishes</span>
        </router-link>
        <router-link to="/setmeal" class="nav-item" active-class="nav-item--active">
          <svg class="nav-icon" viewBox="0 0 16 16" fill="currentColor"><rect x="2" y="4" width="12" height="8" rx="1"/><path d="M5 4V3a1 1 0 011-1h4a1 1 0 011 1v1"/></svg>
          <span v-if="!isCollapse">Combos</span>
        </router-link>
      </div>

      <div class="nav-section">
        <div v-if="!isCollapse" class="nav-section-label">Staff</div>
        <router-link to="/employee" class="nav-item" active-class="nav-item--active">
          <svg class="nav-icon" viewBox="0 0 16 16" fill="currentColor"><circle cx="8" cy="5" r="3"/><path d="M2 13c0-3.314 2.686-5 6-5s6 1.686 6 5" stroke="currentColor" stroke-width="1" fill="none"/></svg>
          <span v-if="!isCollapse">Employees</span>
        </router-link>
        <router-link to="/inform" class="nav-item" active-class="nav-item--active">
          <svg class="nav-icon" viewBox="0 0 16 16" fill="currentColor"><path d="M8 1a5 5 0 00-5 5v3l-1.5 2H14.5L13 9V6a5 5 0 00-5-5zm0 14a2 2 0 01-2-2h4a2 2 0 01-2 2z"/></svg>
          <span v-if="!isCollapse">Notifications</span>
          <span v-if="!isCollapse && $store.state.app.statusNumber > 0" class="nav-badge">{{ $store.state.app.statusNumber > 99 ? '99+' : $store.state.app.statusNumber }}</span>
        </router-link>
      </div>
    </nav>

    <!-- Business Status Footer -->
    <div v-if="!isCollapse" class="sidebar-footer">
      <div class="status-pill" :class="businessStatus === 1 ? 'status-open' : 'status-closed'">
        <span class="status-dot" />
        <div>
          <div class="status-label">{{ businessStatus === 1 ? 'Open for Orders' : 'Closed' }}</div>
          <div class="status-sub">Restaurant status</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import { AppModule } from '@/store/modules/app'
import { UserModule } from '@/store/modules/user'
import variables from '@/styles/_variables.scss'
import { getSidebarStatus, setSidebarStatus } from '@/utils/cookies'
import Cookies from 'js-cookie'
import { getStatus } from '@/api/users'

@Component({
  name: 'SideBar',
  components: {}
})
export default class extends Vue {
  private restKey: number = 0
  private businessStatus = 1

  async fetchStatus() {
    try {
      const { data } = await getStatus()
      this.businessStatus = data.data
    } catch (e) {
      // silently fail — status footer is non-critical
    }
  }

  mounted() {
    this.fetchStatus()
  }

  get name() {
    return (UserModule.userInfo as any).name
      ? (UserModule.userInfo as any).name
      : JSON.parse(Cookies.get('user_info') as any).name
  }
  get defOpen() {
    let path = ['/']
    this.routes.forEach((n: any, i: number) => {
      if (n.meta.roles && n.meta.roles[0] === this.roles[0]) {
        path.splice(0, 1, n.path)
      }
    })
    return path
  }

  get defAct() {
    let path = this.$route.path
    return path
  }

  get sidebar() {
    return AppModule.sidebar
  }

  get roles() {
    return UserModule.roles
  }

  get routes() {
    let routes = JSON.parse(
      JSON.stringify([...(this.$router as any).options.routes])
    )
    console.log('-=-=routes=-=-=', routes)
    console.log('-=-=routes=-=-=', this.roles[0])
    let menuList = []
    let menu = routes.find(item => item.path === '/')
    if (menu) {
      menuList = menu.children
    }
    console.log('-=-=routes=-wwww=-=', routes)
    return menuList
  }

  get variables() {
    return variables
  }

  get isCollapse() {
    return !this.sidebar.opened
  }

  private async logout() {
    this.$store.dispatch('LogOut').then(() => {
      this.$router.replace({ path: '/login' })
    })
  }
}
</script>

<style lang="scss" scoped>
.wm-sidebar {
  width: 100%;
  height: 100%;
  background: #2c1a0e;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.sidebar-logo {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 18px 16px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.07);
  flex-shrink: 0;
}
.logo-icon {
  width: 36px;
  height: 36px;
  background: #f97316;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  flex-shrink: 0;
}
.logo-name { color: #fff; font-size: 14px; font-weight: 700; line-height: 1.2; }
.logo-sub  { color: rgba(255, 255, 255, 0.35); font-size: 9px; letter-spacing: 1px; }

.sidebar-nav { flex: 1; overflow-y: auto; padding: 12px 10px 0; }
.sidebar-nav::-webkit-scrollbar { width: 0; }

.nav-section { margin-bottom: 8px; }
.nav-section-label {
  color: rgba(255, 255, 255, 0.3);
  font-size: 9px;
  font-weight: 700;
  letter-spacing: 1.2px;
  text-transform: uppercase;
  padding: 0 8px 6px;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 9px 12px;
  border-radius: 8px;
  margin-bottom: 2px;
  color: rgba(255, 255, 255, 0.5);
  font-size: 13px;
  font-weight: 500;
  text-decoration: none;
  transition: background 0.15s, color 0.15s;
  cursor: pointer;

  &:hover {
    background: rgba(255, 255, 255, 0.06);
    color: rgba(255, 255, 255, 0.85);
  }
}
.nav-item--active {
  background: #f97316 !important;
  color: #fff !important;
  font-weight: 600;
  box-shadow: 0 4px 12px rgba(249, 115, 22, 0.35);
}
.nav-icon { width: 16px; height: 16px; flex-shrink: 0; }
.nav-badge {
  margin-left: auto;
  background: #ef4444;
  color: #fff;
  font-size: 10px;
  font-weight: 700;
  padding: 1px 6px;
  border-radius: 20px;
}

.sidebar-footer {
  flex-shrink: 0;
  padding: 12px 10px 16px;
  border-top: 1px solid rgba(255, 255, 255, 0.07);
}
.status-pill {
  display: flex;
  align-items: center;
  gap: 8px;
  border-radius: 8px;
  padding: 8px 12px;
  border: 1px solid transparent;
}
.status-open  {
  background: rgba(34, 197, 94, 0.12);
  border-color: rgba(34, 197, 94, 0.25);
  .status-label { color: #22c55e; }
}
.status-closed {
  background: rgba(239, 68, 68, 0.12);
  border-color: rgba(239, 68, 68, 0.25);
  .status-label { color: #ef4444; }
}
.status-dot {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  flex-shrink: 0;
}
.status-open .status-dot { background: #22c55e; animation: pulse 2s infinite; }
.status-closed .status-dot { background: #ef4444; }
@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }
.status-label { font-size: 12px; font-weight: 600; }
.status-sub   { color: rgba(255, 255, 255, 0.3); font-size: 10px; }
</style>
