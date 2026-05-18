# Sky Takeout Admin — Full Redesign Design Spec

**Date:** 2026-05-18  
**Project:** `project-rjwm-admin-vue-ts`  
**Stack:** Vue 2 + TypeScript + Element UI  
**Approach:** B — Rebuild Layout Shell + Global SCSS Theme Override  

---

## 1. Goals

1. Replace all Chinese text with English throughout the entire frontend.
2. Apply a **Warm Brand** visual redesign — deep brown sidebar, orange/amber accents, warm card tones.
3. Rebuild the layout shell (sidebar, navbar, AppMain) to match the approved mockup.
4. Redesign each page's layout and table/card patterns with the new design system.
5. Leave all API calls, Vuex store, router configuration, and business logic untouched.

---

## 2. Design System

### Color Palette

| Token | Value | Usage |
|---|---|---|
| `$brand-dark` | `#2c1a0e` | Sidebar background, headings |
| `$brand-mid` | `#431407` | Sidebar hover/active bg |
| `$brand-accent` | `#f97316` | Primary buttons, active nav item, links |
| `$brand-accent-light` | `#fef3e8` | Button hover bg, card icon bg |
| `$brand-amber` | `#fbbf24` | Chart highlights, warnings |
| `$page-bg` | `#f5f0eb` | App background |
| `$card-bg` | `#ffffff` | Cards, panels, table rows |
| `$card-border` | `#f0e8e0` | Card/table borders |
| `$table-header-bg` | `#fdf8f4` | Table `<thead>` background |
| `$text-primary` | `#2c1a0e` | Body text, headings |
| `$text-secondary` | `#9a7c68` | Labels, placeholders, meta |
| `$text-muted` | `#b8a090` | Timestamps, secondary meta |
| `$input-border` | `#e8d5c4` | Input/select borders |
| `$success` | `#22c55e` | On-sale badge, open status |
| `$danger` | `#ef4444` | Delete actions, error badge |
| `$info` | `#3b82f6` | Edit action links |

### Typography

- **Font:** system-ui / `-apple-system` / `BlinkMacSystemFont` / `'Segoe UI'`
- **Page title:** 20px, weight 700, `$text-primary`
- **Section label:** 11px, weight 700, uppercase, letter-spacing 0.8px, `$text-secondary`
- **Body / table cells:** 13px, weight 400, `$text-primary`
- **Captions / timestamps:** 11–12px, `$text-muted`

### Spacing & Radius

- Page padding: `24px`
- Card border-radius: `14px`
- Button border-radius: `8px`
- Badge border-radius: `20px` (pill)
- Input border-radius: `8px`

### Shadows

- Card: `0 2px 8px rgba(44,26,14,0.05)`
- Primary button: `0 4px 12px rgba(249,115,22,0.30)`
- Navbar: `0 1px 4px rgba(44,26,14,0.06)`

---

## 3. Layout Shell

### 3.1 Sidebar (`layout/components/Sidebar/`)

**Dimensions:** 220px wide, full height, fixed.

**Structure:**
- **Logo area** (top): noodle emoji icon in orange `#f97316` rounded square + "Sky Takeout" / "ADMIN CONSOLE" subtitle. Bottom border `rgba(255,255,255,0.07)`.
- **Nav sections** (middle): Three labeled groups — "MAIN", "MENU", "STAFF". Each nav item is `flex` row with SVG icon + label. Active item gets `background: $brand-accent`, white text, and `box-shadow: 0 4px 12px rgba(249,115,22,0.35)`. Unread badges rendered as red pills (right-aligned).
- **Status footer** (bottom): Green pulsing pill showing "Open for Orders" / "Closed" with toggle behavior. Separated by top border.

**Nav items (English labels):**
- MAIN: Dashboard, Orders (badge), Statistics
- MENU: Categories, Dishes, Combos
- STAFF: Employees, Notifications (badge)

### 3.2 Navbar (`layout/components/Navbar.vue`)

**Height:** 56px, `background: #fff`, bottom border `#f0e8e0`.

**Left:** Breadcrumb — "Home › {current page title}" using `$text-secondary` / `$text-primary`.

**Right:**
- Notification bell button — 36px circle, `background: $brand-accent-light`, border `$input-border`, badge counter in red pill.
- User chip — avatar circle (orange, initials), username text, rounded pill shape.
- Dropdown on user chip: "Change Password", "Logout".

### 3.3 AppMain (`layout/components/AppMain.vue`)

- Background: `$page-bg` (`#f5f0eb`)
- Padding: `24px`
- Overflow: `auto`

---

## 4. Pages

### 4.1 Login (`views/login/`)

- Full-screen, centered card design.
- Background: warm dark gradient (`#2c1a0e` → `#431407`).
- Card: white, `border-radius: 20px`, `padding: 40px`, max-width 420px.
- Logo + "Sky Takeout Admin" heading at top.
- Fields: "Username" and "Password" with warm-styled Element UI inputs.
- "Sign In" button: full width, `$brand-accent`, orange shadow.
- Error state: red text below field.

### 4.2 Dashboard (`views/home/`)

**Row 1 — Stats strip (4 cards):**
- Cards: Today's Revenue, Orders Today, New Customers, Avg Delivery Time.
- Each card: emoji icon in a colored rounded square, uppercase label, large value, trend delta (green ↑ / red ↓).

**Row 2 — Two-column panel grid:**
- Left (60%): Weekly Revenue bar chart (ECharts, orange gradient bars).
- Right (40%): Recent Orders list — order ID, time ago, status badge, amount.

### 4.3 Order Management (`views/order/`)

Filter bar: Date range picker + Order status select + Search/Reset buttons.

Table columns: Order ID, Customer, Items, Amount, Status (badge), Placed At, Actions.

Status badges: Pending (orange), Delivering (blue), Completed (green), Cancelled (gray).

Actions: View, Accept, Reject, Deliver — contextual per status.

### 4.4 Category Management (`views/category/`)

Two tab buttons at top: "Dish Categories" | "Combo Categories".

Table columns: Name, Type, Sort Order, Created At, Actions (Edit / Delete).

Add dialog: Name + Type select + Sort order input.

### 4.5 Dish Management (`views/dish/`)

Filter bar: Name search + Category select + Status select.

Table columns: Dish (image + name + description), Category, Price, Status badge, Last Updated, Actions (Edit / Disable|Enable / Delete).

Bulk toolbar: Enable Selected, Delete Selected (shown when rows checked).

### 4.6 Add / Edit Dish (`views/dish/addDish.vue`)

Two-column form layout:
- Left: Dish name, Category, Price, Description, Flavor tags.
- Right: Image upload area, On Sale toggle.

Flavors section below: add/remove flavor options inline.

### 4.7 Combo Management (`views/setmeal/`)

Same table pattern as Dish. Columns: Combo (image + name), Category, Price, Dishes count, Status, Actions.

### 4.8 Add / Edit Combo (`views/setmeal/addSetmeal.vue`)

Form: Name, Category, Price, Description, Image upload. Dish picker: searchable table to add dishes to combo with quantity.

### 4.9 Employee Management (`views/employee/`)

Filter bar: Name search + Account status select.

Table columns: Name, Username, Phone, Status badge, Created At, Actions (Edit / Enable|Disable).

### 4.10 Add / Edit Employee (`views/employee/addEmployee.vue`)

Form: Full name, Username, Phone, Password (on add), Status toggle.

### 4.11 Statistics (`views/statistics/`)

Date range selector at top.

Three ECharts panels: Turnover line chart, User growth line chart, Order overview (bar). All use orange/amber palette.

### 4.12 Notifications (`views/inform/`)

Three tabs: Pending Orders, Out for Delivery, Order Reminders.

Each notification card: order ID, item summary, timestamp, Mark Read button. "Mark All as Read" button at top right.

---

## 5. Shared Components

### Buttons

| Variant | Style |
|---|---|
| Primary | `background: $brand-accent`, white text, orange shadow |
| Secondary | `background: #fff`, `color: #6b4c3b`, `border: $input-border` |
| Danger | `background: #fff5f5`, `color: $danger`, `border: #fecaca` |

### Status Badges (pills)

| State | Background | Text color |
|---|---|---|
| On Sale / Enabled | `#f0fdf4` | `#16a34a` |
| Disabled | `#f5f5f5` | `#9a7c68` |
| Pending | `#fff7ed` | `#ea580c` |
| Delivering | `#eff6ff` | `#3b82f6` |
| Completed | `#f0fdf4` | `#16a34a` |
| Cancelled | `#f5f5f5` | `#9a7c68` |

### Table Pattern

- Filter bar: white card above, labeled groups, Search + Reset buttons.
- Table card: `border-radius: 14px`, `$card-border`, warm header bg.
- Row hover: `#fffaf7`.
- Action links: color-coded pill-style (`action-edit`, `action-toggle`, `action-delete`).
- Pagination footer: `background: #fdf8f4`, active page in orange.

### Element UI Overrides (SCSS)

Override in `src/styles/element-variables.scss` and a new `src/styles/warm-theme.scss`:
- Primary color: `#f97316`
- Border color: `#e8d5c4`
- Background color base: `#f5f0eb`
- Input border-radius: `8px`
- Button border-radius: `8px`
- Table header bg: `#fdf8f4`
- Dialog border-radius: `14px`

---

## 6. Files to Change

### New / Replace

| File | Change |
|---|---|
| `src/styles/warm-theme.scss` | New — design system tokens + component overrides |
| `src/styles/element-variables.scss` | Update primary color + border tokens |
| `src/styles/index.scss` | Import `warm-theme.scss` |
| `layout/components/Sidebar/index.vue` | Rebuild with new shell |
| `layout/components/Navbar.vue` | Rebuild with breadcrumb + user chip |
| `layout/components/AppMain.vue` | Update background + padding |
| `layout/index.vue` | Update overall shell layout |

### Translate + Restyle (all views)

| View | Key changes |
|---|---|
| `views/login/index.vue` | Full redesign + English |
| `views/home/index.vue` | Stats cards + chart panels + English |
| `views/order/index.vue` | Filter bar + table + English |
| `views/category/index.vue` | Tabs + table + English |
| `views/dish/index.vue` | Filter bar + table + English |
| `views/dish/addDish.vue` | Two-col form + English |
| `views/setmeal/index.vue` | Table + English |
| `views/setmeal/addSetmeal.vue` | Form + dish picker + English |
| `views/employee/index.vue` | Filter + table + English |
| `views/employee/addEmployee.vue` | Form + English |
| `views/statistics/index.vue` | Chart panels + English |
| `views/inform/index.vue` | Notification cards + English |
| `views/error-page/404.vue` | English |

### Unchanged

- `src/api/` — all API modules
- `src/store/` — Vuex modules
- `src/router.ts` — route config
- `src/permission.ts` — auth guard
- `src/utils/` — utilities
- All component logic (only template + style sections change in views)

---

## 7. Out of Scope

- Vue 3 migration
- Switching UI library
- Backend changes
- Mobile/responsive redesign (desktop-first, min 1366px, same as current)
- New features or business logic changes
