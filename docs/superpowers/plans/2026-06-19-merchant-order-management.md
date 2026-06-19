# Merchant Order Management Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Seed realistic orders across all statuses and implement the merchant-side order management API (search, statistics, detail, accept, reject, cancel, deliver, complete).

**Architecture:** Add merchant order endpoints in a new `admin/OrderController`, backed by new methods on `OrderService`/`OrderServiceImpl`, new `OrderMapper` query/update methods (annotation + XML), and an `OrderDetailMapper.getByOrderId`. State-transition logic is validated in the service and unit-tested with Mockito. Real WeChat Pay is out of scope; seeded orders are already paid.

**Tech Stack:** Java 8, Spring Boot 2.7.3, MyBatis, PageHelper, MySQL, JUnit 5 + Mockito (via `spring-boot-starter-test`).

## Global Constraints

- Module/paths: backend lives under `sky-take-out/sky-server` and `sky-take-out/sky-pojo`. All paths below are relative to repo root `/Users/huangbaoxi/Code/sky-take-out`.
- Reuse existing DTOs/VOs verbatim — do NOT create new ones: `OrdersPageQueryDTO`, `OrdersConfirmDTO`, `OrdersRejectionDTO`, `OrdersCancelDTO`, `OrderStatisticsVO`, `OrderVO`.
- Order status constants (from `com.sky.entity.Orders`): `PENDING_PAYMENT=1`, `TO_BE_CONFIRMED=2`, `CONFIRMED=3`, `DELIVERY_IN_PROGRESS=4`, `COMPLETED=5`, `CANCELLED=6`. Pay status: `UN_PAID=0`, `PAID=1`, `REFUND=2`.
- Error messages: use `MessageConstant.ORDER_STATUS_ERROR` and `MessageConstant.ORDER_NOT_FOUND`. Throw `com.sky.exception.OrderBusinessException`.
- Controller style: `@RestController("adminOrderController")`, `@RequestMapping("/admin/order")`, `@Api`, `@ApiOperation`, `@Slf4j`; return `com.sky.result.Result` / `Result<PageResult>`.
- DB connection for seeding/verification: `mysql -h127.0.0.1 -P3306 -uroot -pwzhhbx3480 sky_take_out`.
- Seedable FKs: `user.id = 4`, `address_book.id = 2`.
- Build/test command: `cd sky-take-out && mvn -q -pl sky-server -am test` (or a single test via `-Dtest=...`).

---

### Task 1: Seed simulated order data

**Files:**
- Create: `/tmp/gen_orders.py` (generator, not committed)
- Create: `db/seed-orders.sql` (committed)

**Interfaces:**
- Consumes: dishes seeded earlier (table `dish`, columns id/name/image/price), `user.id=4`, `address_book.id=2`.
- Produces: ~12 rows in `orders` + their `order_detail` rows, spread across statuses 2/3/4/5/6.

- [ ] **Step 1: Write the generator script**

Create `/tmp/gen_orders.py`:

```python
#!/usr/bin/env python3
"""Generate simulated orders (across statuses) referencing real seeded dishes."""
import subprocess, json, random, datetime

random.seed(42)
USER_ID = 4
ADDR_ID = 2
CONSIGNEE = "Alex Chen"
PHONE = "13712341234"
ADDRESS = "12345 Market Street, Apt 6"

def q(sql):
    out = subprocess.run(
        ["mysql", "-h127.0.0.1", "-P3306", "-uroot", "-pwzhhbx3480",
         "-N", "-B", "-e", sql, "sky_take_out"],
        capture_output=True, text=True)
    return [line.split("\t") for line in out.stdout.strip().splitlines()]

# pull 12 real dishes to compose orders from
dishes = q("SELECT id,name,image,price FROM dish WHERE image LIKE '%themealdb%' LIMIT 12;")
dishes = [(int(i), n, img, float(p)) for (i, n, img, p) in dishes]

# (status, pay_status, count, label)
SPREAD = [(2, 1, 4), (3, 1, 2), (4, 1, 2), (5, 1, 3), (6, 1, 1)]

def esc(s): return s.replace("'", "''")

now = datetime.datetime(2026, 6, 19, 12, 0, 0)
lines = [
    "-- Simulated orders seed data (covers all merchant-managed statuses)",
    "-- Idempotent: guarded by orders.number. Appends; does not modify existing rows.",
    "SET NAMES utf8mb4;", ""]

seq = 0
for status, pay_status, count in SPREAD:
    for _ in range(count):
        seq += 1
        otime = now - datetime.timedelta(hours=seq * 3)
        number = "SIM" + otime.strftime("%Y%m%d%H%M%S") + f"{seq:03d}"
        items = random.sample(dishes, k=random.choice([2, 3]))
        amount = round(sum(d[3] for d in items), 2)
        cancel_reason = "Out of stock" if status == 6 else None
        cancel_time = f"'{otime}'" if status == 6 else "NULL"
        delivery_time = f"'{otime}'" if status == 5 else "NULL"
        cr = f"'{esc(cancel_reason)}'" if cancel_reason else "NULL"
        lines.append(
            "INSERT INTO orders "
            "(number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,"
            "amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,"
            "estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)\n"
            f"SELECT '{number}',{status},{USER_ID},{ADDR_ID},'{otime}','{otime}',1,{pay_status},"
            f"{amount},'{PHONE}','{esc(ADDRESS)}','{esc(CONSIGNEE)}','WeChat User',{cr},{cancel_time},{delivery_time},"
            f"'{otime + datetime.timedelta(hours=1)}',1,2,2,1 FROM DUAL\n"
            f"WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='{number}');")
        for did, dname, dimg, dprice in items:
            lines.append(
                "INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)\n"
                f"SELECT '{esc(dname)}','{esc(dimg)}',(SELECT id FROM orders WHERE number='{number}' LIMIT 1),"
                f"{did},1,{dprice} FROM DUAL\n"
                f"WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id "
                f"WHERE o.number='{number}' AND od.name='{esc(dname)}');")
        lines.append("")

with open("/Users/huangbaoxi/Code/sky-take-out/db/seed-orders.sql", "w") as f:
    f.write("\n".join(lines) + "\n")
print(f"orders generated: {seq}")
```

- [ ] **Step 2: Run the generator**

Run: `python3 /tmp/gen_orders.py`
Expected: prints `orders generated: 12`, and `db/seed-orders.sql` exists.

- [ ] **Step 3: Execute the seed against the DB**

Run: `mysql -h127.0.0.1 -P3306 -uroot -pwzhhbx3480 sky_take_out < db/seed-orders.sql`
Expected: no errors.

- [ ] **Step 4: Verify the status spread**

Run: `mysql -h127.0.0.1 -P3306 -uroot -pwzhhbx3480 -N -e "SELECT status,COUNT(*) FROM orders GROUP BY status;" sky_take_out`
Expected: rows for status 2 (≥4), 3 (≥2), 4 (≥2), 5 (≥3), 6 (≥1).

- [ ] **Step 5: Commit**

```bash
git add db/seed-orders.sql
git commit -m "feat(db): add simulated order seed data across all statuses

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 2: Data access — OrderMapper & OrderDetailMapper

**Files:**
- Modify: `sky-take-out/sky-server/src/main/java/com/sky/mapper/OrderMapper.java`
- Modify: `sky-take-out/sky-server/src/main/resources/mapper/OrderMapper.xml`
- Modify: `sky-take-out/sky-server/src/main/java/com/sky/mapper/OrderDetailMapper.java`
- Test: `sky-take-out/sky-server/src/test/java/com/sky/mapper/OrderMapperIT.java`

**Interfaces:**
- Produces:
  - `Page<Orders> OrderMapper.pageQuery(OrdersPageQueryDTO)`
  - `Orders OrderMapper.getById(Long id)`
  - `void OrderMapper.update(Orders orders)`
  - `Integer OrderMapper.countStatus(Integer status)`
  - `List<OrderDetail> OrderDetailMapper.getByOrderId(Long orderId)`

- [ ] **Step 1: Write the failing integration test**

Create `sky-take-out/sky-server/src/test/java/com/sky/mapper/OrderMapperIT.java`:

```java
package com.sky.mapper;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sky.dto.OrdersPageQueryDTO;
import com.sky.entity.Orders;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional  // roll back DB changes after each test
class OrderMapperIT {

    @Autowired
    private OrderMapper orderMapper;

    @Test
    void countStatus_returnsNonNegative() {
        Integer n = orderMapper.countStatus(Orders.TO_BE_CONFIRMED);
        assertNotNull(n);
        assertTrue(n >= 0);
    }

    @Test
    void pageQuery_byStatus_returnsResults() {
        OrdersPageQueryDTO dto = new OrdersPageQueryDTO();
        dto.setStatus(Orders.TO_BE_CONFIRMED);
        PageHelper.startPage(1, 10);
        Page<Orders> page = orderMapper.pageQuery(dto);
        assertNotNull(page);
        page.getResult().forEach(o -> assertEquals(Orders.TO_BE_CONFIRMED, o.getStatus()));
    }

    @Test
    void update_changesStatus() {
        OrdersPageQueryDTO dto = new OrdersPageQueryDTO();
        dto.setStatus(Orders.TO_BE_CONFIRMED);
        PageHelper.startPage(1, 1);
        Orders existing = orderMapper.pageQuery(dto).getResult().get(0);

        Orders patch = new Orders();
        patch.setId(existing.getId());
        patch.setStatus(Orders.CONFIRMED);
        orderMapper.update(patch);

        assertEquals(Orders.CONFIRMED, orderMapper.getById(existing.getId()).getStatus());
    }
}
```

- [ ] **Step 2: Run the test to verify it fails to compile**

Run: `cd sky-take-out && mvn -q -pl sky-server -am test -Dtest=OrderMapperIT`
Expected: compilation failure — `pageQuery`, `getById`, `update`, `countStatus` not defined on `OrderMapper`.

- [ ] **Step 3: Add the mapper interface methods**

In `sky-take-out/sky-server/src/main/java/com/sky/mapper/OrderMapper.java`, add inside the interface (imports `com.github.pagehelper.Page`, `com.sky.dto.OrdersPageQueryDTO`, `org.apache.ibatis.annotations.Select`, `java.lang.Integer` already available):

```java
    /**
     * Paged conditional query for the admin order list.
     */
    Page<Orders> pageQuery(OrdersPageQueryDTO ordersPageQueryDTO);

    /**
     * Look up a single order by id.
     */
    @Select("select * from orders where id = #{id}")
    Orders getById(Long id);

    /**
     * Dynamic update of an order (status / reasons / times).
     */
    void update(Orders orders);

    /**
     * Count orders in a given status.
     */
    @Select("select count(id) from orders where status = #{status}")
    Integer countStatus(Integer status);
```

- [ ] **Step 4: Add the XML for pageQuery and update**

In `sky-take-out/sky-server/src/main/resources/mapper/OrderMapper.xml`, add before `</mapper>`:

```xml
    <select id="pageQuery" resultType="com.sky.entity.Orders">
        select * from orders
        <where>
            <if test="number != null and number != ''">and number like concat('%',#{number},'%')</if>
            <if test="phone != null and phone != ''">and phone like concat('%',#{phone},'%')</if>
            <if test="status != null">and status = #{status}</if>
            <if test="beginTime != null">and order_time &gt;= #{beginTime}</if>
            <if test="endTime != null">and order_time &lt;= #{endTime}</if>
            <if test="userId != null">and user_id = #{userId}</if>
        </where>
        order by order_time desc
    </select>

    <update id="update" parameterType="com.sky.entity.Orders">
        update orders
        <set>
            <if test="status != null">status = #{status},</if>
            <if test="payStatus != null">pay_status = #{payStatus},</if>
            <if test="cancelReason != null">cancel_reason = #{cancelReason},</if>
            <if test="rejectionReason != null">rejection_reason = #{rejectionReason},</if>
            <if test="cancelTime != null">cancel_time = #{cancelTime},</if>
            <if test="deliveryTime != null">delivery_time = #{deliveryTime},</if>
        </set>
        where id = #{id}
    </update>
```

- [ ] **Step 5: Add OrderDetailMapper.getByOrderId**

In `sky-take-out/sky-server/src/main/java/com/sky/mapper/OrderDetailMapper.java`, add (import `org.apache.ibatis.annotations.Select`, `java.util.List`):

```java
    /**
     * Get all line items for an order.
     */
    @Select("select * from order_detail where order_id = #{orderId}")
    List<OrderDetail> getByOrderId(Long orderId);
```

- [ ] **Step 6: Run the test to verify it passes**

Run: `cd sky-take-out && mvn -q -pl sky-server -am test -Dtest=OrderMapperIT`
Expected: PASS (3 tests). Requires MySQL running with seeded data from Task 1.

- [ ] **Step 7: Commit**

```bash
git add sky-take-out/sky-server/src/main/java/com/sky/mapper/OrderMapper.java \
        sky-take-out/sky-server/src/main/resources/mapper/OrderMapper.xml \
        sky-take-out/sky-server/src/main/java/com/sky/mapper/OrderDetailMapper.java \
        sky-take-out/sky-server/src/test/java/com/sky/mapper/OrderMapperIT.java
git commit -m "feat(order): add admin order mapper queries (pageQuery/getById/update/countStatus)

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 3: Service — read operations (statistics, details, conditionSearch)

**Files:**
- Modify: `sky-take-out/sky-server/src/main/java/com/sky/service/OrderService.java`
- Modify: `sky-take-out/sky-server/src/main/java/com/sky/service/impl/OrderServiceImpl.java`
- Test: `sky-take-out/sky-server/src/test/java/com/sky/service/OrderServiceReadTest.java`

**Interfaces:**
- Consumes: `OrderMapper.{pageQuery,getById,countStatus}`, `OrderDetailMapper.getByOrderId` (Task 2).
- Produces:
  - `OrderStatisticsVO OrderService.statistics()`
  - `OrderVO OrderService.details(Long id)`
  - `PageResult OrderService.conditionSearch(OrdersPageQueryDTO)`

- [ ] **Step 1: Write the failing test (Mockito)**

Create `sky-take-out/sky-server/src/test/java/com/sky/service/OrderServiceReadTest.java`:

```java
package com.sky.service;

import com.sky.entity.OrderDetail;
import com.sky.entity.Orders;
import com.sky.mapper.OrderDetailMapper;
import com.sky.mapper.OrderMapper;
import com.sky.service.impl.OrderServiceImpl;
import com.sky.vo.OrderStatisticsVO;
import com.sky.vo.OrderVO;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.Collections;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class OrderServiceReadTest {

    @Mock OrderMapper orderMapper;
    @Mock OrderDetailMapper orderDetailMapper;
    @InjectMocks OrderServiceImpl orderService;

    @Test
    void statistics_countsThreeActionableStatuses() {
        when(orderMapper.countStatus(Orders.TO_BE_CONFIRMED)).thenReturn(4);
        when(orderMapper.countStatus(Orders.CONFIRMED)).thenReturn(2);
        when(orderMapper.countStatus(Orders.DELIVERY_IN_PROGRESS)).thenReturn(1);

        OrderStatisticsVO vo = orderService.statistics();

        assertEquals(4, vo.getToBeConfirmed());
        assertEquals(2, vo.getConfirmed());
        assertEquals(1, vo.getDeliveryInProgress());
    }

    @Test
    void details_returnsOrderWithLineItems() {
        Orders o = new Orders();
        o.setId(7L);
        o.setStatus(Orders.CONFIRMED);
        OrderDetail d = new OrderDetail();
        d.setName("Clam chowder");
        d.setNumber(2);
        when(orderMapper.getById(7L)).thenReturn(o);
        when(orderDetailMapper.getByOrderId(7L)).thenReturn(Collections.singletonList(d));

        OrderVO vo = orderService.details(7L);

        assertEquals(7L, vo.getId());
        assertEquals(1, vo.getOrderDetailList().size());
        assertEquals("Clam chowder", vo.getOrderDetailList().get(0).getName());
    }
}
```

- [ ] **Step 2: Run the test to verify it fails to compile**

Run: `cd sky-take-out && mvn -q -pl sky-server -am test -Dtest=OrderServiceReadTest`
Expected: compilation failure — `statistics`, `details` not on `OrderService`.

- [ ] **Step 3: Declare the methods on the interface**

In `sky-take-out/sky-server/src/main/java/com/sky/service/OrderService.java`, add imports `com.sky.dto.OrdersPageQueryDTO`, `com.sky.vo.OrderStatisticsVO`, `com.sky.vo.OrderVO`, `com.sky.result.PageResult` (some already present) and these methods:

```java
    /** Counts of orders awaiting action. */
    OrderStatisticsVO statistics();

    /** Order detail with its line items. */
    OrderVO details(Long id);

    /** Paged conditional search for the admin order list. */
    PageResult conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO);
```

- [ ] **Step 4: Implement in OrderServiceImpl**

In `sky-take-out/sky-server/src/main/java/com/sky/service/impl/OrderServiceImpl.java`, ensure these fields exist (add if missing — `OrderMapper`/`OrderDetailMapper` are already autowired for `submitOrder`):

```java
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderDetailMapper orderDetailMapper;
```

Add imports: `com.sky.dto.OrdersPageQueryDTO`, `com.sky.vo.OrderStatisticsVO`, `com.sky.vo.OrderVO`, `com.sky.result.PageResult`, `com.sky.entity.OrderDetail`, `com.github.pagehelper.Page`, `com.github.pagehelper.PageHelper`, `org.springframework.beans.BeanUtils`, `java.util.List`, `java.util.ArrayList`, `java.util.stream.Collectors`. Add methods:

```java
    @Override
    public OrderStatisticsVO statistics() {
        OrderStatisticsVO vo = new OrderStatisticsVO();
        vo.setToBeConfirmed(orderMapper.countStatus(Orders.TO_BE_CONFIRMED));
        vo.setConfirmed(orderMapper.countStatus(Orders.CONFIRMED));
        vo.setDeliveryInProgress(orderMapper.countStatus(Orders.DELIVERY_IN_PROGRESS));
        return vo;
    }

    @Override
    public OrderVO details(Long id) {
        Orders order = orderMapper.getById(id);
        OrderVO orderVO = new OrderVO();
        BeanUtils.copyProperties(order, orderVO);
        orderVO.setOrderDetailList(orderDetailMapper.getByOrderId(id));
        return orderVO;
    }

    @Override
    public PageResult conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO) {
        PageHelper.startPage(ordersPageQueryDTO.getPage(), ordersPageQueryDTO.getPageSize());
        Page<Orders> page = orderMapper.pageQuery(ordersPageQueryDTO);

        List<OrderVO> list = new ArrayList<>();
        if (page != null && page.getResult() != null) {
            for (Orders orders : page.getResult()) {
                OrderVO orderVO = new OrderVO();
                BeanUtils.copyProperties(orders, orderVO);
                List<OrderDetail> details = orderDetailMapper.getByOrderId(orders.getId());
                orderVO.setOrderDetailList(details);
                String dishes = details.stream()
                        .map(d -> d.getName() + "*" + d.getNumber())
                        .collect(Collectors.joining("; "));
                orderVO.setOrderDishes(dishes);
                list.add(orderVO);
            }
        }
        return new PageResult(page == null ? 0 : page.getTotal(), list);
    }
```

- [ ] **Step 5: Run the test to verify it passes**

Run: `cd sky-take-out && mvn -q -pl sky-server -am test -Dtest=OrderServiceReadTest`
Expected: PASS (2 tests).

- [ ] **Step 6: Commit**

```bash
git add sky-take-out/sky-server/src/main/java/com/sky/service/OrderService.java \
        sky-take-out/sky-server/src/main/java/com/sky/service/impl/OrderServiceImpl.java \
        sky-take-out/sky-server/src/test/java/com/sky/service/OrderServiceReadTest.java
git commit -m "feat(order): merchant order read ops (statistics/details/conditionSearch)

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 4: Service — state transitions (confirm, rejection, cancel, delivery, complete)

**Files:**
- Modify: `sky-take-out/sky-server/src/main/java/com/sky/service/OrderService.java`
- Modify: `sky-take-out/sky-server/src/main/java/com/sky/service/impl/OrderServiceImpl.java`
- Test: `sky-take-out/sky-server/src/test/java/com/sky/service/OrderServiceTransitionTest.java`

**Interfaces:**
- Consumes: `OrderMapper.{getById,update}` (Task 2).
- Produces:
  - `void OrderService.confirm(OrdersConfirmDTO)`
  - `void OrderService.rejection(OrdersRejectionDTO)`
  - `void OrderService.cancel(OrdersCancelDTO)`
  - `void OrderService.delivery(Long id)`
  - `void OrderService.complete(Long id)`

- [ ] **Step 1: Write the failing test (Mockito)**

Create `sky-take-out/sky-server/src/test/java/com/sky/service/OrderServiceTransitionTest.java`:

```java
package com.sky.service;

import com.sky.dto.OrdersConfirmDTO;
import com.sky.dto.OrdersRejectionDTO;
import com.sky.entity.Orders;
import com.sky.exception.OrderBusinessException;
import com.sky.mapper.OrderMapper;
import com.sky.service.impl.OrderServiceImpl;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class OrderServiceTransitionTest {

    @Mock OrderMapper orderMapper;
    @InjectMocks OrderServiceImpl orderService;

    private Orders orderInStatus(int status) {
        Orders o = new Orders();
        o.setId(1L);
        o.setStatus(status);
        return o;
    }

    @Test
    void confirm_movesToConfirmed() {
        OrdersConfirmDTO dto = new OrdersConfirmDTO();
        dto.setId(1L);
        orderService.confirm(dto);

        ArgumentCaptor<Orders> cap = ArgumentCaptor.forClass(Orders.class);
        verify(orderMapper).update(cap.capture());
        assertEquals(Orders.CONFIRMED, cap.getValue().getStatus());
        assertEquals(1L, cap.getValue().getId());
    }

    @Test
    void delivery_fromConfirmed_movesToDelivering() {
        when(orderMapper.getById(1L)).thenReturn(orderInStatus(Orders.CONFIRMED));
        orderService.delivery(1L);
        ArgumentCaptor<Orders> cap = ArgumentCaptor.forClass(Orders.class);
        verify(orderMapper).update(cap.capture());
        assertEquals(Orders.DELIVERY_IN_PROGRESS, cap.getValue().getStatus());
    }

    @Test
    void delivery_fromWrongStatus_throws() {
        when(orderMapper.getById(1L)).thenReturn(orderInStatus(Orders.TO_BE_CONFIRMED));
        assertThrows(OrderBusinessException.class, () -> orderService.delivery(1L));
        verify(orderMapper, never()).update(any());
    }

    @Test
    void complete_fromDelivering_movesToCompleted() {
        when(orderMapper.getById(1L)).thenReturn(orderInStatus(Orders.DELIVERY_IN_PROGRESS));
        orderService.complete(1L);
        ArgumentCaptor<Orders> cap = ArgumentCaptor.forClass(Orders.class);
        verify(orderMapper).update(cap.capture());
        assertEquals(Orders.COMPLETED, cap.getValue().getStatus());
    }

    @Test
    void complete_fromWrongStatus_throws() {
        when(orderMapper.getById(1L)).thenReturn(orderInStatus(Orders.CONFIRMED));
        assertThrows(OrderBusinessException.class, () -> orderService.complete(1L));
    }

    @Test
    void rejection_fromToBeConfirmed_cancels() {
        when(orderMapper.getById(1L)).thenReturn(orderInStatus(Orders.TO_BE_CONFIRMED));
        OrdersRejectionDTO dto = new OrdersRejectionDTO();
        dto.setId(1L);
        dto.setRejectionReason("Too busy");
        orderService.rejection(dto);
        ArgumentCaptor<Orders> cap = ArgumentCaptor.forClass(Orders.class);
        verify(orderMapper).update(cap.capture());
        assertEquals(Orders.CANCELLED, cap.getValue().getStatus());
        assertEquals("Too busy", cap.getValue().getRejectionReason());
    }

    @Test
    void rejection_fromWrongStatus_throws() {
        when(orderMapper.getById(1L)).thenReturn(orderInStatus(Orders.CONFIRMED));
        OrdersRejectionDTO dto = new OrdersRejectionDTO();
        dto.setId(1L);
        assertThrows(OrderBusinessException.class, () -> orderService.rejection(dto));
    }
}
```

- [ ] **Step 2: Run the test to verify it fails to compile**

Run: `cd sky-take-out && mvn -q -pl sky-server -am test -Dtest=OrderServiceTransitionTest`
Expected: compilation failure — transition methods not on `OrderService`.

- [ ] **Step 3: Declare the methods on the interface**

In `OrderService.java`, add imports `com.sky.dto.OrdersConfirmDTO`, `com.sky.dto.OrdersRejectionDTO`, `com.sky.dto.OrdersCancelDTO` and:

```java
    /** Accept an order (TO_BE_CONFIRMED -> CONFIRMED). */
    void confirm(OrdersConfirmDTO ordersConfirmDTO);

    /** Reject a pending order (TO_BE_CONFIRMED -> CANCELLED). */
    void rejection(OrdersRejectionDTO ordersRejectionDTO);

    /** Cancel an order (-> CANCELLED). */
    void cancel(OrdersCancelDTO ordersCancelDTO);

    /** Start delivery (CONFIRMED -> DELIVERY_IN_PROGRESS). */
    void delivery(Long id);

    /** Complete an order (DELIVERY_IN_PROGRESS -> COMPLETED). */
    void complete(Long id);
```

- [ ] **Step 4: Implement in OrderServiceImpl**

Add imports `com.sky.dto.OrdersConfirmDTO`, `com.sky.dto.OrdersRejectionDTO`, `com.sky.dto.OrdersCancelDTO`, `com.sky.exception.OrderBusinessException`, `com.sky.constant.MessageConstant`, `java.time.LocalDateTime`. Add methods:

```java
    @Override
    public void confirm(OrdersConfirmDTO ordersConfirmDTO) {
        Orders order = Orders.builder()
                .id(ordersConfirmDTO.getId())
                .status(Orders.CONFIRMED)
                .build();
        orderMapper.update(order);
    }

    @Override
    public void rejection(OrdersRejectionDTO ordersRejectionDTO) {
        Orders order = orderMapper.getById(ordersRejectionDTO.getId());
        if (order == null) {
            throw new OrderBusinessException(MessageConstant.ORDER_NOT_FOUND);
        }
        if (!Orders.TO_BE_CONFIRMED.equals(order.getStatus())) {
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }
        Orders update = Orders.builder()
                .id(order.getId())
                .status(Orders.CANCELLED)
                .rejectionReason(ordersRejectionDTO.getRejectionReason())
                .cancelTime(LocalDateTime.now())
                .build();
        orderMapper.update(update);
    }

    @Override
    public void cancel(OrdersCancelDTO ordersCancelDTO) {
        Orders order = orderMapper.getById(ordersCancelDTO.getId());
        if (order == null) {
            throw new OrderBusinessException(MessageConstant.ORDER_NOT_FOUND);
        }
        Orders update = Orders.builder()
                .id(order.getId())
                .status(Orders.CANCELLED)
                .cancelReason(ordersCancelDTO.getCancelReason())
                .cancelTime(LocalDateTime.now())
                .build();
        orderMapper.update(update);
    }

    @Override
    public void delivery(Long id) {
        Orders order = orderMapper.getById(id);
        if (order == null) {
            throw new OrderBusinessException(MessageConstant.ORDER_NOT_FOUND);
        }
        if (!Orders.CONFIRMED.equals(order.getStatus())) {
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }
        Orders update = Orders.builder()
                .id(id)
                .status(Orders.DELIVERY_IN_PROGRESS)
                .build();
        orderMapper.update(update);
    }

    @Override
    public void complete(Long id) {
        Orders order = orderMapper.getById(id);
        if (order == null) {
            throw new OrderBusinessException(MessageConstant.ORDER_NOT_FOUND);
        }
        if (!Orders.DELIVERY_IN_PROGRESS.equals(order.getStatus())) {
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }
        Orders update = Orders.builder()
                .id(id)
                .status(Orders.COMPLETED)
                .deliveryTime(LocalDateTime.now())
                .build();
        orderMapper.update(update);
    }
```

NOTE: `Orders` uses Lombok `@Builder`. Verify the class has `@Builder` (it does in this project — `submitOrder` builds an `Orders`). If `@Builder` is absent, set fields via setters instead.

- [ ] **Step 5: Run the test to verify it passes**

Run: `cd sky-take-out && mvn -q -pl sky-server -am test -Dtest=OrderServiceTransitionTest`
Expected: PASS (7 tests).

- [ ] **Step 6: Commit**

```bash
git add sky-take-out/sky-server/src/main/java/com/sky/service/OrderService.java \
        sky-take-out/sky-server/src/main/java/com/sky/service/impl/OrderServiceImpl.java \
        sky-take-out/sky-server/src/test/java/com/sky/service/OrderServiceTransitionTest.java
git commit -m "feat(order): merchant order state transitions with status validation

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 5: Admin OrderController + end-to-end smoke test

**Files:**
- Create: `sky-take-out/sky-server/src/main/java/com/sky/controller/admin/OrderController.java`

**Interfaces:**
- Consumes: all `OrderService` methods from Tasks 3–4.
- Produces: 8 REST endpoints under `/admin/order`.

- [ ] **Step 1: Create the controller**

Create `sky-take-out/sky-server/src/main/java/com/sky/controller/admin/OrderController.java`:

```java
package com.sky.controller.admin;

import com.sky.dto.OrdersCancelDTO;
import com.sky.dto.OrdersConfirmDTO;
import com.sky.dto.OrdersPageQueryDTO;
import com.sky.dto.OrdersRejectionDTO;
import com.sky.result.PageResult;
import com.sky.result.Result;
import com.sky.service.OrderService;
import com.sky.vo.OrderStatisticsVO;
import com.sky.vo.OrderVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController("adminOrderController")
@RequestMapping("/admin/order")
@Api(tags = "Admin order management")
@Slf4j
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/conditionSearch")
    @ApiOperation("Search orders")
    public Result<PageResult> conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO) {
        log.info("admin order search: {}", ordersPageQueryDTO);
        return Result.success(orderService.conditionSearch(ordersPageQueryDTO));
    }

    @GetMapping("/statistics")
    @ApiOperation("Order count statistics")
    public Result<OrderStatisticsVO> statistics() {
        return Result.success(orderService.statistics());
    }

    @GetMapping("/details/{id}")
    @ApiOperation("Order detail")
    public Result<OrderVO> details(@PathVariable Long id) {
        return Result.success(orderService.details(id));
    }

    @PutMapping("/confirm")
    @ApiOperation("Accept order")
    public Result confirm(@RequestBody OrdersConfirmDTO ordersConfirmDTO) {
        orderService.confirm(ordersConfirmDTO);
        return Result.success();
    }

    @PutMapping("/rejection")
    @ApiOperation("Reject order")
    public Result rejection(@RequestBody OrdersRejectionDTO ordersRejectionDTO) {
        orderService.rejection(ordersRejectionDTO);
        return Result.success();
    }

    @PutMapping("/cancel")
    @ApiOperation("Cancel order")
    public Result cancel(@RequestBody OrdersCancelDTO ordersCancelDTO) {
        orderService.cancel(ordersCancelDTO);
        return Result.success();
    }

    @PutMapping("/delivery/{id}")
    @ApiOperation("Start delivery")
    public Result delivery(@PathVariable Long id) {
        orderService.delivery(id);
        return Result.success();
    }

    @PutMapping("/complete/{id}")
    @ApiOperation("Complete order")
    public Result complete(@PathVariable Long id) {
        orderService.complete(id);
        return Result.success();
    }
}
```

- [ ] **Step 2: Build the whole module**

Run: `cd sky-take-out && mvn -q -pl sky-server -am test`
Expected: all tests PASS (OrderMapperIT, OrderServiceReadTest, OrderServiceTransitionTest), build SUCCESS.

- [ ] **Step 3: Smoke-test the endpoints against the running app**

Start the app (`java -jar sky-server/target/sky-server-1.0-SNAPSHOT.jar` or via IDE), obtain an admin token by logging in, then:

```bash
# statistics
curl -s -H "token: <ADMIN_TOKEN>" "http://localhost:8080/admin/order/statistics"
# search pending orders
curl -s -H "token: <ADMIN_TOKEN>" "http://localhost:8080/admin/order/conditionSearch?page=1&pageSize=10&status=2"
# accept one (use an id from the search)
curl -s -X PUT -H "token: <ADMIN_TOKEN>" -H "Content-Type: application/json" \
  -d '{"id": <ID>}' "http://localhost:8080/admin/order/confirm"
```

Expected: statistics returns counts matching the seed; search returns paged orders with `orderDetailList` populated; confirm returns `{"code":1}` and the order's status becomes 3 in the DB. (Alternatively exercise via Knife4j at `http://localhost:8080/doc.html`.)

- [ ] **Step 4: Commit**

```bash
git add sky-take-out/sky-server/src/main/java/com/sky/controller/admin/OrderController.java
git commit -m "feat(order): add admin OrderController exposing order management endpoints

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

## Self-Review

**Spec coverage:**
- Part A simulated data → Task 1. ✓
- conditionSearch / statistics / details → Task 3. ✓
- confirm / rejection / cancel / delivery / complete → Task 4. ✓
- admin/OrderController 8 endpoints → Task 5. ✓
- Mapper additions → Task 2. ✓
- Status transition rules + error handling (OrderBusinessException + MessageConstant) → Task 4. ✓
- Testing (Mockito on service, manual smoke) → Tasks 3/4 (Mockito), Task 5 step 3 (manual). ✓
- Out-of-scope items (payment, user-side, reports, websocket) → not included. ✓

**Type consistency:** `pageQuery`/`getById`/`update`/`countStatus`/`getByOrderId` used identically in Tasks 2–4. Service signatures `statistics()`, `details(Long)`, `conditionSearch(OrdersPageQueryDTO)`, `confirm(OrdersConfirmDTO)`, `rejection(OrdersRejectionDTO)`, `cancel(OrdersCancelDTO)`, `delivery(Long)`, `complete(Long)` match between interface, impl, tests, and controller. ✓

**Open assumption flagged in-plan:** `Orders` has Lombok `@Builder` (Task 4 Step 4 note). If not, use setters.
