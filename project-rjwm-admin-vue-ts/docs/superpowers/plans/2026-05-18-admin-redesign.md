# Sky Takeout Admin — Full Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebuild the Sky Takeout admin frontend with a Warm Brand visual theme and translate all Chinese text to English, keeping all API/store/router/business-logic untouched.

**Architecture:** Replace the Element UI SCSS theme tokens and override component styles globally via a new `warm-theme.scss`. Rebuild the layout shell (Sidebar, Navbar, AppMain) templates from scratch while preserving all Vue script logic. Update each view's template and styles to use the new design system classes; never touch `<script>` sections except in the Sidebar where we add one API call for business status.

**Tech Stack:** Vue 2, TypeScript, Element UI 2.12, SCSS, Jest + @vue/test-utils, Axios

---

## File Map

### New files
| File | Purpose |
|---|---|
| `src/styles/warm-theme.scss` | Design system tokens + all Element UI SCSS overrides |
| `tests/unit/layout/sidebar.spec.ts` | Smoke test: Sidebar renders, English text |
| `tests/unit/layout/navbar.spec.ts` | Smoke test: Navbar renders, English text |

### Modified files
| File | Change |
|---|---|
| `src/styles/element-variables.scss` | Change primary color to `#f97316`, warm border tokens |
| `src/styles/index.scss` | Import `warm-theme.scss` at top |
| `src/layout/index.vue` | Update `main-container` background + sidebar width |
| `src/layout/components/Sidebar/index.vue` | New template + styles; add `fetchStatus()` method |
| `src/layout/components/Navbar/index.vue` | New template + styles; preserve all script logic |
| `src/layout/components/AppMain.vue` | Update background + padding |
| `src/views/login/index.vue` | New template + styles; preserve script |
| `src/views/dashboard/index.vue` | English component props + page wrapper style |
| `src/views/orderDetails/index.vue` | English labels + new filter bar + table styles |
| `src/views/category/index.vue` | English labels + new filter bar + table styles |
| `src/views/dish/index.vue` | English labels + new filter bar + table styles |
| `src/views/dish/addDishtype.vue` | English form labels; preserve script |
| `src/views/setmeal/index.vue` | English labels + new filter bar + table styles |
| `src/views/setmeal/addSetmeal.vue` | English form labels; preserve script |
| `src/views/employee/index.vue` | English labels + new filter bar + table styles |
| `src/views/employee/addEmployee.vue` | English form labels; preserve script |
| `src/views/statistics/index.vue` | English component props |
| `src/views/inform/index.vue` | English tab labels + notification text |
| `src/views/404.vue` | English error text |

### Unchanged (do not touch)
`src/api/`, `src/store/`, `src/router.ts`, `src/permission.ts`, `src/utils/`, all child components under `src/views/*/components/` except where noted below.

---

## Task 1: Design System — warm-theme.scss + element-variables.scss

**Files:**
- Create: `src/styles/warm-theme.scss`
- Modify: `src/styles/element-variables.scss`
- Modify: `src/styles/index.scss`

- [ ] **Step 1: Create warm-theme.scss**

```scss
// src/styles/warm-theme.scss
// ── Design Tokens ──────────────────────────────────────────
$brand-dark:         #2c1a0e;
$brand-mid:          #431407;
$brand-accent:       #f97316;
$brand-accent-light: #fef3e8;
$brand-amber:        #fbbf24;
$page-bg:            #f5f0eb;
$card-bg:            #ffffff;
$card-border:        #f0e8e0;
$table-header-bg:    #fdf8f4;
$text-primary:       #2c1a0e;
$text-secondary:     #9a7c68;
$text-muted:         #b8a090;
$input-border:       #e8d5c4;
$success-color:      #22c55e;
$danger-color:       #ef4444;
$info-color:         #3b82f6;

// ── Element UI Global Overrides ────────────────────────────
.el-button--primary {
  background-color: $brand-accent !important;
  border-color:     $brand-accent !important;
  border-radius:    8px !important;
  box-shadow:       0 4px 12px rgba(249, 115, 22, 0.3) !important;
  &:hover, &:focus {
    background-color: darken($brand-accent, 8%) !important;
    border-color:     darken($brand-accent, 8%) !important;
  }
}
.el-button--default {
  border-color:  $input-border !important;
  color:         #6b4c3b !important;
  border-radius: 8px !important;
  box-shadow:    none !important;
  &:hover { border-color: $brand-accent !important; color: $brand-accent !important; }
}
.el-button--danger {
  background-color: #fff5f5 !important;
  border-color:     #fecaca !important;
  color:            $danger-color !important;
  border-radius:    8px !important;
  box-shadow:       none !important;
}
.el-button--text { color: $brand-accent !important; }

.el-input__inner {
  border-color:  $input-border !important;
  border-radius: 8px !important;
  color:         $text-primary !important;
  &::placeholder { color: $text-muted; }
  &:focus {
    border-color: $brand-accent !important;
    box-shadow:   0 0 0 2px rgba(249, 115, 22, 0.15) !important;
  }
}
.el-select .el-input__inner { border-radius: 8px !important; }
.el-textarea__inner {
  border-color:  $input-border !important;
  border-radius: 8px !important;
  &:focus { border-color: $brand-accent !important; }
}

.el-table {
  color: $text-primary !important;
  th.el-table__cell {
    background:     $table-header-bg !important;
    color:          $text-secondary !important;
    font-size:      11px !important;
    font-weight:    700 !important;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    border-bottom:  1px solid $card-border !important;
  }
  tr:hover > td { background: #fffaf7 !important; }
  td.el-table__cell { border-bottom-color: #f9f3ee !important; }
}

.el-dialog {
  border-radius: 14px !important;
  overflow:      hidden;
}
.el-dialog__header {
  background:    $table-header-bg !important;
  border-bottom: 1px solid $card-border;
  padding:       16px 24px !important;
}
.el-dialog__title  { color: $text-primary !important; font-weight: 700 !important; }
.el-dialog__body   { padding: 24px !important; }
.el-dialog__footer { border-top: 1px solid $card-border !important; padding: 16px 24px !important; }

.el-pagination {
  .el-pager li          { border-radius: 6px !important; color: $text-secondary !important; }
  .el-pager li.active   { background: $brand-accent !important; color: #fff !important; border-color: $brand-accent !important; }
  button                { border-radius: 6px !important; }
}

.el-form-item__label { color: $text-secondary !important; font-weight: 600 !important; font-size: 12px !important; }

.el-tabs__item              { color: $text-secondary !important; }
.el-tabs__item.is-active    { color: $brand-accent !important; }
.el-tabs__active-bar        { background-color: $brand-accent !important; }

.el-radio__input.is-checked .el-radio__inner        { border-color: $brand-accent !important; background: $brand-accent !important; }
.el-radio__input.is-checked + .el-radio__label      { color: $brand-accent !important; }
.el-checkbox__input.is-checked .el-checkbox__inner  { border-color: $brand-accent !important; background: $brand-accent !important; }
.el-switch.is-checked .el-switch__core              { border-color: $brand-accent !important; background-color: $brand-accent !important; }
.el-badge__content                                  { background-color: $danger-color !important; }
.el-notification                                    { border-radius: 12px !important; border-color: $card-border !important; }

// ── Utility Classes ────────────────────────────────────────
.wm-card {
  background:  $card-bg;
  border-radius: 14px;
  border:      1px solid $card-border;
  box-shadow:  0 2px 8px rgba(44, 26, 14, 0.05);
}

.wm-filter-bar {
  background:    $card-bg;
  border-radius: 12px;
  padding:       16px 20px;
  border:        1px solid $card-border;
  margin-bottom: 16px;
  display:       flex;
  align-items:   center;
  gap:           12px;
  flex-wrap:     wrap;
  box-shadow:    0 1px 4px rgba(44, 26, 14, 0.04);

  .filter-label {
    color:          $text-secondary;
    font-size:      12px;
    font-weight:    600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    white-space:    nowrap;
  }
  .filter-actions { margin-left: auto; display: flex; gap: 8px; }
}

.wm-table-card {
  @extend .wm-card;
  overflow: hidden;
  margin-top: 0;

  .table-toolbar {
    display:       flex;
    align-items:   center;
    gap:           10px;
    padding:       14px 20px;
    border-bottom: 1px solid $card-border;
    background:    $table-header-bg;
  }
  .toolbar-right { margin-left: auto; display: flex; gap: 8px; }
  .selected-info { color: $text-secondary; font-size: 13px; }
}

.wm-page-header {
  display:         flex;
  align-items:     center;
  justify-content: space-between;
  margin-bottom:   16px;
}
.wm-page-title { color: $text-primary; font-size: 20px; font-weight: 700; }

.wm-badge {
  display:     inline-flex;
  align-items: center;
  gap:         4px;
  font-size:   11px;
  font-weight: 600;
  padding:     4px 10px;
  border-radius: 20px;
  .badge-dot { width: 5px; height: 5px; border-radius: 50%; background: currentColor; flex-shrink: 0; }
  &.badge-green  { background: #f0fdf4; color: #16a34a; }
  &.badge-gray   { background: #f5f5f5; color: $text-secondary; }
  &.badge-orange { background: #fff7ed; color: #ea580c; }
  &.badge-blue   { background: #eff6ff; color: $info-color; }
}

.wm-action-edit   { font-size: 12px; font-weight: 600; padding: 4px 8px; border-radius: 6px; color: $info-color;   background: #eff6ff; cursor: pointer; }
.wm-action-toggle { font-size: 12px; font-weight: 600; padding: 4px 8px; border-radius: 6px; color: #ea580c;       background: #fff7ed; cursor: pointer; }
.wm-action-enable { font-size: 12px; font-weight: 600; padding: 4px 8px; border-radius: 6px; color: $success-color; background: #f0fdf4; cursor: pointer; }
.wm-action-delete { font-size: 12px; font-weight: 600; padding: 4px 8px; border-radius: 6px; color: $danger-color; background: #fff5f5; cursor: pointer; }

.wm-pagination-wrap {
  display:         flex;
  align-items:     center;
  justify-content: flex-end;
  padding:         14px 20px;
  border-top:      1px solid $card-border;
  background:      $table-header-bg;
  border-radius:   0 0 14px 14px;
}

// ── Dashboard Cards ────────────────────────────────────────
.wm-stat-card {
  @extend .wm-card;
  padding: 20px;
  .stat-icon {
    width: 40px; height: 40px; border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 20px; margin-bottom: 12px;
  }
  .stat-label { color: $text-secondary; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 4px; }
  .stat-value { color: $text-primary; font-size: 28px; font-weight: 700; line-height: 1; margin-bottom: 6px; }
  .stat-delta { font-size: 12px; font-weight: 600; }
  .stat-delta.up   { color: $success-color; }
  .stat-delta.down { color: $danger-color; }
}
```

- [ ] **Step 2: Update element-variables.scss**

Replace the content of `src/styles/element-variables.scss`:

```scss
/* Element Variables */

$--color-primary:          #f97316;
$--color-success:          #22c55e;
$--color-warning:          #fbbf24;
$--color-danger:           #ef4444;
$--color-info:             #9a7c68;
$--button-font-weight:     600;
$--border-color-base:      #e8d5c4;
$--border-color-light:     #f0e8e0;
$--border-color-lighter:   #f5ede6;
$--table-border:           1px solid #f0e8e0;
$--color-text-primary:     #2c1a0e;
$--color-text-regular:     #9a7c68;
$--color-text-placeholder: #b8a090;
$--background-color-base:  #f5f0eb;

// Icon font path, required
$--font-path: '~element-ui/lib/theme-chalk/fonts';

// Apply overridden variables in Element UI
@import '~element-ui/packages/theme-chalk/src/index';
```

- [ ] **Step 3: Import warm-theme in index.scss**

Open `src/styles/index.scss`. Find the first line and add the import at the very top (before any existing imports):

```scss
@import './warm-theme';
```

- [ ] **Step 4: Run the dev server to check no SCSS compile errors**

```bash
cd project-rjwm-admin-vue-ts && npm run serve
```

Expected: server starts on `http://localhost:8080` with no SCSS errors in terminal. Stop with Ctrl+C.

- [ ] **Step 5: Commit**

```bash
git add src/styles/warm-theme.scss src/styles/element-variables.scss src/styles/index.scss
git commit -m "feat: add warm brand design system SCSS and update Element UI tokens"
```

---

## Task 2: Rebuild Sidebar

**Files:**
- Modify: `src/layout/components/Sidebar/index.vue`
- Create: `tests/unit/layout/sidebar.spec.ts`

- [ ] **Step 1: Write the smoke test first**

Create `tests/unit/layout/sidebar.spec.ts`:

```typescript
import { createLocalVue, shallowMount } from '@vue/test-utils'
import Vuex from 'vuex'

const localVue = createLocalVue()
localVue.use(Vuex)

// Mock the API call
jest.mock('@/api/users', () => ({
  getStatus: jest.fn().mockResolvedValue({ data: { data: 1 } }),
}))

// Mock SCSS module import
jest.mock('@/styles/_variables.scss', () => ({}), { virtual: true })

// Import after mocks are set up
import Sidebar from '@/layout/components/Sidebar/index.vue'

describe('Sidebar', () => {
  let store: any

  beforeEach(() => {
    store = new Vuex.Store({
      modules: {
        app: {
          namespaced: false,
          state: { sidebar: { opened: true, withoutAnimation: false } },
          getters: { sidebar: (s: any) => s.sidebar },
        },
        user: {
          namespaced: false,
          state: { userInfo: { name: 'Admin' }, roles: [], storeId: '' },
          getters: { userInfo: (s: any) => s.userInfo, roles: (s: any) => s.roles },
        },
      },
    })
  })

  it('renders without error', () => {
    const wrapper = shallowMount(Sidebar, {
      localVue,
      store,
      mocks: { $router: { options: { routes: [] } }, $route: { path: '/dashboard' } },
      stubs: { 'el-scrollbar': true, 'el-menu': true, 'sidebar-item': true },
    })
    expect(wrapper.exists()).toBe(true)
  })

  it('contains no Chinese characters', () => {
    const wrapper = shallowMount(Sidebar, {
      localVue,
      store,
      mocks: { $router: { options: { routes: [] } }, $route: { path: '/dashboard' } },
      stubs: { 'el-scrollbar': true, 'el-menu': true, 'sidebar-item': true },
    })
    expect(wrapper.text()).not.toMatch(/[一-鿿]/)
  })
})
```

- [ ] **Step 2: Run the test — it should fail (Chinese text currently exists)**

```bash
npm run test:unit -- --testPathPattern=sidebar
```

Expected: FAIL — test "contains no Chinese characters" fails because current sidebar has Chinese text in logo/nav area.

- [ ] **Step 3: Replace the Sidebar template and styles**

Open `src/layout/components/Sidebar/index.vue`. Replace the entire `<template>` and `<style>` sections. Keep the `<script>` section exactly as-is EXCEPT:
1. Remove the `SidebarItem` import and component registration
2. Add `import { getStatus } from '@/api/users'` at the top of the imports (it may already be accessible via the existing import in Navbar — add it here independently)
3. Add `businessStatus: 1` to the component's data
4. Add a `fetchStatus()` method and call it in `mounted()`

New `<template>`:

```html
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
```

In `<script>`, make these three targeted changes:

1. Remove the `SidebarItem` import line and remove `SidebarItem` from `components: {}`.
2. Add to `import` block (near the top, after existing imports):
```typescript
import { getStatus } from '@/api/users'
```
3. Inside the class body, add:
```typescript
private businessStatus = 1

async fetchStatus() {
  const { data } = await getStatus()
  this.businessStatus = data.data
}
```
4. In the existing `mounted()` method (or add one if absent), call `this.fetchStatus()`.

New `<style>` section (replace entirely):

```scss
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
.status-open  { background: rgba(34, 197, 94, 0.12); border-color: rgba(34, 197, 94, 0.25); .status-label { color: #22c55e; } }
.status-closed { background: rgba(239, 68, 68, 0.12); border-color: rgba(239, 68, 68, 0.25); .status-label { color: #ef4444; } }
.status-dot {
  width: 7px; height: 7px; border-radius: 50%; background: currentColor; flex-shrink: 0;
  .status-open & { background: #22c55e; animation: pulse 2s infinite; }
  .status-closed & { background: #ef4444; }
}
@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }
.status-label { font-size: 12px; font-weight: 600; }
.status-sub   { color: rgba(255, 255, 255, 0.3); font-size: 10px; }
</style>
```

- [ ] **Step 4: Run the test — should pass now**

```bash
npm run test:unit -- --testPathPattern=sidebar
```

Expected: PASS — both tests green.

- [ ] **Step 5: Commit**

```bash
git add src/layout/components/Sidebar/index.vue tests/unit/layout/sidebar.spec.ts
git commit -m "feat: rebuild sidebar with Warm Brand design, English nav labels"
```

---

## Task 3: Rebuild Navbar

**Files:**
- Modify: `src/layout/components/Navbar/index.vue`
- Create: `tests/unit/layout/navbar.spec.ts`

- [ ] **Step 1: Write the smoke test**

Create `tests/unit/layout/navbar.spec.ts`:

```typescript
import { createLocalVue, shallowMount } from '@vue/test-utils'
import Vuex from 'vuex'
import VueRouter from 'vue-router'

const localVue = createLocalVue()
localVue.use(Vuex)
localVue.use(VueRouter)

jest.mock('@/api/users', () => ({
  getStatus: jest.fn().mockResolvedValue({ data: { data: 1 } }),
  setStatus: jest.fn().mockResolvedValue({ data: { code: 1 } }),
}))
jest.mock('@/api/inform', () => ({
  getCountUnread: jest.fn().mockResolvedValue({ data: { code: 1, data: 0 } }),
}))
jest.mock('@/styles/_variables.scss', () => ({}), { virtual: true })
jest.mock('@/utils/cookies', () => ({ setNewData: jest.fn(), getNewData: jest.fn() }))
jest.mock('js-cookie', () => ({ get: jest.fn().mockReturnValue(JSON.stringify({ name: 'Admin' })) }))

import Navbar from '@/layout/components/Navbar/index.vue'

describe('Navbar', () => {
  let store: any
  const router = new VueRouter()

  beforeEach(() => {
    store = new Vuex.Store({
      state: { app: { sidebar: { opened: true }, statusNumber: 0 } },
      getters: {},
      actions: { LogOut: jest.fn() },
      modules: {
        app: {
          namespaced: false,
          state: { sidebar: { opened: true }, statusNumber: 0 },
          mutations: { TOGGLE_SIDEBAR: jest.fn() },
          actions: { ToggleSideBar: jest.fn(), StatusNumber: jest.fn() },
        },
        user: {
          namespaced: false,
          state: { userInfo: { name: 'Admin' }, storeId: '' },
          getters: { userInfo: (s: any) => s.userInfo, storeId: (s: any) => s.storeId },
        },
      },
    })
  })

  it('renders without error', () => {
    const wrapper = shallowMount(Navbar, {
      localVue, store, router,
      stubs: { Password: true, 'el-badge': true, 'el-dialog': true, 'el-radio-group': true, 'el-button': true },
    })
    expect(wrapper.exists()).toBe(true)
  })

  it('contains no Chinese characters', () => {
    const wrapper = shallowMount(Navbar, {
      localVue, store, router,
      stubs: { Password: true, 'el-badge': true, 'el-dialog': true, 'el-radio-group': true, 'el-button': true },
    })
    expect(wrapper.text()).not.toMatch(/[一-鿿]/)
  })
})
```

- [ ] **Step 2: Run — expect FAIL (Chinese text in current navbar)**

```bash
npm run test:unit -- --testPathPattern=navbar
```

Expected: FAIL on "contains no Chinese characters".

- [ ] **Step 3: Replace Navbar template and styles, keep script section**

Open `src/layout/components/Navbar/index.vue`. Replace only the `<template>` and `<style lang="scss" scoped>` sections. The `<script>` section and the global `<style lang="scss">` (unscoped, for `.el-notification` etc.) must remain exactly unchanged.

New `<template>`:

```html
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
```

New scoped `<style lang="scss" scoped>`:

```scss
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
```

- [ ] **Step 4: Run the test**

```bash
npm run test:unit -- --testPathPattern=navbar
```

Expected: PASS — both tests green.

- [ ] **Step 5: Commit**

```bash
git add src/layout/components/Navbar/index.vue tests/unit/layout/navbar.spec.ts
git commit -m "feat: rebuild navbar with English labels and Warm Brand design"
```

---

## Task 4: Update AppMain and Layout Index

**Files:**
- Modify: `src/layout/components/AppMain.vue`
- Modify: `src/layout/index.vue`

- [ ] **Step 1: Update AppMain.vue**

Replace the `<style lang="scss" scoped>` in `src/layout/components/AppMain.vue`:

```scss
<style lang="scss" scoped>
.app-main {
  height: calc(100% - 56px);
  overflow-y: auto;
  padding: 24px;
  background: #f5f0eb;
  box-sizing: border-box;
}
</style>
```

- [ ] **Step 2: Update Layout index.vue sidebar width**

In `src/layout/index.vue`, find and update the `.main-container` width and background in the scoped style:

```scss
// Change these two rules:
.main-container {
  height: 100%;
  background: #f5f0eb;   // was #f3f4f7
  position: relative;
  width: calc(100% - 220px);  // was 190px
}

// And the margin-left:
.main-container {
  min-height: 100%;
  transition: margin-left 0.28s;
  margin-left: 220px;    // was $sideBarWidth (190px)
  background: #f5f0eb;
  position: relative;
}

// And sidebar-container width:
.sidebar-container {
  transition: width 0.28s;
  width: 220px !important;   // was $sideBarWidth
  // ... rest unchanged
}
```

- [ ] **Step 3: Run dev server and visually check the shell**

```bash
npm run serve
```

Open `http://localhost:8080`. Log in and verify: dark brown sidebar with orange active item, white navbar with breadcrumb and user chip, warm page background. Stop with Ctrl+C.

- [ ] **Step 4: Commit**

```bash
git add src/layout/components/AppMain.vue src/layout/index.vue
git commit -m "feat: update AppMain and layout shell for warm brand dimensions"
```

---

## Task 5: Login Page

**Files:**
- Modify: `src/views/login/index.vue`

- [ ] **Step 1: Replace the login template and styles, keep script**

Open `src/views/login/index.vue`. The `<script>` section must remain exactly as-is (all validation logic, login handlers, redirect logic). Replace only `<template>` and `<style>`.

New `<template>`:

```html
<template>
  <div class="wm-login-page">
    <div class="login-card">
      <!-- Logo -->
      <div class="login-logo">
        <div class="login-logo-icon">🍜</div>
        <div class="login-logo-text">Sky Takeout</div>
        <div class="login-logo-sub">Admin Console</div>
      </div>

      <!-- Form -->
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
```

New `<style lang="scss" scoped>`:

```scss
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
.login-logo-icon {
  font-size: 48px;
  line-height: 1;
  margin-bottom: 10px;
}
.login-logo-text {
  font-size: 22px;
  font-weight: 700;
  color: #2c1a0e;
  line-height: 1.2;
}
.login-logo-sub {
  font-size: 12px;
  color: #9a7c68;
  text-transform: uppercase;
  letter-spacing: 1px;
  margin-top: 2px;
}

.login-form {
  .el-form-item { margin-bottom: 16px; }
}

.login-submit-btn {
  height: 44px !important;
  font-size: 15px !important;
  font-weight: 600 !important;
  border-radius: 10px !important;
  box-shadow: 0 6px 16px rgba(249, 115, 22, 0.35) !important;
}
</style>
```

Also update the **validation error messages** in the `<script>` section — find the `loginRules` object and change Chinese messages to English:
- `'请输入账号'` → `'Please enter your username'`
- `'密码必须在6位以上'` → `'Password must be at least 6 characters'`
- Any other Chinese strings in the rules object.

- [ ] **Step 2: Run dev server and check login page visually**

```bash
npm run serve
```

Navigate to `http://localhost:8080/login`. Verify: dark gradient background, white centered card, noodle emoji logo, English placeholders and button. Stop with Ctrl+C.

- [ ] **Step 3: Commit**

```bash
git add src/views/login/index.vue
git commit -m "feat: redesign login page with Warm Brand theme and English text"
```

---

## Task 6: Dashboard Page

**Files:**
- Modify: `src/views/dashboard/index.vue`
- Modify: `src/views/dashboard/components/titleIndex.vue` (English tab labels)

- [ ] **Step 1: Update dashboard/index.vue wrapper and English class names**

Open `src/views/dashboard/index.vue`. The page uses sub-components (`TitleIndex`, `TurnoverStatistics`, `UserStatistics`, `OrderStatistics`, `Top`). Keep all `<script>` logic unchanged. Update the `<template>` wrapper to use warm brand classes and English:

```html
<template>
  <div class="dashboard-container home">
    <TitleIndex @sendTitleInd="getTitleNum" :flag="flag" :tateData="tateData" />
    <div class="homeMain">
      <TurnoverStatistics :turnoverdata="turnoverData" />
      <UserStatistics :userdata="userData" />
    </div>
    <div class="homeMain homecon">
      <OrderStatistics :orderdata="orderData" :overviewData="overviewData" />
      <Top :top10data="top10Data" />
    </div>
  </div>
</template>
```

The template is already clean — update the `<style>` to use warm brand colors and remove the old yellow/gray theme:

```scss
<style lang="scss" scoped>
.dashboard-container { padding: 0; }
.homeMain {
  display: flex;
  gap: 16px;
  margin-bottom: 16px;
  & > * { flex: 1; min-width: 0; }
}
.homecon { /* second row */ }
</style>
```

- [ ] **Step 2: Translate titleIndex.vue tab labels**

Open `src/views/dashboard/components/titleIndex.vue`. Find all Chinese text strings in the template and replace:
- `今日` → `Today`
- `近7日` or `近7天` → `Last 7 Days`
- `近30日` or `近30天` → `Last 30 Days`
- `本周` → `This Week`
- `本月` → `This Month`
- `营业数据` → `Business Data`
- `订单管理` → `Order Management`
- `菜品总览` → `Dish Overview`
- `套餐总览` → `Combo Overview`
- `订单信息` → `Order Info`
- `待接单` → `Pending`
- `待派送` → `For Delivery`
- `已完成` → `Completed`
- `已取消` → `Cancelled`

Keep all script logic, data properties, and event handlers unchanged.

- [ ] **Step 3: Translate other dashboard sub-components**

In `src/views/dashboard/components/`:
- `turnoverStatistics.vue`: translate `营业额统计` → `Revenue Statistics`, `营业额(元)` → `Revenue ($)`, chart axis labels.
- `userStatistics.vue`: translate `用户统计` → `User Statistics`, `新增用户数` → `New Users`, `总用户量` → `Total Users`.
- `orderStatistics.vue`: translate `订单统计` → `Order Statistics`, `有效订单` → `Valid Orders`, `订单完成率` → `Completion Rate`, `平均价格` → `Avg Price`, `待接单` → `Pending`, `待派送` → `For Delivery`, `已完成` → `Completed`, `已取消` → `Cancelled`.
- `top10.vue`: translate `销量排名TOP10` → `Top 10 by Sales`, `菜品` → `Dish`, `销量` → `Sales`.

For each file: only change string literals in the template. Never touch script/data/computed.

- [ ] **Step 4: Commit**

```bash
git add src/views/dashboard/
git commit -m "feat: translate dashboard and sub-components to English"
```

---

## Task 7: Order Management Page

**Files:**
- Modify: `src/views/orderDetails/index.vue`

- [ ] **Step 1: Replace template with English + new filter bar pattern**

Open `src/views/orderDetails/index.vue`. Keep the entire `<script>` section unchanged. Replace the `<template>`:

```html
<template>
  <div class="dashboard-container">
    <TabChange
      :order-statics="orderStatics"
      :default-activity="defaultActivity"
      @tabChange="change"
    />
    <div class="container">
      <!-- Filter bar -->
      <div class="wm-filter-bar">
        <span class="filter-label">Order No.</span>
        <el-input
          v-model="input"
          placeholder="Search order number"
          style="width: 180px"
          clearable
          @clear="init(orderStatus)"
          @keyup.enter.native="initFun(orderStatus)"
        />
        <span class="filter-label">Phone</span>
        <el-input
          v-model="phone"
          placeholder="Search phone number"
          style="width: 160px"
          clearable
          @clear="init(orderStatus)"
          @keyup.enter.native="initFun(orderStatus)"
        />
        <span class="filter-label">Placed At</span>
        <el-date-picker
          v-model="valueTime"
          clearable
          value-format="yyyy-MM-dd HH:mm:ss"
          range-separator="to"
          :default-time="['00:00:00', '23:59:59']"
          type="daterange"
          start-placeholder="Start date"
          end-placeholder="End date"
          style="width: 280px"
          @clear="init(orderStatus)"
        />
        <div class="filter-actions">
          <el-button @click="init(orderStatus)">Reset</el-button>
          <el-button type="primary" @click="init(orderStatus, true)">Search</el-button>
        </div>
      </div>

      <!-- Table -->
      <div class="wm-table-card">
        <el-table
          v-if="tableData.length"
          :data="tableData"
          style="width: 100%"
        >
          <el-table-column key="number" prop="number" label="Order No." />
          <el-table-column
            v-if="[2, 3, 4].includes(orderStatus)"
            key="orderDishes"
            prop="orderDishes"
            label="Items"
          />
          <el-table-column
            v-if="[0].includes(orderStatus)"
            key="orderDishes"
            prop="orderDishes"
            label="Items"
          />
          <el-table-column prop="amount" label="Amount" />
          <el-table-column prop="address" label="Address" />
          <el-table-column prop="userName" label="Customer" />
          <el-table-column prop="phone" label="Phone" />
          <el-table-column prop="orderTime" label="Placed At" />
          <el-table-column label="Status">
            <template slot-scope="scope">
              <span class="wm-badge" :class="getOrderStatusClass(scope.row.status)">
                <span class="badge-dot" />
                {{ getOrderStatusLabel(scope.row.status) }}
              </span>
            </template>
          </el-table-column>
          <el-table-column label="Actions" width="180" align="center">
            <template slot-scope="scope">
              <span class="wm-action-edit" @click="handleQuery(scope.row.id)">View</span>
              <span
                v-if="scope.row.status === 2"
                class="wm-action-enable"
                style="margin-left:6px"
                @click="handleReceipt(scope.row.id)"
              >Accept</span>
              <span
                v-if="scope.row.status === 3"
                class="wm-action-enable"
                style="margin-left:6px"
                @click="handleDelivery(scope.row.id)"
              >Deliver</span>
              <span
                v-if="scope.row.status === 2"
                class="wm-action-delete"
                style="margin-left:6px"
                @click="handleReject(scope.row.id)"
              >Reject</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No orders found.</div>
        <div class="wm-pagination-wrap">
          <el-pagination
            :current-page="page"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total"
            @current-change="handleCurrentChange"
          />
        </div>
      </div>
    </div>
  </div>
</template>
```

Add these helper methods to the `<script>` section (inside the class body, these are new methods only):

```typescript
getOrderStatusLabel(status: number): string {
  const map: Record<number, string> = {
    1: 'Pending Payment', 2: 'Pending Accept', 3: 'Accepted',
    4: 'Delivering', 5: 'Completed', 6: 'Cancelled'
  }
  return map[status] || 'Unknown'
}

getOrderStatusClass(status: number): string {
  const map: Record<number, string> = {
    1: 'badge-gray', 2: 'badge-orange', 3: 'badge-blue',
    4: 'badge-blue', 5: 'badge-green', 6: 'badge-gray'
  }
  return map[status] || 'badge-gray'
}
```

Also find and translate the `TabChange` component (`src/views/orderDetails/components/tabChange.vue`):
- Tab labels: `待接单` → `Pending`, `待派送` → `For Delivery`, `派送中` → `Delivering`, `已完成` → `Completed`, `已取消` → `Cancelled`, `全部` → `All`.

Replace the `<style>` in orderDetails/index.vue:

```scss
<style lang="scss" scoped>
.container { padding: 0; }
.empty-hint { text-align: center; padding: 40px; color: #9a7c68; font-size: 14px; }
</style>
```

- [ ] **Step 2: Commit**

```bash
git add src/views/orderDetails/
git commit -m "feat: redesign order management page with English labels and warm brand table"
```

---

## Task 8: Category Management Page

**Files:**
- Modify: `src/views/category/index.vue`

- [ ] **Step 1: Replace template and styles, preserve script**

Open `src/views/category/index.vue`. Keep `<script>` unchanged. Replace `<template>`:

```html
<template>
  <div class="dashboard-container">
    <div class="container">
      <!-- Filter bar -->
      <div class="wm-filter-bar">
        <span class="filter-label">Name</span>
        <el-input
          v-model="name"
          placeholder="Search category name"
          style="width: 200px"
          clearable
          @clear="init"
          @keyup.enter.native="init"
        />
        <span class="filter-label">Type</span>
        <el-select v-model="categoryType" placeholder="All types" clearable style="width: 160px" @clear="init">
          <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <div class="filter-actions">
          <el-button @click="init">Reset</el-button>
          <el-button type="primary" @click="init(true)">Search</el-button>
          <el-button type="primary" @click="addClass('class')">+ Dish Category</el-button>
          <el-button type="primary" @click="addClass('meal')">+ Combo Category</el-button>
        </div>
      </div>

      <!-- Table -->
      <div class="wm-table-card">
        <el-table v-if="tableData.length" :data="tableData" style="width:100%">
          <el-table-column prop="name" label="Category Name" />
          <el-table-column label="Type">
            <template slot-scope="scope">
              <span class="wm-badge" :class="scope.row.type == '1' ? 'badge-blue' : 'badge-orange'">
                <span class="badge-dot" />
                {{ scope.row.type == '1' ? 'Dish' : 'Combo' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="sort" label="Sort Order" />
          <el-table-column label="Status">
            <template slot-scope="scope">
              <span class="wm-badge" :class="String(scope.row.status) === '0' ? 'badge-gray' : 'badge-green'">
                <span class="badge-dot" />
                {{ String(scope.row.status) === '0' ? 'Disabled' : 'Enabled' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="updateTime" label="Last Updated" />
          <el-table-column label="Actions" align="center" width="160">
            <template slot-scope="scope">
              <span class="wm-action-edit" @click="editHandle(scope.row.id)">Edit</span>
              <span
                class="wm-action-delete"
                style="margin-left:6px"
                @click="deleteHandle(scope.row.id)"
              >Delete</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No categories found.</div>
        <div class="wm-pagination-wrap">
          <el-pagination
            :current-page="page"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total"
            @current-change="handleCurrentChange"
          />
        </div>
      </div>
    </div>

    <!-- Add/Edit Dialog — translate title and button labels only -->
    <!-- Find the existing el-dialog for adding categories and update: -->
    <!-- title: "新增分类" → "Add Category" / "编辑分类" → "Edit Category" -->
    <!-- el-button text: "取 消" → "Cancel", "确 定" → "Confirm" -->
    <!-- form labels: "分类名称" → "Category Name", "分类类型" → "Type", "排序" → "Sort Order" -->
  </div>
</template>
```

**Important:** The category page has an `el-dialog` for adding categories. Find it in the existing template and translate its labels inline (title, button text, form item labels). Keep all `v-model` bindings, `:visible.sync`, and event handlers unchanged.

Replace `<style lang="scss" scoped>`:

```scss
<style lang="scss" scoped>
.container { padding: 0; }
.empty-hint { text-align: center; padding: 40px; color: #9a7c68; }
</style>
```

Also update the `options` array in `<script>` data:
- Find `{ value: '1', label: '菜品分类' }` → `{ value: '1', label: 'Dish Category' }`
- Find `{ value: '2', label: '套餐分类' }` → `{ value: '2', label: 'Combo Category' }`

- [ ] **Step 2: Commit**

```bash
git add src/views/category/index.vue
git commit -m "feat: redesign category page with English labels and warm brand table"
```

---

## Task 9: Dish Management Page

**Files:**
- Modify: `src/views/dish/index.vue`

- [ ] **Step 1: Replace template and styles, preserve script**

Open `src/views/dish/index.vue`. Keep `<script>` unchanged. Replace `<template>`:

```html
<template>
  <div class="dashboard-container">
    <div class="container">
      <!-- Page header -->
      <div class="wm-page-header">
        <h1 class="wm-page-title">Dish Management</h1>
        <el-button type="primary" @click="addDishtype('add')">+ New Dish</el-button>
      </div>

      <!-- Filter bar -->
      <div class="wm-filter-bar">
        <span class="filter-label">Name</span>
        <el-input
          v-model="input"
          placeholder="Search dish name"
          style="width: 180px"
          clearable
          @clear="init"
          @keyup.enter.native="initFun"
        />
        <span class="filter-label">Category</span>
        <el-select v-model="categoryId" style="width:160px" placeholder="All categories" clearable @clear="init">
          <el-option v-for="item in dishCategoryList" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <span class="filter-label">Status</span>
        <el-select v-model="dishStatus" style="width:140px" placeholder="All statuses" clearable @clear="init">
          <el-option v-for="item in saleStatus" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <div class="filter-actions">
          <el-button @click="init">Reset</el-button>
          <el-button type="primary" @click="init(true)">Search</el-button>
        </div>
      </div>

      <!-- Table -->
      <div class="wm-table-card">
        <div class="table-toolbar">
          <span class="selected-info">{{ multipleSelection.length ? `${multipleSelection.length} selected` : '' }}</span>
          <div class="toolbar-right">
            <el-button size="small" @click="deleteHandle('批量', null)">Delete Selected</el-button>
          </div>
        </div>
        <el-table
          v-if="tableData.length"
          :data="tableData"
          style="width:100%"
          @selection-change="handleSelectionChange"
        >
          <el-table-column type="selection" width="48" />
          <el-table-column label="Dish" min-width="200">
            <template slot-scope="scope">
              <div style="display:flex;align-items:center;gap:10px">
                <img :src="scope.row.image" style="width:40px;height:40px;border-radius:8px;object-fit:cover;background:#fde8cc" />
                <span style="font-weight:600">{{ scope.row.name }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="categoryName" label="Category" />
          <el-table-column label="Price">
            <template slot-scope="scope">
              <span style="color:#f97316;font-weight:700">${{ scope.row.price }}</span>
            </template>
          </el-table-column>
          <el-table-column label="Status">
            <template slot-scope="scope">
              <span class="wm-badge" :class="String(scope.row.status) === '1' ? 'badge-green' : 'badge-gray'">
                <span class="badge-dot" />
                {{ String(scope.row.status) === '1' ? 'On Sale' : 'Disabled' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="updateTime" label="Last Updated" />
          <el-table-column label="Actions" align="center" width="200">
            <template slot-scope="scope">
              <span class="wm-action-edit" @click="addDishtype(scope.row.id)">Edit</span>
              <span
                :class="String(scope.row.status) === '1' ? 'wm-action-toggle' : 'wm-action-enable'"
                style="margin-left:6px"
                @click="statusHandle(String(scope.row.status) === '1' ? '0' : '1', scope.row)"
              >{{ String(scope.row.status) === '1' ? 'Disable' : 'Enable' }}</span>
              <span class="wm-action-delete" style="margin-left:6px" @click="deleteHandle('单', scope.row)">Delete</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No dishes found.</div>
        <div class="wm-pagination-wrap">
          <el-pagination
            :current-page="page"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total"
            @current-change="handleCurrentChange"
          />
        </div>
      </div>
    </div>
  </div>
</template>
```

Also update the `saleStatus` array in `<script>` data:
- `{ value: '1', label: '启售' }` → `{ value: '1', label: 'On Sale' }`
- `{ value: '0', label: '停售' }` → `{ value: '0', label: 'Disabled' }`

Replace `<style lang="scss" scoped>`:
```scss
<style lang="scss" scoped>
.container { padding: 0; }
.empty-hint { text-align: center; padding: 40px; color: #9a7c68; }
</style>
```

- [ ] **Step 2: Commit**

```bash
git add src/views/dish/index.vue
git commit -m "feat: redesign dish management page with English labels and warm brand table"
```

---

## Task 10: Add/Edit Dish Page

**Files:**
- Modify: `src/views/dish/addDishtype.vue`

- [ ] **Step 1: Translate all Chinese strings in template, keep all script logic**

Open `src/views/dish/addDishtype.vue`. Do NOT touch the `<script>` section at all. In the `<template>`, find and replace all Chinese string literals:

| Chinese | English |
|---|---|
| `添加菜品` / `编辑菜品` | `Add Dish` / `Edit Dish` |
| `菜品名称` | `Dish Name` |
| `菜品分类` | `Category` |
| `菜品价格` | `Price` |
| `菜品描述` | `Description` |
| `口味做法` | `Flavor Options` |
| `图片上传` | `Upload Image` |
| `售卖状态` | `Sale Status` |
| `起售` / `停售` | `On Sale` / `Off Sale` |
| `添加口味` | `+ Add Flavor` |
| `口味名称` | `Flavor Name` |
| `口味选项` | `Options` |
| `保存` | `Save` |
| `取消` | `Cancel` |
| `请填写菜品名称` | `Enter dish name` |
| `请选择菜品分类` | `Select a category` |
| `请填写价格` | `Enter price` |
| `返回` | `Back` |

Update the page `<title>` tag or breadcrumb if any Chinese is present.

In the `<style>` section, update background and accent colors to use warm brand tokens:
- Any `#FFC200` or `#ffc100` → `#f97316`
- Any `#343744` or `#272A36` → `#2c1a0e`

- [ ] **Step 2: Commit**

```bash
git add src/views/dish/addDishtype.vue
git commit -m "feat: translate add/edit dish form to English"
```

---

## Task 11: Combo (Setmeal) Management Page

**Files:**
- Modify: `src/views/setmeal/index.vue`

- [ ] **Step 1: Replace template and styles**

Open `src/views/setmeal/index.vue`. Keep `<script>` unchanged. Replace `<template>`:

```html
<template>
  <div class="dashboard-container">
    <div class="container">
      <div class="wm-page-header">
        <h1 class="wm-page-title">Combo Management</h1>
        <el-button type="primary" @click="addSetMeal('add')">+ New Combo</el-button>
      </div>

      <div class="wm-filter-bar">
        <span class="filter-label">Name</span>
        <el-input v-model="input" placeholder="Search combo name" style="width:180px" clearable @clear="init" @keyup.enter.native="initFun" />
        <span class="filter-label">Category</span>
        <el-select v-model="categoryId" style="width:160px" placeholder="All categories" clearable @clear="init">
          <el-option v-for="item in dishCategoryList" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <span class="filter-label">Status</span>
        <el-select v-model="dishStatus" style="width:140px" placeholder="All statuses" clearable @clear="init">
          <el-option v-for="item in saleStatus" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <div class="filter-actions">
          <el-button @click="init">Reset</el-button>
          <el-button type="primary" @click="init(true)">Search</el-button>
        </div>
      </div>

      <div class="wm-table-card">
        <div class="table-toolbar">
          <div class="toolbar-right">
            <el-button size="small" @click="deleteHandle('批量')">Delete Selected</el-button>
          </div>
        </div>
        <el-table v-if="tableData.length" :data="tableData" style="width:100%" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="48" />
          <el-table-column label="Combo" min-width="200">
            <template slot-scope="scope">
              <div style="display:flex;align-items:center;gap:10px">
                <img :src="scope.row.image" style="width:40px;height:40px;border-radius:8px;object-fit:cover;background:#fde8cc" />
                <span style="font-weight:600">{{ scope.row.name }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="categoryName" label="Category" />
          <el-table-column label="Price">
            <template slot-scope="scope">
              <span style="color:#f97316;font-weight:700">${{ scope.row.price }}</span>
            </template>
          </el-table-column>
          <el-table-column label="Status">
            <template slot-scope="scope">
              <span class="wm-badge" :class="String(scope.row.status) === '1' ? 'badge-green' : 'badge-gray'">
                <span class="badge-dot" />
                {{ String(scope.row.status) === '1' ? 'On Sale' : 'Disabled' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="updateTime" label="Last Updated" />
          <el-table-column label="Actions" align="center" width="200">
            <template slot-scope="scope">
              <span class="wm-action-edit" @click="addSetMeal(scope.row.id)">Edit</span>
              <span
                :class="String(scope.row.status) === '1' ? 'wm-action-toggle' : 'wm-action-enable'"
                style="margin-left:6px"
                @click="statusHandle(String(scope.row.status) === '1' ? '0' : '1', scope.row)"
              >{{ String(scope.row.status) === '1' ? 'Disable' : 'Enable' }}</span>
              <span class="wm-action-delete" style="margin-left:6px" @click="deleteHandle('单', scope.row)">Delete</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No combos found.</div>
        <div class="wm-pagination-wrap">
          <el-pagination :current-page="page" :page-size="pageSize" layout="total, prev, pager, next" :total="total" @current-change="handleCurrentChange" />
        </div>
      </div>
    </div>
  </div>
</template>
```

Update `saleStatus` data in script:
- `'启售'` → `'On Sale'`, `'停售'` → `'Disabled'`

Replace style with: `<style lang="scss" scoped>.container{padding:0}.empty-hint{text-align:center;padding:40px;color:#9a7c68}</style>`

- [ ] **Step 2: Commit**

```bash
git add src/views/setmeal/index.vue
git commit -m "feat: redesign combo management page with English labels and warm brand table"
```

---

## Task 12: Add/Edit Combo Page

**Files:**
- Modify: `src/views/setmeal/addSetmeal.vue`

- [ ] **Step 1: Translate all Chinese strings, keep script**

Open `src/views/setmeal/addSetmeal.vue`. In `<template>` only, replace:

| Chinese | English |
|---|---|
| `添加套餐` / `编辑套餐` | `Add Combo` / `Edit Combo` |
| `套餐名称` | `Combo Name` |
| `套餐分类` | `Category` |
| `套餐价格` | `Price` |
| `套餐描述` | `Description` |
| `套餐图片` | `Combo Image` |
| `售卖状态` | `Sale Status` |
| `起售` / `停售` | `On Sale` / `Off Sale` |
| `菜品信息` | `Included Dishes` |
| `添加菜品` | `Add Dish` |
| `菜品名称` | `Dish Name` |
| `菜品分类` | `Category` |
| `菜品价格` | `Price` |
| `份数` | `Qty` |
| `操作` | `Actions` |
| `删除` | `Remove` |
| `保存` | `Save` |
| `取消` | `Cancel` |
| `返回` | `Back` |
| Any placeholder `请填写…` / `请选择…` | `Enter…` / `Select…` |

In `<style>`, replace any `#FFC200` / `#ffc100` → `#f97316` and `#343744` → `#2c1a0e`.

- [ ] **Step 2: Commit**

```bash
git add src/views/setmeal/addSetmeal.vue
git commit -m "feat: translate add/edit combo form to English"
```

---

## Task 13: Employee Management Page

**Files:**
- Modify: `src/views/employee/index.vue`

- [ ] **Step 1: Replace template and styles**

Open `src/views/employee/index.vue`. Keep `<script>` unchanged. Replace `<template>`:

```html
<template>
  <div class="dashboard-container">
    <div class="container">
      <div class="wm-page-header">
        <h1 class="wm-page-title">Employee Management</h1>
        <el-button type="primary" @click="addEmployeeHandle('add')">+ Add Employee</el-button>
      </div>

      <div class="wm-filter-bar">
        <span class="filter-label">Name</span>
        <el-input
          v-model="input"
          placeholder="Search employee name"
          style="width:200px"
          clearable
          @clear="init"
          @keyup.enter.native="initFun"
        />
        <div class="filter-actions">
          <el-button @click="init">Reset</el-button>
          <el-button type="primary" @click="init(true)">Search</el-button>
        </div>
      </div>

      <div class="wm-table-card">
        <el-table v-if="tableData.length" :data="tableData" style="width:100%">
          <el-table-column prop="name" label="Full Name" />
          <el-table-column prop="username" label="Username" />
          <el-table-column prop="phone" label="Phone" />
          <el-table-column label="Status">
            <template slot-scope="scope">
              <span class="wm-badge" :class="String(scope.row.status) === '0' ? 'badge-gray' : 'badge-green'">
                <span class="badge-dot" />
                {{ String(scope.row.status) === '0' ? 'Disabled' : 'Active' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="updateTime" label="Last Updated" />
          <el-table-column label="Actions" align="center" width="180">
            <template slot-scope="scope">
              <span
                class="wm-action-edit"
                :class="{ 'disabled-text': scope.row.username === 'admin' }"
                @click="scope.row.username !== 'admin' && addEmployeeHandle(scope.row.id, scope.row.username)"
              >Edit</span>
              <span
                v-if="scope.row.username !== 'admin'"
                :class="String(scope.row.status) === '0' ? 'wm-action-enable' : 'wm-action-toggle'"
                style="margin-left:6px"
                @click="statusHandle(scope.row)"
              >{{ String(scope.row.status) === '0' ? 'Enable' : 'Disable' }}</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No employees found.</div>
        <div class="wm-pagination-wrap">
          <el-pagination :current-page="page" :page-size="pageSize" layout="total, prev, pager, next" :total="total" @current-change="handleCurrentChange" />
        </div>
      </div>
    </div>
  </div>
</template>
```

Replace style: `<style lang="scss" scoped>.container{padding:0}.empty-hint{text-align:center;padding:40px;color:#9a7c68}.disabled-text{opacity:0.4;cursor:not-allowed}</style>`

- [ ] **Step 2: Commit**

```bash
git add src/views/employee/index.vue
git commit -m "feat: redesign employee management page with English labels and warm brand table"
```

---

## Task 14: Add/Edit Employee Page

**Files:**
- Modify: `src/views/employee/addEmployee.vue`

- [ ] **Step 1: Translate all Chinese strings, keep script**

Open `src/views/employee/addEmployee.vue`. In `<template>` only, replace:

| Chinese | English |
|---|---|
| `添加员工` / `编辑员工` | `Add Employee` / `Edit Employee` |
| `员工姓名` | `Full Name` |
| `账号` | `Username` |
| `手机号` | `Phone` |
| `密码` | `Password` |
| `账号状态` | `Account Status` |
| `启用` / `禁用` | `Active` / `Disabled` |
| `保存` | `Save` |
| `取消` | `Cancel` |
| `返回` | `Back` |
| `请填写…` / `请输入…` | `Enter…` |
| `请选择…` | `Select…` |

Also translate any validation rule messages in the `<script>` `rules` object:
- `'请填写员工姓名'` → `'Employee name is required'`
- `'请填写账号'` → `'Username is required'`
- `'请填写手机号'` → `'Phone number is required'`
- `'请填写密码'` → `'Password is required'`

In `<style>`, replace any `#FFC200` → `#f97316`.

- [ ] **Step 2: Commit**

```bash
git add src/views/employee/addEmployee.vue
git commit -m "feat: translate add/edit employee form to English"
```

---

## Task 15: Statistics Page

**Files:**
- Modify: `src/views/statistics/index.vue`

- [ ] **Step 1: Translate Chinese strings, keep all script and sub-component logic**

The statistics page shares the same sub-components as the dashboard (`TitleIndex`, `TurnoverStatistics`, `UserStatistics`, `OrderStatistics`, `Top`) — those were already translated in Task 6. The statistics `index.vue` itself may have its own page-level Chinese text.

Open `src/views/statistics/index.vue`. In `<template>`, translate any page-level Chinese:
- Page title or headings: `数据统计` → `Statistics`
- Any labels not inside sub-components

Verify the `<script>` section's data labels:
- Any Chinese strings in `tateData` array (tab items shown in `TitleIndex`):
  - `营业额统计` → `Revenue`
  - `用户统计` → `Users`
  - `订单统计` → `Orders`

Update these string values in the script data, e.g.:

```typescript
private tateData = [
  { name: 'Revenue',  value: 0 },
  { name: 'Users',    value: 1 },
  { name: 'Orders',   value: 2 },
]
```

- [ ] **Step 2: Commit**

```bash
git add src/views/statistics/index.vue
git commit -m "feat: translate statistics page to English"
```

---

## Task 16: Notifications Page

**Files:**
- Modify: `src/views/inform/index.vue`

- [ ] **Step 1: Replace template and styles**

Open `src/views/inform/index.vue`. Keep `<script>` unchanged. Replace `<template>`:

```html
<template>
  <div class="dashboard-container">
    <div class="inform-header wm-card">
      <ul class="tab-list">
        <li
          v-for="(item, index) in tabList"
          :key="index"
          :class="{ 'tab-active': activeIndex === index }"
          @click="handleClass(index)"
        >
          <el-badge
            class="item"
            :value="ountUnread === 0 ? null : ountUnread > 99 ? '99+' : ountUnread"
            :hidden="!([1].includes(item.value) && ountUnread)"
          >{{ item.label }}</el-badge>
        </li>
      </ul>
      <el-button
        v-if="status === 1 && baseData.length > 0"
        size="small"
        class="mark-all-btn"
        @click="handleBatch"
      >Mark All as Read</el-button>
      <el-button v-else size="small" disabled class="mark-all-btn">Mark All as Read</el-button>
    </div>

    <div class="inform-list wm-card" v-if="baseData.length > 0">
      <div v-for="(item, index) in baseData" :key="index" class="inform-item">
        <div v-if="item.type === 1" class="inform-content">
          <span class="inform-tag tag-pending">Pending</span>
          {{ item.arrNew[0] }}
          <router-link :to="'/order?status=2'" class="inform-link" @click.native="handleSetStatus(item.id)">
            {{ item.arrNew[1] }}
          </router-link>
          {{ item.arrNew[2] }}
          <span class="inform-time">{{ item.createTime }}</span>
        </div>
        <div v-if="item.type === 2" class="inform-content">
          <span class="inform-tag tag-urgent">Urgent</span>
          <span class="tag-pending">Pending</span>
          {{ item.arrNew[0] }}
          <router-link :to="'/order?status=2'" class="inform-link" @click.native="handleSetStatus(item.id)">
            {{ item.arrNew[1] }}
          </router-link>
          {{ item.arrNew[2] }}
          <span class="inform-time">{{ item.createTime }}</span>
        </div>
        <div v-if="item.type === 3" class="inform-content">
          <span class="inform-tag tag-reminder">Reminder</span>
          {{ item.content }}
          <span class="inform-time">{{ item.createTime }}</span>
        </div>
      </div>
    </div>
    <div v-else class="empty-hint wm-card">No notifications.</div>
  </div>
</template>
```

Also update the `tabList` data in `<script>` to English:
- `待接单` → `'Pending Orders'`
- `待派送` → `'For Delivery'`
- `催单` → `'Reminders'`

(Find the `tabList` array initialization in the class body and update the `label` properties.)

Replace `<style lang="scss" scoped>`:

```scss
<style lang="scss" scoped>
.inform-header {
  display: flex;
  align-items: center;
  padding: 0 20px;
  margin-bottom: 16px;
  border-radius: 12px;
}
.tab-list {
  display: flex;
  list-style: none;
  gap: 0;
  flex: 1;
  li {
    padding: 16px 20px;
    cursor: pointer;
    font-size: 14px;
    color: #9a7c68;
    border-bottom: 2px solid transparent;
    transition: color 0.15s, border-color 0.15s;
    &:hover { color: #f97316; }
  }
  .tab-active {
    color: #f97316;
    border-bottom-color: #f97316;
    font-weight: 600;
  }
}
.mark-all-btn { flex-shrink: 0; }

.inform-list { padding: 8px 0; }
.inform-item {
  padding: 14px 20px;
  border-bottom: 1px solid #f5ede6;
  &:last-child { border-bottom: none; }
}
.inform-content { font-size: 13px; color: #2c1a0e; line-height: 1.6; }
.inform-tag {
  display: inline-block;
  font-size: 11px;
  font-weight: 700;
  padding: 2px 8px;
  border-radius: 4px;
  margin-right: 6px;
}
.tag-pending  { background: #fff7ed; color: #ea580c; }
.tag-urgent   { background: #fff5f5; color: #ef4444; }
.tag-reminder { background: #eff6ff; color: #3b82f6; }
.inform-link  { color: #f97316; font-weight: 600; text-decoration: none; &:hover { text-decoration: underline; } }
.inform-time  { float: right; color: #b8a090; font-size: 11px; }
.empty-hint   { text-align: center; padding: 40px; color: #9a7c68; }
</style>
```

- [ ] **Step 2: Commit**

```bash
git add src/views/inform/index.vue
git commit -m "feat: redesign notifications page with English labels and warm brand styles"
```

---

## Task 17: 404 Error Page

**Files:**
- Modify: `src/views/404.vue`

- [ ] **Step 1: Replace with English warm brand 404 page**

Open `src/views/404.vue`. Keep the `<script>` section (if any — it may just do a redirect). Replace `<template>` and `<style>`:

```html
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
```

- [ ] **Step 2: Commit**

```bash
git add src/views/404.vue
git commit -m "feat: redesign 404 page with English text and warm brand style"
```

---

## Task 18: Final Integration Check

- [ ] **Step 1: Run the full test suite**

```bash
npm run test:unit
```

Expected: All existing tests pass + the 4 new layout smoke tests pass. If any test fails, read the error output and fix the issue before proceeding.

- [ ] **Step 2: Run the dev server and walk through every page**

```bash
npm run serve
```

Open `http://localhost:8080` and verify each of these in order:
1. `/login` — warm dark background, English form, Sign In button works
2. `/dashboard` — stats cards visible, chart loads, English tab labels
3. `/order` — filter bar shows English labels, table loads
4. `/category` — English filter + table, Add buttons work
5. `/dish` — English filter + table, New Dish navigates to add form
6. `/dish/add` — English form labels, image upload present
7. `/setmeal` — English filter + table
8. `/setmeal/add` — English form
9. `/employee` — English filter + table
10. `/employee/add` — English form
11. `/statistics` — English tab labels, charts load
12. `/inform` — English tab labels, mark all as read visible
13. Sidebar: all nav items in English, active state orange, status pill visible
14. Navbar: breadcrumb updates on navigation, user chip shows name, status toggle opens dialog in English

- [ ] **Step 3: Translate Chinese strings in script-level dialogs and messages**

Script sections contain `$confirm`, `$message`, and `$notify` calls with Chinese text. These are user-visible even though they are in scripts. Translate them across all view files:

```bash
grep -rn --include="*.vue" --include="*.ts" "确认\|提示\|成功\|失败\|删除\|操作\|取消\|确定" src/views/
```

For each match, update the string in-place. Common patterns and their English equivalents:

| Chinese | English |
|---|---|
| `'确认删除？'` | `'Are you sure you want to delete this?'` |
| `'提示'` | `'Confirm'` |
| `'操作成功！'` | `'Operation successful!'` |
| `'删除成功'` | `'Deleted successfully'` |
| `'操作失败'` | `'Operation failed'` |
| `this.$message.success('操作成功！')` | `this.$message.success('Saved successfully!')` |
| `this.$message.error(...)` | Keep as-is (message comes from API) |

- [ ] **Step 4: Check for any remaining Chinese characters**

```bash
grep -r --include="*.vue" --include="*.ts" -l '[^\x00-\x7F]' src/views src/layout
```

For any files returned, open them and translate remaining Chinese strings.

- [ ] **Step 5: Final commit**

```bash
git add -A
git commit -m "feat: complete Sky Takeout admin full redesign and English translation"
```
