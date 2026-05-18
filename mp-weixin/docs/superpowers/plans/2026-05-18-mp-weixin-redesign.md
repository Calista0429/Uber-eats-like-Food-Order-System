# Sky Takeout Mini Program — Vibrant Orange Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Translate all Chinese text to English and apply the Vibrant Orange design theme across all 11 pages of the WeChat mini program.

**Architecture:** WXSS files are fully rewritten with the new color palette (targeted color substitutions — keep layout, change colors). WXML files receive text-only changes (Chinese string → English, no structural edits). JS compiled bundles receive targeted string substitutions in data arrays and status functions. `app.json` and `common/vendor.js` are changed first as shared foundations.

**Tech Stack:** WeChat Mini Program (WXML, WXSS, JS compiled webpack bundles), uni-app compiled output, scope IDs preserved verbatim.

---

## Color Token Reference

| Old | New | Role |
|---|---|---|
| `#ffc200`, `#ffb302` | `#f97316` | Primary orange (buttons, active states) |
| `#e94e3c` (on `color:`) | `#f97316` | Price text |
| `#e94e3c` (on `background`) | `#ef4444` | Cart badge background |
| `#1dc779` | `#22c55e` | Open/success green |
| `#f58c21`, `#f5932f` | `#f97316` | Info/hint orange |
| `#333333` nav bar bg | `#ff6b35` | Nav bar background |
| `rgba(0,0,0,0.9)` cart bar | `#2d2d2d` | Dark cart bar |
| `#473d26` | `#2d2d2d` | Dark element |
| `#666666` | `#9ca3af` | Secondary text |
| `#9b9b9b` | `#9ca3af` | Tertiary text |
| `#f3f4f7` | `#f5f5f5` | Sidebar/page bg |
| category active text `#333333` | `#ff6b35` | Active category label |

---

## Task 1: Foundations — app.json, common/Navbar, common/vendor.js

**Files:**
- Modify: `mp-weixin/app.json`
- Modify: `mp-weixin/pages/common/Navbar/navbar.wxml`
- Modify: `mp-weixin/common/vendor.js`

- [ ] **Step 1: Update app.json nav bar**

  Read `mp-weixin/app.json`, then edit:
  ```json
  "navigationBarTitleText": "Sky Takeout",
  "navigationBarBackgroundColor": "#ff6b35",
  ```

- [ ] **Step 2: Verify app.json**
  ```bash
  grep "navigationBar" mp-weixin/app.json
  ```
  Expected: `Sky Takeout` and `#ff6b35`.

- [ ] **Step 3: Translate common/Navbar/navbar.wxml**

  Read `mp-weixin/pages/common/Navbar/navbar.wxml`, then edit:
  - `个人中心` → `My Account`

- [ ] **Step 4: Translate status strings in common/vendor.js**

  Read `mp-weixin/common/vendor.js`, then apply these substitutions (each is unique in context):

  At line ~21135 (`statusWord` function, shared by my and historyOrder pages):
  ```js
  // old
  return '待付款';
  // new
  return 'Pending Payment';
  ```
  ```js
  // old
  return '已取消';
  // new
  return 'Cancelled';
  ```
  ```js
  // old
  return '待接单';
  // new
  return 'Order Received';
  ```
  ```js
  // old (case 3)
  return '待派送';
  // new
  return 'Preparing';
  ```
  ```js
  // old
  return '派送中';
  // new
  return 'On the Way';
  ```
  ```js
  // old
  return '已完成';
  // new
  return 'Delivered';
  ```
  ```js
  // old
  return '已退款';
  // new
  return 'Refunded';
  ```

  At line ~28555 (order details cancel handler):
  ```js
  // old
  _this3.textTip = '您的订单已取消！';
  // new
  _this3.textTip = 'Your order has been cancelled.';
  ```

  At line ~28567 (handleCancel else branch):
  ```js
  // old
  this.textTip = '请联系商家进行取消！';
  // new
  this.textTip = 'Please contact the restaurant to cancel.';
  ```

  At line ~28584 (details page `statusWord` method):
  ```js
  // old
  return '订单已取消';
  // new
  return 'Cancelled';
  ```
  ```js
  // old
  return '等待商户接单';
  // new
  return 'Awaiting Acceptance';
  ```
  ```js
  // old
  return '商家已接单';
  // new
  return 'Order Accepted';
  ```
  ```js
  // old
  return '订单派送中';
  // new
  return 'On the Way';
  ```
  ```js
  // old
  return '订单已完成';
  // new
  return 'Delivered';
  ```

- [ ] **Step 5: Verify vendor.js translations**
  ```bash
  grep -n "待付款\|已取消\|待接单\|派送中\|已完成\|您的订单已取消\|请联系商家\|订单已取消\|等待商户\|商家已接单\|订单派送\|订单已完成" mp-weixin/common/vendor.js
  ```
  Expected: 0 matches (all replaced).

- [ ] **Step 6: Commit**
  ```bash
  git add mp-weixin/app.json mp-weixin/pages/common/Navbar/navbar.wxml mp-weixin/common/vendor.js
  git commit -m "feat: translate app config and shared status strings to English"
  ```

---

## Task 2: Home page — pages/index/

**Files:**
- Modify: `mp-weixin/pages/index/index.wxss`
- Modify: `mp-weixin/pages/index/index.wxml`

Scope ID: `data-v-57280228`

- [ ] **Step 1: Rewrite home WXSS colors**

  Read `mp-weixin/pages/index/index.wxss`, then apply these edits (use Edit tool, one at a time for unique occurrences, or replace_all for repeated colors):

  **Replace all `#ffc200` → `#f97316`** (yellow buttons, active flavor, checkout button — use replace_all):
  ```
  old: #ffc200
  new: #f97316
  ```

  **Replace all `#ffb302` → `#f97316`** (flavor border):
  ```
  old: #ffb302
  new: #f97316
  ```

  **Replace price text color** (`color: #e94e3c` → `color: #f97316`, use replace_all):
  ```
  old: color: #e94e3c;
  new: color: #f97316;
  ```

  **Replace badge background** (`background-color: #e94e3c` → `background-color: #ef4444`):
  ```
  old: background-color: #e94e3c;
  new: background-color: #ef4444;
  ```

  **Replace open status green** (`#1dc779` → `#22c55e`):
  ```
  old: background: #1dc779;
  new: background: #22c55e;
  ```

  **Replace sidebar inactive text** (`color: #666666` → `color: #9ca3af`, replace_all):
  ```
  old: color: #666666;
  new: color: #9ca3af;
  ```

  **Replace sidebar bg** (`background-color: #f3f4f7` → `background-color: #f5f5f5`):
  ```
  old: background-color: #f3f4f7;
  new: background-color: #f5f5f5;
  ```

  **Replace secondary text** (`#9b9b9b` → `#9ca3af`, replace_all):
  ```
  old: color: #9b9b9b;
  new: color: #9ca3af;
  ```

  **Replace empty cart button** (`background-color: #d8d8d8` → `background-color: #9ca3af`):
  ```
  old: background-color: #d8d8d8;
  new: background-color: #9ca3af;
  ```

  **Replace active category text color** (the `.active` rule has `color: #333333;` — change to orange):
  ```
  old: .home_content .restaurant_menu_list .type_list .active.data-v-57280228 {
    color: #333333;
    background-color: #fff;
  new: .home_content .restaurant_menu_list .type_list .active.data-v-57280228 {
    color: #ff6b35;
    background-color: #fff7ed;
    border-left: 4rpx solid #ff6b35;
  ```

  **Replace dark cart bar** (`rgba(0, 0, 0, 0.9)` → `#2d2d2d`):
  ```
  old: background: rgba(0, 0, 0, 0.9);
  new: background: #2d2d2d;
  ```

- [ ] **Step 2: Verify WXSS — no old colors remain**
  ```bash
  grep -n "#ffc200\|#ffb302\|#e94e3c\|#1dc779\|#473d26" mp-weixin/pages/index/index.wxss
  ```
  Expected: 0 matches.

- [ ] **Step 3: Translate WXML — home page**

  Read `mp-weixin/pages/index/index.wxml`, then apply these text node substitutions:

  | Old | New |
  |---|---|
  | `苍穹外卖` | `Sky Takeout` |
  | `>营业中<` | `>OPEN<` |
  | `>休息中<` | `>CLOSED<` |
  | `距离1.5km` | `1.5 km away` |
  | `配送费6元` | `$6 delivery` |
  | `预计时长12min` | `~12 min` |
  | `月销量0` | `Sold 0` |
  | `>选择规格<` | `>Choose Options<` |
  | `>加入购物车<` | `>Add to Cart<` |
  | `>去结算<` | `>Checkout<` |
  | `>购物车<` | `>Cart<` |
  | `>清空<` | `>Clear<` |
  | `>该分类下暂无菜品<` | `>No dishes in this category<` |
  | `>本店已打样<` | `>Restaurant is currently closed<` |
  | `苍穹餐厅为顾客打造专业的大众化美食外送餐饮` | `Sky Restaurant — delivering quality food to your door` |
  | `北京市朝阳区新街大道一号楼8层` | `8F, Building 1, Xinhua Road, Chaoyang, Beijing` |

  Use the Edit tool for each substitution. Be careful to match exact surrounding context (e.g. include the `>` or `<` delimiters) to avoid changing template expressions like `{{}}`.

- [ ] **Step 4: Verify WXML — no Chinese text nodes remain**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/index/index.wxml | sort -u
  ```
  Expected: only `普通` (used as a JS function argument string — not user-visible text) and `购物车` (used as JS argument, not visible label) may remain if they appear in `data-event-opts`.

- [ ] **Step 5: Commit**
  ```bash
  git add mp-weixin/pages/index/index.wxss mp-weixin/pages/index/index.wxml
  git commit -m "feat: apply vibrant orange theme and translate home page"
  ```

---

## Task 3: Order submission — pages/order/

**Files:**
- Modify: `mp-weixin/pages/order/index.wxss`
- Modify: `mp-weixin/pages/order/index.wxml`

Scope ID: `data-v-0ca91b30`

- [ ] **Step 1: Rewrite order WXSS colors**

  Read `mp-weixin/pages/order/index.wxss`, then apply:

  **Replace all `#ffc200` → `#f97316`** (checkout button, border, radio):
  ```
  old: #ffc200
  new: #f97316
  (replace_all: true)
  ```

  **Replace order_but_left bg** (`#473d26` → `#2d2d2d`):
  ```
  old: background-color: #473d26;
  new: background-color: #2d2d2d;
  ```

  **Replace order_but_rit** (from yellow `#ffc200` — already replaced above; also its text color `#333333`):
  In the `.order_but_rit` rule, change `color: #333333` → `color: #ffffff`:
  ```
  old: .order_content .footer_order_buttom .order_but .order_but_rit.data-v-0ca91b30 {
    width: 200rpx;
    border-radius: 72rpx;
    background: #ffc200;
    font-size: 30rpx;
    font-family: PingFangSC, PingFangSC-Medium;
    font-weight: 500;
    color: #333333;
  new: .order_content .footer_order_buttom .order_but .order_but_rit.data-v-0ca91b30 {
    width: 200rpx;
    border-radius: 72rpx;
    background: linear-gradient(135deg, #ff6b35, #f97316);
    font-size: 30rpx;
    font-family: PingFangSC, PingFangSC-Medium;
    font-weight: 500;
    color: #ffffff;
  ```

  **Replace badge bg** (`background-color: #e94e3c` → `background-color: #ef4444`):
  ```
  old: background-color: #e94e3c;
  new: background-color: #ef4444;
  ```

  **Replace info tip** (`color: #f58c21` → `color: #f97316`, replace_all):
  ```
  old: color: #f58c21;
  new: color: #f97316;
  ```

  **Replace `#f5932f`** (picker selected color) → `#f97316`:
  ```
  old: color: #f5932f;
  new: color: #f97316;
  ```

  **Replace cart bg** (`rgba(0, 0, 0, 0.9)` → `#2d2d2d`):
  ```
  old: background: rgba(0, 0, 0, 0.9);
  new: background: #2d2d2d;
  ```

  **Replace submit button** (`.btnBox button.add_btn` has `background: #ffc200` — already replaced by global replace_all; also change `color: #333333` → `color: #ffffff` in that same rule):
  ```
  old: .btnBox button.add_btn.data-v-0ca91b30 {
    height: 86rpx;
    line-height: 86rpx;
    border-radius: 8rpx;
    background: #ffc200;
    border: 1px solid #ffc200;
    opacity: 1;
    font-size: 30rpx;
    font-family: PingFangSC, PingFangSC-Medium;
    font-weight: 600;
    text-align: center;
    color: #333333;
  new: .btnBox button.add_btn.data-v-0ca91b30 {
    height: 86rpx;
    line-height: 86rpx;
    border-radius: 8rpx;
    background: linear-gradient(135deg, #ff6b35, #f97316);
    border: none;
    opacity: 1;
    font-size: 30rpx;
    font-family: PingFangSC, PingFangSC-Medium;
    font-weight: 600;
    text-align: center;
    color: #ffffff;
  ```

  Fix the `:active` and `:visited` rule too:
  ```
  old: .btnBox button.add_btn.data-v-0ca91b30:active, .btnBox button.add_btn.data-v-0ca91b30:visited {
    background: #ffc200;
    border: 1px solid #ffc200;
    color: #333333;
  new: .btnBox button.add_btn.data-v-0ca91b30:active, .btnBox button.add_btn.data-v-0ca91b30:visited {
    background: linear-gradient(135deg, #ff6b35, #f97316);
    border: none;
    color: #ffffff;
  ```

- [ ] **Step 2: Verify order WXSS**
  ```bash
  grep -n "#ffc200\|#e94e3c\|#473d26\|#f58c21" mp-weixin/pages/order/index.wxss
  ```
  Expected: 0 matches.

- [ ] **Step 3: Translate order WXML**

  Read `mp-weixin/pages/order/index.wxml`, then apply:

  | Old | New |
  |---|---|
  | `title="提交订单"` | `title="Submit Order"` |
  | `>请选择收货地址<` | `>Select delivery address<` |
  | `>立即送出<` | `>Dispatch now<` |
  | `+"送达"}` | `+" delivery"}` |
  | `>苍穹餐厅<` | `>Sky Restaurant<` |
  | `'展开更多':'点击收起'` | `'Show more':'Show less'` |
  | `>打包费<` | `>Packaging fee<` |
  | `>配送费<` | `>Delivery fee<` |
  | `>合计<` | `>Total<` |
  | `title="备注"` | `title="Add a note"` |
  | `推荐使用无接触配送` (default remark placeholder) | `Contactless delivery recommended` |
  | `title="餐具数量"` | `title="Utensils"` |
  | `"已在店选择："` | `"Selected: "` |
  | `title="发票"` | `title="Invoice"` |
  | `>请联系商家提供<` | `>Please contact the restaurant<` |
  | `>按政府条例要求：<` | `>Per regulations:<` |
  | `>商家不得主动向您提供一次性餐具，请按需选择餐具数量<` | `>Restaurants may not proactively offer disposable utensils. Please select as needed.<` |
  | `>后续订单餐具设置<` | `>Default utensil preference<` |
  | `>取消<` (popup cancel button) | `>Cancel<` |
  | `>选择本单餐具<` | `>Choose utensils for this order<` |
  | `>确定<` | `>Confirm<` |
  | `>去支付<` | `>Pay Now<` |
  | `>为减少接触，降低风险，推荐使用无接触配送<` | `>To reduce contact risk, contactless delivery is recommended.<` |
  | `>因配送订单较多，送达时间可能波动<` | `>Actual delivery time may vary due to demand.<` |
  | `backgroundColor="#333333"` | `backgroundColor="#ff6b35"` |

- [ ] **Step 4: Verify order WXML**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/order/index.wxml | sort -u
  ```
  Expected: no user-visible Chinese strings.

- [ ] **Step 5: Commit**
  ```bash
  git add mp-weixin/pages/order/index.wxss mp-weixin/pages/order/index.wxml
  git commit -m "feat: apply vibrant orange theme and translate order submission page"
  ```

---

## Task 4: Payment page — pages/pay/

**Files:**
- Modify: `mp-weixin/pages/pay/index.wxss`
- Modify: `mp-weixin/pages/pay/index.wxml`
- Modify: `mp-weixin/pages/pay/index.js`

Scope ID: `data-v-32f2f1fc`

- [ ] **Step 1: Rewrite pay WXSS colors**

  Read `mp-weixin/pages/pay/index.wxss`, then apply:

  - `#ffc200` → `#f97316` (replace_all)
  - `color: #f58c21` → `color: #f97316` (replace_all)
  - `color: #f5932f` → `color: #f97316`
  - `color: #e94e3c` → `color: #f97316` (price text)
  - `.btnBox button.add_btn` rule: change `background: #ffc200; border: 1px solid #ffc200; color: #333333;` to `background: linear-gradient(135deg, #ff6b35, #f97316); border: none; color: #ffffff;`
  - `.btnBox button.add_btn:active, :visited` rule: same update
  - `rgba(0, 0, 0, 0.9)` → `#2d2d2d` if present

- [ ] **Step 2: Translate pay WXML**

  Read `mp-weixin/pages/pay/index.wxml`, then apply:

  | Old | New |
  |---|---|
  | `>订单已超时<` | `>Order has expired<` |
  | `>支付剩余时间<` | `>Time remaining to pay:<` |
  | `"苍穹餐厅-"` | `"Sky Restaurant — "` |
  | `>确认支付<` | `>Confirm Payment<` |

- [ ] **Step 3: Translate pay JS**

  Read `mp-weixin/pages/pay/index.js`, then apply:

  ```js
  // old
  payMethodList: ['微信支付'],
  // new
  payMethodList: ['WeChat Pay'],
  ```

- [ ] **Step 4: Verify**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/pay/index.wxml mp-weixin/pages/pay/index.js | sort -u
  grep -n "#ffc200\|#e94e3c" mp-weixin/pages/pay/index.wxss
  ```
  Expected: no Chinese in wxml/js, no old colors in wxss.

- [ ] **Step 5: Commit**
  ```bash
  git add mp-weixin/pages/pay/index.wxss mp-weixin/pages/pay/index.wxml mp-weixin/pages/pay/index.js
  git commit -m "feat: apply vibrant orange theme and translate payment page"
  ```

---

## Task 5: Order success page — pages/success/

**Files:**
- Modify: `mp-weixin/pages/success/index.wxss`
- Modify: `mp-weixin/pages/success/index.wxml`

Scope ID: `data-v-6fde291d`

The success page WXML (already read) contains:
```
下单成功  |  预计{{arrivalTime}}送达  |  后厨已开始疯狂备餐中, 请耐心等待~  |  返回首页  |  查看订单
```

- [ ] **Step 1: Rewrite success WXSS colors**

  Read `mp-weixin/pages/success/index.wxss`, apply:
  - `#ffc200` → `#f97316` (replace_all)
  - `color: #e94e3c` → `color: #f97316`
  - `background-color: #e94e3c` → `background-color: #ef4444`
  - `#1dc779` → `#22c55e`
  - `.btnBox button.add_btn` (if present): gradient + white text update

- [ ] **Step 2: Translate success WXML**

  Read `mp-weixin/pages/success/index.wxml`, apply:

  | Old | New |
  |---|---|
  | `>下单成功<` | `>Order Placed!<` |
  | `>预计<` | `>Estimated delivery<` |
  | `>送达<` | `><` (remove trailing text; arrivalTime already shows the time) |
  | `>后厨已开始疯狂备餐中, 请耐心等待~<` | `>Your food is being prepared — hang tight!<` |
  | `>返回首页<` | `>Back to Home<` |
  | `>查看订单<` | `>View Order<` |

  Note: The delivery line reads `预计<text class="word_date">{{arrivalTime}}</text>送达` — translate the static parts:
  - `预计` → `Estimated delivery at`
  - `送达` → `` (empty, or remove the text node if it would look odd)

- [ ] **Step 3: Verify**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/success/index.wxml | sort -u
  grep -n "#ffc200\|#e94e3c" mp-weixin/pages/success/index.wxss
  ```

- [ ] **Step 4: Commit**
  ```bash
  git add mp-weixin/pages/success/index.wxss mp-weixin/pages/success/index.wxml
  git commit -m "feat: apply vibrant orange theme and translate order success page"
  ```

---

## Task 6: Order details page — pages/details/

**Files:**
- Modify: `mp-weixin/pages/details/index.wxss`
- Modify: `mp-weixin/pages/details/index.wxml`

Scope ID: `data-v-54d3589c`

- [ ] **Step 1: Rewrite details WXSS colors**

  Read `mp-weixin/pages/details/index.wxss`, apply:
  - `#ffc200` → `#f97316` (replace_all)
  - `color: #e94e3c` → `color: #f97316`
  - `background-color: #e94e3c` → `background-color: #ef4444`
  - `color: #f58c21` → `color: #f97316` (replace_all)
  - `color: #f5932f` → `color: #f97316`
  - `rgba(0, 0, 0, 0.9)` → `#2d2d2d` (if present)
  - `#473d26` → `#2d2d2d` (if present)
  - `.btnBox button.add_btn`: gradient + white text (if present)
  - `backgroundColor="#333333"` in WXSS (unlikely but check)

- [ ] **Step 2: Translate details WXML**

  Read `mp-weixin/pages/details/index.wxml`, apply:

  | Old | New |
  |---|---|
  | `title="订单详情"` | `title="Order Details"` |
  | `backgroundColor="#333333"` | `backgroundColor="#ff6b35"` |
  | `>等待支付<` | `>Awaiting Payment<` |
  | `>等待支付：<` | `>Awaiting payment:<` |
  | `>取消订单<` | `>Cancel Order<` |
  | `>立即支付<` | `>Pay Now<` |
  | `>催单<` | `>Remind Rider<` |
  | `>申请退款<` | `>Request Refund<` |
  | `>再来一单<` | `>Reorder<` |
  | `>苍穹餐厅<` | `>Sky Restaurant<` |
  | `'展开更多':'点击收起'` | `'Show more':'Show less'` |
  | `>打包费<` | `>Packaging fee<` |
  | `>配送费<` | `>Delivery fee<` |
  | `>合计<` | `>Total<` |
  | `>联系商家<` | `>Contact Restaurant<` |
  | `>期望时间<` | `>Expected Time<` |
  | `>立即送出<` (delivery status) | `>Dispatch Now<` |
  | `>配送地址<` | `>Delivery Address<` |
  | `>订单号码<` | `>Order Number<` |
  | `>订单时间<` | `>Order Time<` |
  | `'微信':'支付宝'` | `'WeChat':'Alipay'` |
  | `>餐具数量<` | `>Utensils<` |
  | `>请在15分钟内完成支付，超时将自动取消。<` | `>Please pay within 15 minutes or the order will be cancelled.<` |
  | `>退款成功<` | `>Refund successful<` |
  | `>确认<` | `>Confirm<` |
  | `>先等等<` | `>Never mind<` |
  | `>拨打电话<` | `>Call now<` |
  | `>呼叫<` | `>Call<` |
  | `>取消<` | `>Cancel<` |

- [ ] **Step 3: Verify**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/details/index.wxml | sort -u
  grep -n "#ffc200\|#e94e3c\|#f58c21" mp-weixin/pages/details/index.wxss
  ```

- [ ] **Step 4: Commit**
  ```bash
  git add mp-weixin/pages/details/index.wxss mp-weixin/pages/details/index.wxml
  git commit -m "feat: apply vibrant orange theme and translate order details page"
  ```

---

## Task 7: Order history — pages/historyOrder/

**Files:**
- Modify: `mp-weixin/pages/historyOrder/historyOrder.wxss`
- Modify: `mp-weixin/pages/historyOrder/historyOrder.wxml`
- Modify: `mp-weixin/pages/historyOrder/historyOrder.js`

Scope ID: `data-v-5cf07246`

- [ ] **Step 1: Rewrite historyOrder WXSS colors**

  Read `mp-weixin/pages/historyOrder/historyOrder.wxss`, apply:
  - `#ffc200` → `#f97316` (replace_all)
  - `color: #e94e3c` → `color: #f97316`
  - `background-color: #e94e3c` → `background-color: #ef4444`
  - `color: #f58c21` → `color: #f97316`
  - `.new_btn.btn` rule: update button gradient (if present)
  - `backgroundColor="#333333"` not in wxss — handled in wxml

- [ ] **Step 2: Translate historyOrder WXML**

  Read `mp-weixin/pages/historyOrder/historyOrder.wxml`, apply:

  | Old | New |
  |---|---|
  | `title="历史订单"` | `title="Order History"` |
  | `backgroundColor="#333333"` | `backgroundColor="#ff6b35"` |
  | `>再来一单<` | `>Reorder<` |
  | `>去支付<` | `>Pay Now<` |
  | `>催单<` | `>Remind Rider<` |
  | `>确认<` | `>Confirm<` |
  | `{{"共"+item.m2.count+"件"}}` | `{{item.m2.count+" items"}}` |

- [ ] **Step 3: Translate historyOrder JS data**

  Read `mp-weixin/pages/historyOrder/historyOrder.js`, apply:

  ```js
  // old (line ~295)
  '全部订单', '待付款', '已取消'],
  // new
  'All Orders', 'Pending', 'Cancelled'],
  ```

  ```js
  // old (line ~357)
  uni.showLoading({ title: '加载中', mask: true });
  // new
  uni.showLoading({ title: 'Loading...', mask: true });
  ```

  ```js
  // old (line ~411)
  this.loadingText = '没有更多了';
  // new
  this.loadingText = 'No more orders';
  ```

  ```js
  // old (line ~420)
  this.loadingText = '数据加载中...';
  // new
  this.loadingText = 'Loading...';
  ```

  ```js
  // old (line ~438)
  _this3.textTip = '您的催单信息已发出！';
  // new
  _this3.textTip = 'Rider reminder sent!';
  ```

- [ ] **Step 4: Verify**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/historyOrder/historyOrder.wxml mp-weixin/pages/historyOrder/historyOrder.js | sort -u
  grep -n "#ffc200\|#e94e3c" mp-weixin/pages/historyOrder/historyOrder.wxss
  ```
  Expected: no user-visible Chinese. Comments in JS are OK.

- [ ] **Step 5: Commit**
  ```bash
  git add mp-weixin/pages/historyOrder/historyOrder.wxss mp-weixin/pages/historyOrder/historyOrder.wxml mp-weixin/pages/historyOrder/historyOrder.js
  git commit -m "feat: apply vibrant orange theme and translate order history page"
  ```

---

## Task 8: My profile — pages/my/

**Files:**
- Modify: `mp-weixin/pages/my/my.wxss`
- Modify: `mp-weixin/pages/my/my.wxml`

Scope ID: `data-v-0be17cc6`

The my.wxss has `.my_info` with `background-color: #ffc200` — replace with gradient.

- [ ] **Step 1: Rewrite my WXSS colors**

  Read `mp-weixin/pages/my/my.wxss`, apply:

  - `#ffc200` → `#f97316` (replace_all first)
  - Then specifically update `.my_info` background from solid to gradient:
    ```
    old: background-color: #ffc200;
    new: background: linear-gradient(135deg, #ff6b35, #f97316);
    ```
  - `color: #e94e3c` → `color: #f97316`
  - `background-color: #e94e3c` → `background-color: #ef4444`

  Note: `my.wxml` has `backgroundColor="#ffc200"` in the nav-bar — change in step 2.

- [ ] **Step 2: Translate my WXML**

  Read `mp-weixin/pages/my/my.wxml`, apply:

  | Old | New |
  |---|---|
  | `title="地址管理"` (nav bar title on my page) | `title="My Account"` |
  | `backgroundColor="#ffc200"` | `backgroundColor="#ff6b35"` |
  | `>地址管理<` (menu item text) | `>Saved Addresses<` |
  | `>历史订单<` | `>Order History<` |
  | `>最近订单<` | `>Recent Orders<` |
  | `>再来一单<` | `>Reorder<` |
  | `>去支付<` | `>Pay Now<` |
  | `item.$orig.consignee+' 男士'` | `item.$orig.consignee+' (M)'` |
  | `item.$orig.consignee+' 女士'` | `item.$orig.consignee+' (F)'` |
  | `{{"共"+item.m1.count+"件"}}` | `{{item.m1.count+" items"}}` |

- [ ] **Step 3: Verify**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/my/my.wxml | sort -u
  grep -n "#ffc200\|#e94e3c" mp-weixin/pages/my/my.wxss
  ```

- [ ] **Step 4: Commit**
  ```bash
  git add mp-weixin/pages/my/my.wxss mp-weixin/pages/my/my.wxml
  git commit -m "feat: apply vibrant orange theme and translate profile page"
  ```

---

## Task 9: Saved addresses — pages/address/

**Files:**
- Modify: `mp-weixin/pages/address/address.wxss`
- Modify: `mp-weixin/pages/address/address.wxml`

Scope ID: `data-v-db675620`

- [ ] **Step 1: Rewrite address WXSS colors**

  Read `mp-weixin/pages/address/address.wxss`, apply:
  - `#ffc200` → `#f97316` (replace_all)
  - `color: #e94e3c` → `color: #f97316`
  - `background-color: #e94e3c` → `background-color: #ef4444`
  - `.add_btn` rule: gradient + white text update

- [ ] **Step 2: Translate address WXML**

  Read `mp-weixin/pages/address/address.wxml`, apply:

  | Old | New |
  |---|---|
  | `title="地址管理"` | `title="Saved Addresses"` |
  | `backgroundColor="#333333"` | `backgroundColor="#ff6b35"` |
  | `item.$orig.consignee+' 男士'` | `item.$orig.consignee+' (M)'` |
  | `item.$orig.consignee+' 女士'` | `item.$orig.consignee+' (F)'` |
  | `>设为默认地址<` | `>Set as default<` |
  | `textLabel="一个地址都没有哦"` | `textLabel="No saved addresses yet"` |
  | `>新增收货地址<` | `>Add New Address<` |
  | `['编辑','$0']` | `['Edit','$0']` (JS event arg, not visible text — leave) |
  | `['新增']` | `['New']` (same) |

  Note: `编辑` and `新增` in `data-event-opts` are JS arguments, not displayed text. Leave those unchanged.

- [ ] **Step 3: Verify**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/address/address.wxml | sort -u
  grep -n "#ffc200\|#e94e3c" mp-weixin/pages/address/address.wxss
  ```

- [ ] **Step 4: Commit**
  ```bash
  git add mp-weixin/pages/address/address.wxss mp-weixin/pages/address/address.wxml
  git commit -m "feat: apply vibrant orange theme and translate addresses page"
  ```

---

## Task 10: Add/Edit address — pages/addOrEditAddress/

**Files:**
- Modify: `mp-weixin/pages/addOrEditAddress/addOrEditAddress.wxss`
- Modify: `mp-weixin/pages/addOrEditAddress/addOrEditAddress.wxml`
- Modify: `mp-weixin/pages/addOrEditAddress/addOrEditAddress.js`

Scope ID: `data-v-174d7646`

- [ ] **Step 1: Rewrite addOrEditAddress WXSS colors**

  Read `mp-weixin/pages/addOrEditAddress/addOrEditAddress.wxss`, apply:
  - `#ffc200` → `#f97316` (replace_all)
  - `color: #f58c21` → `color: #f97316`
  - `color: #f5932f` → `color: #f97316`
  - `color: #e94e3c` → `color: #f97316`
  - `.add_btn` rule: gradient + white text

- [ ] **Step 2: Translate addOrEditAddress WXML**

  Read `mp-weixin/pages/addOrEditAddress/addOrEditAddress.wxml`, apply:

  | Old | New |
  |---|---|
  | `'编辑收货地址':'新增收货地址'` | `'Edit Address':'Add New Address'` |
  | `backgroundColor="#333333"` | `backgroundColor="#ff6b35"` |
  | `>联系人:<` | `>Contact name:<` |
  | `placeholder="请填写收货人的姓名"` | `placeholder="Enter recipient's name"` |
  | `>手机号:<` | `>Phone number:<` |
  | `placeholder="请填写收货人手机号码"` | `placeholder="Enter recipient's phone number"` |
  | `>收货地址:<` | `>Delivery address:<` |
  | `"省/市/区"` | `"City / District"` |
  | `placeholder="详细地址（精确到门牌号）"` | `placeholder="Street address (include floor / unit)"` |
  | `>标签:<` | `>Label:<` |
  | `>保存地址<` | `>Save Address<` |
  | `>删除地址<` | `>Delete Address<` |

- [ ] **Step 3: Translate addOrEditAddress JS data arrays**

  Read `mp-weixin/pages/addOrEditAddress/addOrEditAddress.js`, apply:

  Gender options (lines ~340-344):
  ```js
  // old
  name: "先生" },
  // new
  name: "Mr." },
  ```
  ```js
  // old
  name: "女士" }],
  // new
  name: "Ms." }],
  ```

  Address label options (lines ~350-358):
  ```js
  // old
  name: "公司",
  // new
  name: "Work",
  ```
  ```js
  // old
  name: "家",
  // new
  name: "Home",
  ```
  ```js
  // old
  name: "学校",
  // new
  name: "School",
  ```

- [ ] **Step 4: Verify**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/addOrEditAddress/addOrEditAddress.wxml mp-weixin/pages/addOrEditAddress/addOrEditAddress.js | sort -u
  grep -n "#ffc200\|#e94e3c" mp-weixin/pages/addOrEditAddress/addOrEditAddress.wxss
  ```
  Expected: no user-visible Chinese.

- [ ] **Step 5: Commit**
  ```bash
  git add mp-weixin/pages/addOrEditAddress/addOrEditAddress.wxss mp-weixin/pages/addOrEditAddress/addOrEditAddress.wxml mp-weixin/pages/addOrEditAddress/addOrEditAddress.js
  git commit -m "feat: apply vibrant orange theme and translate add/edit address page"
  ```

---

## Task 11: Order remarks — pages/remark/

**Files:**
- Modify: `mp-weixin/pages/remark/index.wxss`
- Modify: `mp-weixin/pages/remark/index.wxml`

Scope ID: `data-v-27c0a608`

The remark WXML (already read) contains:
```
title="订单备注"  |  placeholder="无接触配送，..."  |  完成
```

- [ ] **Step 1: Rewrite remark WXSS colors**

  Read `mp-weixin/pages/remark/index.wxss`, apply:
  - `#ffc200` → `#f97316` (replace_all)
  - `color: #f58c21` → `color: #f97316`
  - `color: #e94e3c` → `color: #f97316`
  - `background-color: #e94e3c` → `background-color: #ef4444`
  - `.add_btn` rule: gradient + white text

- [ ] **Step 2: Translate remark WXML**

  Read `mp-weixin/pages/remark/index.wxml`, apply:

  | Old | New |
  |---|---|
  | `title="订单备注"` | `title="Order Notes"` |
  | `backgroundColor="#333333"` | `backgroundColor="#ff6b35"` |
  | `placeholder="无接触配送，将商品挂家门口或放前台，地址封闭管理时请电话联系"` | `placeholder="E.g. contactless delivery — leave at door, or call if gate is locked"` |
  | `>完成<` | `>Done<` |

- [ ] **Step 3: Verify**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/remark/index.wxml | sort -u
  grep -n "#ffc200\|#e94e3c" mp-weixin/pages/remark/index.wxss
  ```

- [ ] **Step 4: Commit**
  ```bash
  git add mp-weixin/pages/remark/index.wxss mp-weixin/pages/remark/index.wxml
  git commit -m "feat: apply vibrant orange theme and translate order notes page"
  ```

---

## Task 12: No-network page — pages/nonet/ + my.js loading text

**Files:**
- Modify: `mp-weixin/pages/nonet/index.wxss`
- Modify: `mp-weixin/pages/nonet/index.wxml`
- Modify: `mp-weixin/pages/my/my.js`

Scope ID: `data-v-751e51d6`

The nonet WXML contains: `网络无法连接` and `点击刷新`.

- [ ] **Step 1: Rewrite nonet WXSS colors**

  Read `mp-weixin/pages/nonet/index.wxss`, apply:
  - `#ffc200` → `#f97316` (replace_all)
  - `color: #e94e3c` → `color: #f97316`
  - `background-color: #e94e3c` → `background-color: #ef4444`
  - `.add_btn` / `.go_dish` buttons: gradient + white text if using old yellow

- [ ] **Step 2: Translate nonet WXML**

  Read `mp-weixin/pages/nonet/index.wxml`, apply:

  | Old | New |
  |---|---|
  | `>网络无法连接<` | `>No network connection<` |
  | `>点击刷新<` | `>Tap to refresh<` |

- [ ] **Step 3: Translate my.js loading text**

  Read `mp-weixin/pages/my/my.js`, apply:

  ```js
  // old (line ~413)
  this.loadingText = '没有更多了';
  // new
  this.loadingText = 'No more orders';
  ```

  ```js
  // old (line ~422)
  this.loadingText = '数据加载中...';
  // new
  this.loadingText = 'Loading...';
  ```

- [ ] **Step 4: Verify**
  ```bash
  grep -o '[一-龥]\+' mp-weixin/pages/nonet/index.wxml | sort -u
  grep -n "#ffc200\|#e94e3c" mp-weixin/pages/nonet/index.wxss
  grep -n '没有更多\|数据加载' mp-weixin/pages/my/my.js
  ```

- [ ] **Step 5: Commit**
  ```bash
  git add mp-weixin/pages/nonet/index.wxss mp-weixin/pages/nonet/index.wxml mp-weixin/pages/my/my.js
  git commit -m "feat: translate no-network page and my.js loading strings"
  ```

---

## Final Verification

After all tasks complete, run a full scan:

```bash
# Check for remaining Chinese in all WXML files
grep -rn --include="*.wxml" '[一-龥]' mp-weixin/pages/ | grep -v "data-event-opts" | grep -v "普通" | grep -v "购物车" | grep -v "编辑\|新增"

# Check for old color values across all WXSS files
grep -rn --include="*.wxss" "#ffc200\|#ffb302\|#e94e3c\|#1dc779\|#473d26\|#f58c21\|#f5932f" mp-weixin/pages/

# Check nav bar backgroundColor
grep -rn --include="*.wxml" 'backgroundColor="#333333"\|backgroundColor="#ffc200"' mp-weixin/pages/
```

All should return 0 matches.
