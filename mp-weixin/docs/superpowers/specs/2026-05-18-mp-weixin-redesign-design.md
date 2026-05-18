# Sky Takeout — WeChat Mini Program Redesign

**Date:** 2026-05-18  
**Scope:** Full (all 11 pages) — WXSS redesign + Chinese → English translation  
**Design direction:** B — Vibrant Orange

---

## 1. Goals

- Translate all user-visible Chinese text to English across WXML, JS, and `app.json`
- Apply a cohesive Vibrant Orange visual theme matching energy of food-delivery apps (DoorDash / Uber Eats feel)
- Keep structural WXML changes to a minimum — files are compiled uni-app output and contain Vue artifacts (`data-v-*` scope IDs, `data-event-opts`, `bind:__l`) that make structural edits risky

---

## 2. Color & Typography System

### Primary palette

| Token | Value | Usage |
|---|---|---|
| `primary-start` | `#ff6b35` | Gradient start — header, CTA buttons |
| `primary-end` | `#f97316` | Gradient end — add-to-cart, active states |
| `primary-tint` | `#fff7ed` | Active category background, selected states |
| `text-primary` | `#2d2d2d` | Dish names, headings |
| `text-secondary` | `#9ca3af` | Descriptions, inactive tabs, hints |
| `page-bg` | `#f5f5f5` | Page and list backgrounds |
| `card-bg` | `#ffffff` | Dish cards, info cards |

### Status & accent

| Token | Value | Usage |
|---|---|---|
| `open-green` | `#22c55e` | "OPEN" badge, success states |
| `cart-badge` | `#ef4444` | Cart item count badge |
| `price-orange` | `#f97316` | All price text |

### Typography

| Element | Size | Weight | Color |
|---|---|---|---|
| Nav bar title | 17px | bold | white |
| Restaurant name | 20px | bold | white |
| Dish name | 14px | 600 | `#2d2d2d` |
| Price | 14px | bold | `#f97316` |
| Description / sold count | 12px | normal | `#9ca3af` |
| Section label | 11px | 600 caps | `#9ca3af` |

---

## 3. Architecture & Approach

### WXSS redesign (safe)
Each page has its own `.wxss` file with scoped selectors (e.g. `.home_content.data-v-57280228`). These files are completely rewritten with the new design tokens. Scope IDs are preserved verbatim in the selectors.

### WXML translation (text-only)
Only text node content changes — Chinese strings are replaced with English equivalents. No attribute names, class names, event bindings, or structural tags are modified.

### JS translation
Data arrays and string constants inside `.js` files are translated: tab names, status labels, order reason lists, dialog button text.

### app.json update
`navigationBarBackgroundColor` changes from `#E95F3C` to `#ff6b35` and `navigationBarTitleText` changes from `苍穹外卖` to `Sky Takeout`.

---

## 4. Pages

### 4.1 Home (`pages/index/`)

**Header (orange gradient):**
- Background: `linear-gradient(135deg, #ff6b35, #f97316)`
- Restaurant name: "Sky Restaurant" (white, 20px bold)
- Info bar (transparent white pill): "📍 1.5 km  🛵 $6 delivery  ⏱ ~12 min"
- Status badge: green pill "● OPEN" / red "● CLOSED"

**Category sidebar:**
- Active item: `#fff7ed` background, `2px solid #f97316` left border, `#f97316` text
- Inactive: white background, `#9ca3af` text

**Dish list cards:**
- White card, 8px border-radius, subtle shadow
- Image placeholder: `#ffe4d4` warm tint
- Add button (no spec selection): orange circle `+`
- Add button (has spec): "Choose Options" text in `#f97316`

**Cart bar:**
- Background: `#2d2d2d` (near-black)
- Cart icon with red badge for count
- Price: `#f97316` bold
- Checkout button: orange gradient pill "Checkout →"
- Empty state: "Add items to start your order"

**Translations:**
- `苍穹外卖` → Sky Takeout
- `营业中` → OPEN · `休息中` → CLOSED
- `月销量{{n}}` → Sold {{n}}+
- `选择规格` → Choose Options · `加入购物车` → (replaced by `+` button)
- `去结算` → Checkout · `购物车` → Cart · `清空` → Clear
- `该分类下暂无菜品` → No dishes in this category
- `本店已打样` → Restaurant is not accepting orders

### 4.2 Order Submission (`pages/order/`)

- Orange gradient page header "Checkout"
- White card sections: delivery address, restaurant items, fees
- Fees table: "Packaging fee", "Delivery fee", "Total"
- "Add a note" row (taps to remark page)
- "Utensils" row with stepper
- "Invoice" row
- Submit button: full-width orange gradient "Submit Order — ${{total}}"

**Translations:** `提交订单` → Submit Order, `请选择收货地址` → Select delivery address, `立即送出` → Dispatch now, `送达` → Estimated delivery, `展开更多` → Show more, `点击收起` → Show less, `打包费` → Packaging fee, `配送费` → Delivery fee, `合计` → Total, `备注` → Add a note, `餐具数量` → Utensils, `发票` → Invoice, `取消` → Cancel, `确定` → Confirm, `去支付` → Pay Now

### 4.3 Payment (`pages/pay/`)

- Orange gradient header
- Countdown timer for payment window
- Restaurant name and order items summary
- Large orange gradient button "Confirm Payment"

**Translations:** `订单已超时` → Order has expired, `支付剩余时间` → Time remaining to pay, `苍穹餐厅` → Sky Restaurant, `确认支付` → Confirm Payment

### 4.4 Order Success (`pages/success/`)

- Green check icon (or existing `success.png`)
- Heading: "Order Placed!"
- Sub-line: "Estimated delivery at {{arrivalTime}}"
- Description: "Your food is being prepared — hang tight!"
- Two buttons: "Back to Home" | "View Order"

**Translations:** `下单成功` → Order Placed!, `预计...送达` → Estimated delivery at {{arrivalTime}}, `后厨已开始疯狂备餐中，请耐心等待~` → Your food is being prepared — hang tight!, `返回首页` → Back to Home, `查看订单` → View Order

### 4.5 Order Details (`pages/details/`)

- Orange gradient header "Order Details"
- Status chip styles: pending (amber), delivering (blue), delivered (green), cancelled (grey)
- Action buttons by status: "Cancel Order", "Pay Now", "Remind Rider", "Request Refund", "Reorder"
- Fees and address card matching Order Submission styling
- Dialogs: phone call confirm ("Call now" / "Never mind"), refund confirm

**Translations:** `订单详情` → Order Details, `等待支付` → Awaiting Payment, `取消订单` → Cancel Order, `立即支付` → Pay Now, `催单` → Remind Rider, `申请退款` → Request Refund, `再来一单` → Reorder, `打包费/配送费/合计` → Packaging fee / Delivery fee / Total, `联系商家` → Contact Restaurant, `期望时间` → Expected time, `配送地址` → Delivery address, `订单号码` → Order number, `订单时间` → Order time, `支付方式` → Payment method, `餐具数量` → Utensils, `先等等` → Never mind, `拨打电话` → Call now, `取消` → Cancel, `呼叫` → Call, `退款成功` → Refund successful, `展开更多/点击收起` → Show more / Show less

### 4.6 Order History (`pages/historyOrder/`)

- Orange gradient header "Order History"
- Each order card: restaurant name, items, total, status chip
- Per-card actions: "Reorder", "Pay Now", "Remind Rider", "Confirm" (with dialog)

**Translations:** `历史订单` → Order History, `再来一单` → Reorder, `去支付` → Pay Now, `催单` → Remind Rider, `确认` → Confirm

### 4.7 My Profile (`pages/my/`)

- Orange gradient header with avatar area
- Menu rows: "Order History" (📦), "Saved Addresses" (📍)
- Recent order card with "Reorder" + "Pay Now" actions

**Translations:** `地址管理` → Saved Addresses, `历史订单` → Order History, `最近订单` → Recent Order, `再来一单` → Reorder, `去支付` → Pay Now

### 4.8 Saved Addresses (`pages/address/`)

- Orange gradient header "Saved Addresses"
- Address cards with "Set as default" action
- Empty state: "No saved addresses yet"
- FAB / bottom button: "+ Add New Address"

**Translations:** `地址管理` → Saved Addresses, `设为默认地址` → Set as default, `一个地址都没有哦` → No saved addresses yet, `新增收货地址` → Add New Address

### 4.9 Add / Edit Address (`pages/addOrEditAddress/`)

- Orange gradient header: "Edit Address" or "Add New Address"
- Form fields: Contact name, Phone number, City / District, Street address (detailed)
- Label chips: Home, Work, School, Other
- Orange gradient submit "Save Address"
- Destructive "Delete Address" button (red outline, only in edit mode)

**Translations:** `编辑收货地址` → Edit Address, `新增收货地址` → Add New Address, `联系人` → Contact name, `手机号` → Phone number, `收货地址` → Delivery address, `标签` → Label, `保存地址` → Save Address, `删除地址` → Delete Address, `省/市/区` → City / District, `详细地址（精确到门牌号）` → Street address (include floor / unit)

### 4.10 Order Remarks (`pages/remark/`)

- Orange gradient header "Order Notes"
- Textarea with English placeholder: "E.g. contactless delivery — leave at door, or call if gate is locked"
- Character counter `{{n}}/50`
- Orange gradient "Done" button

**Translations:** `订单备注` → Order Notes, placeholder → E.g. contactless delivery — leave at door, or call if gate is locked, `完成` → Done

### 4.11 Common Components

**`uni-nav-bar`** — nav bar `color="#ffffff"` (white title), `backgroundColor` changed to `#ff6b35` on all pages that use it.

---

## 5. JS Data Translations

| File | Key / array | Current | New |
|---|---|---|---|
| `pages/index/index.js` | tab labels | (if any Chinese) | English equivalents |
| `pages/order/index.js` | utensil count labels, dialog strings | Chinese | English |
| `pages/details/index.js` | `cancelOrderReasonList`, status strings | Chinese | English |
| `pages/historyOrder/historyOrder.js` | status labels, confirm dialog | Chinese | English |
| `pages/addOrEditAddress/addOrEditAddress.js` | label options, validation messages | Chinese | English |

---

## 6. Files Changed

| File | Change type |
|---|---|
| `app.json` | nav color + title |
| `pages/index/index.wxss` | full rewrite |
| `pages/index/index.wxml` | text translation |
| `pages/index/index.js` | data string translation |
| `pages/order/index.wxss` | full rewrite |
| `pages/order/index.wxml` | text translation |
| `pages/order/index.js` | data string translation |
| `pages/pay/index.wxss` | full rewrite |
| `pages/pay/index.wxml` | text translation |
| `pages/success/index.wxss` | full rewrite |
| `pages/success/index.wxml` | text translation |
| `pages/details/index.wxss` | full rewrite |
| `pages/details/index.wxml` | text translation |
| `pages/details/index.js` | data string translation |
| `pages/historyOrder/historyOrder.wxss` | full rewrite |
| `pages/historyOrder/historyOrder.wxml` | text translation |
| `pages/historyOrder/historyOrder.js` | data string translation |
| `pages/my/my.wxss` | full rewrite |
| `pages/my/my.wxml` | text translation |
| `pages/address/address.wxss` | full rewrite |
| `pages/address/address.wxml` | text translation |
| `pages/addOrEditAddress/addOrEditAddress.wxss` | full rewrite |
| `pages/addOrEditAddress/addOrEditAddress.wxml` | text translation |
| `pages/addOrEditAddress/addOrEditAddress.js` | data string translation |
| `pages/remark/index.wxss` | full rewrite |
| `pages/remark/index.wxml` | text translation |
| `common/main.wxss` | update global base styles if needed |

---

## 7. Out of Scope

- Structural WXML refactoring (compiled uni-app output)
- Backend API changes
- New pages or features
- Chinese strings inside `[一-龥]` input validation regex (functional, not user-visible)
