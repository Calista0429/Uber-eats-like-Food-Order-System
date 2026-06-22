# Data Statistics (Report + Workspace) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the admin data-statistics backend — Report (turnover/user/order trends, sales Top 10, Excel export) and Workspace (today's overview), plus 30 days of completed-order demo data.

**Architecture:** Trend stats build an inclusive per-day date list and query day-windowed aggregates, reusing the already-implemented `WorkspaceMapper`; a small new `ReportMapper` adds Top-10 and cumulative-user queries. `WorkspaceServiceImpl` fills in the existing `WorkspaceService` interface. Excel export reuses `WorkspaceService.getBusinessData` and writes an `XSSFWorkbook` to the response.

**Tech Stack:** Java 8, Spring Boot 2.7.3, MyBatis, Apache POI 3.16, commons-lang 2.6, JUnit 5 + Mockito.

## Global Constraints

- Paths relative to repo root `/Users/huangbaoxi/Code/sky-take-out`; backend under `sky-take-out/sky-server`, POJOs under `sky-take-out/sky-pojo`.
- **Build/test under JDK 1.8:** prefix every maven command with `JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_311.jdk/Contents/Home`. The machine default JDK breaks Lombok.
- Single-test command form: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test -Dtest=ClassName`
- Reuse existing VOs/DTOs verbatim — create none beyond the new mapper/service/controller files. VOs are Lombok `@Data @Builder @NoArgsConstructor @AllArgsConstructor` (use the builder).
- String-list VO fields are comma-joined via `org.apache.commons.lang.StringUtils.join(collection, ",")` (commons-lang **2.6**, NOT lang3).
- Controller style: `@RestController("adminXxxController")`, `@RequestMapping("/admin/...")`, `@Api`, `@ApiOperation`, `@Slf4j`; return `com.sky.result.Result` / `Result<T>`. Service impls: `@Service @Slf4j`.
- Order status COMPLETED = 5. `WorkspaceMapper.getTurnover`/`getValidOrderCount` already filter `status=5`.
- `WorkspaceMapper` (already implemented) signatures consumed: `BigDecimal getTurnover(LocalDateTime begin, LocalDateTime end)`, `Integer getValidOrderCount(LocalDateTime,LocalDateTime)`, `Integer getOrderCount(LocalDateTime,LocalDateTime)`, `Integer getNewUsers(LocalDateTime,LocalDateTime)`, `Integer getWaitingOrders()`, `getDeliveredOrders()`, `getCompletedOrders()`, `getCancelledOrders()`, `getAllOrders()`, `getSoldDishes()`, `getDiscontinuedDishes()`, `getSoldSetmeals()`, `getDiscontinuedSetmeals()`.
- DB for seed/verification: `mysql -h127.0.0.1 -P3306 -uroot -pwzhhbx3480 sky_take_out`. Seedable FKs: `user.id=4`, `address_book.id=2`.

---

### Task 1: Seed 30 days of completed orders

**Files:**
- Create: `/tmp/gen_history_orders.py` (not committed)
- Create: `db/seed-history-orders.sql` (committed)

**Interfaces:**
- Produces: ~60 `orders` rows (status=5) + their `order_detail`, `order_time` spread across the past 30 days.

- [ ] **Step 1: Write the generator**

Create `/tmp/gen_history_orders.py`:

```python
#!/usr/bin/env python3
"""Generate ~60 COMPLETED orders spread over the past 30 days, referencing real dishes."""
import subprocess, random, datetime

random.seed(7)
USER_ID, ADDR_ID = 4, 2
CONSIGNEE, PHONE, ADDRESS = "Alex Chen", "13712341234", "12345 Market Street, Apt 6"

def q(sql):
    out = subprocess.run(
        ["mysql","-h127.0.0.1","-P3306","-uroot","-pwzhhbx3480","-N","-B","-e",sql,"sky_take_out"],
        capture_output=True, text=True)
    return [l.split("\t") for l in out.stdout.strip().splitlines()]

dishes = q("SELECT id,name,image,price FROM dish WHERE image LIKE '%themealdb%' LIMIT 20;")
dishes = [(int(i), n, img, float(p)) for (i,n,img,p) in dishes]

def esc(s): return s.replace("'", "''")

today = datetime.date(2026, 6, 22)
lines = [
    "-- Historical COMPLETED orders (past 30 days) for statistics charts",
    "-- Idempotent: guarded by orders.number (prefix HIST). Appends only.",
    "SET NAMES utf8mb4;", ""]

seq = 0
for day_offset in range(1, 31):           # yesterday .. 30 days ago
    d = today - datetime.timedelta(days=day_offset)
    for _ in range(2):                    # ~2 orders/day -> ~60 total
        seq += 1
        otime = datetime.datetime(d.year, d.month, d.day,
                                  random.randint(10, 20), random.randint(0, 59), 0)
        dtime = otime + datetime.timedelta(hours=1)
        number = "HIST" + otime.strftime("%Y%m%d%H%M%S") + f"{seq:03d}"
        items = random.sample(dishes, k=random.choice([2, 3]))
        amount = round(sum(it[3] for it in items), 2)
        lines.append(
            "INSERT INTO orders "
            "(number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,"
            "amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,"
            "delivery_status,pack_amount,tableware_number,tableware_status)\n"
            f"SELECT '{number}',5,{USER_ID},{ADDR_ID},'{otime}','{otime}',1,1,"
            f"{amount},'{PHONE}','{esc(ADDRESS)}','{esc(CONSIGNEE)}','WeChat User','{dtime}','{dtime}',"
            f"1,2,2,1 FROM DUAL\n"
            f"WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='{number}');")
        for did, dname, dimg, dprice in items:
            lines.append(
                "INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)\n"
                f"SELECT '{esc(dname)}','{esc(dimg)}',(SELECT id FROM orders WHERE number='{number}' LIMIT 1),"
                f"{did},1,{dprice} FROM DUAL\n"
                f"WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id "
                f"WHERE o.number='{number}' AND od.name='{esc(dname)}');")
        lines.append("")

with open("/Users/huangbaoxi/Code/sky-take-out/db/seed-history-orders.sql","w") as f:
    f.write("\n".join(lines) + "\n")
print(f"history orders generated: {seq}")
```

- [ ] **Step 2: Run the generator**

Run: `python3 /tmp/gen_history_orders.py`
Expected: prints `history orders generated: 60`; `db/seed-history-orders.sql` exists.

- [ ] **Step 3: Execute the seed**

Run: `mysql -h127.0.0.1 -P3306 -uroot -pwzhhbx3480 sky_take_out < db/seed-history-orders.sql`
Expected: no errors.

- [ ] **Step 4: Verify spread across days**

Run: `mysql -h127.0.0.1 -P3306 -uroot -pwzhhbx3480 -N -e "SELECT COUNT(*) total, COUNT(DISTINCT DATE(order_time)) days FROM orders WHERE number LIKE 'HIST%';" sky_take_out`
Expected: total = 60, days = 30.

- [ ] **Step 5: Commit**

```bash
git add db/seed-history-orders.sql
git commit -m "feat(db): seed 30 days of completed orders for statistics

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 2: ReportMapper (Top 10 + cumulative users)

**Files:**
- Create: `sky-take-out/sky-server/src/main/java/com/sky/mapper/ReportMapper.java`
- Create: `sky-take-out/sky-server/src/main/resources/mapper/ReportMapper.xml`
- Test: `sky-take-out/sky-server/src/test/java/com/sky/mapper/ReportMapperIT.java`

**Interfaces:**
- Produces:
  - `List<GoodsSalesDTO> ReportMapper.getSalesTop10(LocalDateTime begin, LocalDateTime end)` (GoodsSalesDTO fields: `name`, `number`)
  - `Integer ReportMapper.getTotalUserCount(LocalDateTime end)`

- [ ] **Step 1: Write the failing integration test**

Create `sky-take-out/sky-server/src/test/java/com/sky/mapper/ReportMapperIT.java`:

```java
package com.sky.mapper;

import com.sky.dto.GoodsSalesDTO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class ReportMapperIT {

    @Autowired
    private ReportMapper reportMapper;

    @Test
    void getTotalUserCount_nonNegative() {
        Integer n = reportMapper.getTotalUserCount(LocalDateTime.now());
        assertNotNull(n);
        assertTrue(n >= 0);
    }

    @Test
    void getSalesTop10_atMostTenAndDescending() {
        LocalDateTime begin = LocalDateTime.now().minusDays(40);
        LocalDateTime end = LocalDateTime.now();
        List<GoodsSalesDTO> top = reportMapper.getSalesTop10(begin, end);
        assertNotNull(top);
        assertTrue(top.size() <= 10);
        for (int i = 1; i < top.size(); i++) {
            assertTrue(top.get(i - 1).getNumber() >= top.get(i).getNumber(),
                    "results must be sorted by number desc");
        }
    }
}
```

- [ ] **Step 2: Run the test to verify it fails to compile**

Run: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test -Dtest=ReportMapperIT`
Expected: compilation failure — `ReportMapper` does not exist.

- [ ] **Step 3: Create the mapper interface**

Create `sky-take-out/sky-server/src/main/java/com/sky/mapper/ReportMapper.java`:

```java
package com.sky.mapper;

import com.sky.dto.GoodsSalesDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface ReportMapper {

    /**
     * Top 10 best-selling goods (by quantity) among COMPLETED orders in the window.
     */
    List<GoodsSalesDTO> getSalesTop10(@Param("begin") LocalDateTime begin,
                                      @Param("end") LocalDateTime end);

    /**
     * Cumulative number of users created on or before the given instant.
     */
    @Select("select count(id) from user where create_time <= #{end}")
    Integer getTotalUserCount(LocalDateTime end);
}
```

- [ ] **Step 4: Create the mapper XML**

Create `sky-take-out/sky-server/src/main/resources/mapper/ReportMapper.xml`:

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="com.sky.mapper.ReportMapper">
    <select id="getSalesTop10" resultType="com.sky.dto.GoodsSalesDTO">
        select od.name name, sum(od.number) number
        from order_detail od
        join orders o on od.order_id = o.id
        where o.status = 5
          and o.order_time between #{begin} and #{end}
        group by od.name
        order by number desc
        limit 10
    </select>
</mapper>
```

- [ ] **Step 5: Run the test to verify it passes**

Run: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test -Dtest=ReportMapperIT`
Expected: PASS (2 tests). Requires MySQL up with the Task 1 seed.

- [ ] **Step 6: Commit**

```bash
git add sky-take-out/sky-server/src/main/java/com/sky/mapper/ReportMapper.java \
        sky-take-out/sky-server/src/main/resources/mapper/ReportMapper.xml \
        sky-take-out/sky-server/src/test/java/com/sky/mapper/ReportMapperIT.java
git commit -m "feat(report): add ReportMapper (sales top10, cumulative user count)

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 3: WorkspaceServiceImpl + WorkSpaceController

**Files:**
- Create: `sky-take-out/sky-server/src/main/java/com/sky/service/impl/WorkspaceServiceImpl.java`
- Create: `sky-take-out/sky-server/src/main/java/com/sky/controller/admin/WorkSpaceController.java`
- Test: `sky-take-out/sky-server/src/test/java/com/sky/service/WorkspaceServiceImplTest.java`

**Interfaces:**
- Consumes: existing `WorkspaceService` interface + `WorkspaceMapper`.
- Produces: `WorkspaceService` implementation; later tasks (Excel export) call `getBusinessData(LocalDateTime,LocalDateTime)`.

- [ ] **Step 1: Write the failing test (Mockito)**

Create `sky-take-out/sky-server/src/test/java/com/sky/service/WorkspaceServiceImplTest.java`:

```java
package com.sky.service;

import com.sky.mapper.WorkspaceMapper;
import com.sky.service.impl.WorkspaceServiceImpl;
import com.sky.vo.BusinessDataVO;
import com.sky.vo.OrderOverViewVO;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class WorkspaceServiceImplTest {

    @Mock WorkspaceMapper workspaceMapper;
    @InjectMocks WorkspaceServiceImpl workspaceService;

    @Test
    void getBusinessData_computesRateAndUnitPrice() {
        when(workspaceMapper.getTurnover(any(), any())).thenReturn(new BigDecimal("1000"));
        when(workspaceMapper.getOrderCount(any(), any())).thenReturn(20);
        when(workspaceMapper.getValidOrderCount(any(), any())).thenReturn(10);
        when(workspaceMapper.getNewUsers(any(), any())).thenReturn(5);

        BusinessDataVO vo = workspaceService.getBusinessData(LocalDateTime.now(), LocalDateTime.now());

        assertEquals(1000.0, vo.getTurnover());
        assertEquals(10, vo.getValidOrderCount());
        assertEquals(0.5, vo.getOrderCompletionRate());
        assertEquals(100.0, vo.getUnitPrice());
        assertEquals(5, vo.getNewUsers());
    }

    @Test
    void getBusinessData_zeroOrders_noDivByZero() {
        when(workspaceMapper.getTurnover(any(), any())).thenReturn(null);
        when(workspaceMapper.getOrderCount(any(), any())).thenReturn(0);
        when(workspaceMapper.getValidOrderCount(any(), any())).thenReturn(0);
        when(workspaceMapper.getNewUsers(any(), any())).thenReturn(0);

        BusinessDataVO vo = workspaceService.getBusinessData(LocalDateTime.now(), LocalDateTime.now());

        assertEquals(0.0, vo.getTurnover());
        assertEquals(0.0, vo.getOrderCompletionRate());
        assertEquals(0.0, vo.getUnitPrice());
    }

    @Test
    void getOverviewOrders_mapsCounts() {
        when(workspaceMapper.getWaitingOrders()).thenReturn(1);
        when(workspaceMapper.getDeliveredOrders()).thenReturn(2);
        when(workspaceMapper.getCompletedOrders()).thenReturn(3);
        when(workspaceMapper.getCancelledOrders()).thenReturn(4);
        when(workspaceMapper.getAllOrders()).thenReturn(10);

        OrderOverViewVO vo = workspaceService.getOverviewOrders();

        assertEquals(1, vo.getWaitingOrders());
        assertEquals(2, vo.getDeliveredOrders());
        assertEquals(3, vo.getCompletedOrders());
        assertEquals(4, vo.getCancelledOrders());
        assertEquals(10, vo.getAllOrders());
    }
}
```

- [ ] **Step 2: Run the test to verify it fails to compile**

Run: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test -Dtest=WorkspaceServiceImplTest`
Expected: compilation failure — `WorkspaceServiceImpl` does not exist.

- [ ] **Step 3: Create WorkspaceServiceImpl**

Create `sky-take-out/sky-server/src/main/java/com/sky/service/impl/WorkspaceServiceImpl.java`:

```java
package com.sky.service.impl;

import com.sky.dto.DataOverViewQueryDTO;
import com.sky.mapper.WorkspaceMapper;
import com.sky.service.WorkspaceService;
import com.sky.vo.BusinessDataVO;
import com.sky.vo.DishOverViewVO;
import com.sky.vo.OrderOverViewVO;
import com.sky.vo.SetmealOverViewVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
@Slf4j
public class WorkspaceServiceImpl implements WorkspaceService {

    @Autowired
    private WorkspaceMapper workspaceMapper;

    @Override
    public BusinessDataVO getBusinessData(LocalDateTime begin, LocalDateTime end) {
        BigDecimal turnoverBd = workspaceMapper.getTurnover(begin, end);
        double turnover = turnoverBd == null ? 0.0 : turnoverBd.doubleValue();
        Integer totalOrders = workspaceMapper.getOrderCount(begin, end);
        Integer validOrders = workspaceMapper.getValidOrderCount(begin, end);
        Integer newUsers = workspaceMapper.getNewUsers(begin, end);

        double completionRate = (totalOrders == null || totalOrders == 0)
                ? 0.0 : validOrders.doubleValue() / totalOrders;
        double unitPrice = (validOrders == null || validOrders == 0)
                ? 0.0 : turnover / validOrders;

        return BusinessDataVO.builder()
                .turnover(turnover)
                .validOrderCount(validOrders == null ? 0 : validOrders)
                .orderCompletionRate(completionRate)
                .unitPrice(unitPrice)
                .newUsers(newUsers == null ? 0 : newUsers)
                .build();
    }

    @Override
    public OrderOverViewVO getOverviewOrders() {
        return OrderOverViewVO.builder()
                .waitingOrders(workspaceMapper.getWaitingOrders())
                .deliveredOrders(workspaceMapper.getDeliveredOrders())
                .completedOrders(workspaceMapper.getCompletedOrders())
                .cancelledOrders(workspaceMapper.getCancelledOrders())
                .allOrders(workspaceMapper.getAllOrders())
                .build();
    }

    @Override
    public DishOverViewVO getOverviewDishes() {
        return DishOverViewVO.builder()
                .sold(workspaceMapper.getSoldDishes())
                .discontinued(workspaceMapper.getDiscontinuedDishes())
                .build();
    }

    @Override
    public SetmealOverViewVO getOverviewSetmeals() {
        return SetmealOverViewVO.builder()
                .sold(workspaceMapper.getSoldSetmeals())
                .discontinued(workspaceMapper.getDiscontinuedSetmeals())
                .build();
    }
}
```

Note: `DataOverViewQueryDTO` import is present because the interface signature for `getBusinessData` in `WorkspaceService` may declare it. CHECK the existing interface: it declares `getBusinessData(DataOverViewQueryDTO)`. **If so**, change the impl signature to `getBusinessData(DataOverViewQueryDTO dto)` and read `dto.getBegin()/dto.getEnd()`, and update the test to pass a `DataOverViewQueryDTO` (begin/end set via builder or setters). Match the existing interface exactly — do not change the interface.

- [ ] **Step 4: Reconcile getBusinessData signature with the interface**

Open `sky-take-out/sky-server/src/main/java/com/sky/service/WorkspaceService.java`. The declared signature is `BusinessDataVO getBusinessData(DataOverViewQueryDTO dataOverViewQueryDTO)`. Adjust the impl and the test to that signature:
- Impl: `public BusinessDataVO getBusinessData(DataOverViewQueryDTO dto)` and use `LocalDateTime begin = dto.getBegin(); LocalDateTime end = dto.getEnd();`.
- Test: build the arg as `DataOverViewQueryDTO dto = DataOverViewQueryDTO.builder().begin(LocalDateTime.now()).end(LocalDateTime.now()).build();` (if `@Builder` absent, use setters), and call `workspaceService.getBusinessData(dto)`.

(If, contrary to the above, the interface actually declares two `LocalDateTime` params, keep the Step-3 version. The interface is the source of truth.)

- [ ] **Step 5: Run the test to verify it passes**

Run: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test -Dtest=WorkspaceServiceImplTest`
Expected: PASS (3 tests).

- [ ] **Step 6: Create WorkSpaceController**

Create `sky-take-out/sky-server/src/main/java/com/sky/controller/admin/WorkSpaceController.java`:

```java
package com.sky.controller.admin;

import com.sky.dto.DataOverViewQueryDTO;
import com.sky.result.Result;
import com.sky.service.WorkspaceService;
import com.sky.vo.BusinessDataVO;
import com.sky.vo.DishOverViewVO;
import com.sky.vo.OrderOverViewVO;
import com.sky.vo.SetmealOverViewVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.LocalTime;

@RestController("adminWorkSpaceController")
@RequestMapping("/admin/workspace")
@Api(tags = "Admin workspace")
@Slf4j
public class WorkSpaceController {

    @Autowired
    private WorkspaceService workspaceService;

    @GetMapping("/businessData")
    @ApiOperation("Today's business data")
    public Result<BusinessDataVO> businessData() {
        LocalDateTime begin = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);
        LocalDateTime end = LocalDateTime.of(LocalDate.now(), LocalTime.MAX);
        DataOverViewQueryDTO dto = new DataOverViewQueryDTO();
        dto.setBegin(begin);
        dto.setEnd(end);
        return Result.success(workspaceService.getBusinessData(dto));
    }

    @GetMapping("/overviewOrders")
    @ApiOperation("Order overview")
    public Result<OrderOverViewVO> overviewOrders() {
        return Result.success(workspaceService.getOverviewOrders());
    }

    @GetMapping("/overviewDishes")
    @ApiOperation("Dish overview")
    public Result<DishOverViewVO> overviewDishes() {
        return Result.success(workspaceService.getOverviewDishes());
    }

    @GetMapping("/overviewSetmeals")
    @ApiOperation("Setmeal overview")
    public Result<SetmealOverViewVO> overviewSetmeals() {
        return Result.success(workspaceService.getOverviewSetmeals());
    }
}
```

Add the missing import `import java.time.LocalDate;` at the top. (If the interface used two `LocalDateTime` params instead of the DTO, call `workspaceService.getBusinessData(begin, end)` directly and drop the DTO lines.)

- [ ] **Step 7: Build the module to verify controller compiles**

Run: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test -Dtest=WorkspaceServiceImplTest`
Expected: PASS, build SUCCESS (controller compiled as part of the module).

- [ ] **Step 8: Commit**

```bash
git add sky-take-out/sky-server/src/main/java/com/sky/service/impl/WorkspaceServiceImpl.java \
        sky-take-out/sky-server/src/main/java/com/sky/controller/admin/WorkSpaceController.java \
        sky-take-out/sky-server/src/test/java/com/sky/service/WorkspaceServiceImplTest.java
git commit -m "feat(workspace): implement workspace service + controller

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 4: ReportService stats + ReportController

**Files:**
- Create: `sky-take-out/sky-server/src/main/java/com/sky/service/ReportService.java`
- Create: `sky-take-out/sky-server/src/main/java/com/sky/service/impl/ReportServiceImpl.java`
- Create: `sky-take-out/sky-server/src/main/java/com/sky/controller/admin/ReportController.java`
- Test: `sky-take-out/sky-server/src/test/java/com/sky/service/ReportServiceImplTest.java`

**Interfaces:**
- Consumes: `WorkspaceMapper` (turnover/order/user aggregates), `ReportMapper.getSalesTop10/getTotalUserCount` (Task 2).
- Produces (on `ReportService`):
  - `TurnoverReportVO turnoverStatistics(LocalDate begin, LocalDate end)`
  - `UserReportVO userStatistics(LocalDate begin, LocalDate end)`
  - `OrderReportVO ordersStatistics(LocalDate begin, LocalDate end)`
  - `SalesTop10ReportVO top10(LocalDate begin, LocalDate end)`

- [ ] **Step 1: Write the failing test (Mockito)**

Create `sky-take-out/sky-server/src/test/java/com/sky/service/ReportServiceImplTest.java`:

```java
package com.sky.service;

import com.sky.dto.GoodsSalesDTO;
import com.sky.mapper.ReportMapper;
import com.sky.mapper.WorkspaceMapper;
import com.sky.service.impl.ReportServiceImpl;
import com.sky.vo.OrderReportVO;
import com.sky.vo.SalesTop10ReportVO;
import com.sky.vo.TurnoverReportVO;
import com.sky.vo.UserReportVO;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ReportServiceImplTest {

    @Mock WorkspaceMapper workspaceMapper;
    @Mock ReportMapper reportMapper;
    @InjectMocks ReportServiceImpl reportService;

    @Test
    void turnoverStatistics_threeDays() {
        when(workspaceMapper.getTurnover(any(), any())).thenReturn(new BigDecimal("100"));
        TurnoverReportVO vo = reportService.turnoverStatistics(
                LocalDate.of(2026, 6, 1), LocalDate.of(2026, 6, 3));
        assertEquals("2026-06-01,2026-06-02,2026-06-03", vo.getDateList());
        assertEquals("100.0,100.0,100.0", vo.getTurnoverList());
    }

    @Test
    void ordersStatistics_computesTotalsAndRate() {
        when(workspaceMapper.getOrderCount(any(), any())).thenReturn(10);
        when(workspaceMapper.getValidOrderCount(any(), any())).thenReturn(6);
        OrderReportVO vo = reportService.ordersStatistics(
                LocalDate.of(2026, 6, 1), LocalDate.of(2026, 6, 2));
        assertEquals(20, vo.getTotalOrderCount());
        assertEquals(12, vo.getValidOrderCount());
        assertEquals(0.6, vo.getOrderCompletionRate());
    }

    @Test
    void userStatistics_usesCumulativeAndNew() {
        when(workspaceMapper.getNewUsers(any(), any())).thenReturn(2);
        when(reportMapper.getTotalUserCount(any())).thenReturn(100);
        UserReportVO vo = reportService.userStatistics(
                LocalDate.of(2026, 6, 1), LocalDate.of(2026, 6, 2));
        assertEquals("2026-06-01,2026-06-02", vo.getDateList());
        assertEquals("100,100", vo.getTotalUserList());
        assertEquals("2,2", vo.getNewUserList());
    }

    @Test
    void top10_splitsNamesAndNumbers() {
        when(reportMapper.getSalesTop10(any(), any())).thenReturn(Arrays.asList(
                GoodsSalesDTO.builder().name("Pizza").number(9).build(),
                GoodsSalesDTO.builder().name("Burger").number(4).build()));
        SalesTop10ReportVO vo = reportService.top10(
                LocalDate.of(2026, 6, 1), LocalDate.of(2026, 6, 2));
        assertEquals("Pizza,Burger", vo.getNameList());
        assertEquals("9,4", vo.getNumberList());
    }
}
```

Note: `GoodsSalesDTO` is `@Data @Builder` in this project; if its builder is unavailable, construct with `new GoodsSalesDTO()` + setters.

- [ ] **Step 2: Run the test to verify it fails to compile**

Run: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test -Dtest=ReportServiceImplTest`
Expected: compilation failure — `ReportService` / `ReportServiceImpl` do not exist.

- [ ] **Step 3: Create the ReportService interface**

Create `sky-take-out/sky-server/src/main/java/com/sky/service/ReportService.java`:

```java
package com.sky.service;

import com.sky.vo.OrderReportVO;
import com.sky.vo.SalesTop10ReportVO;
import com.sky.vo.TurnoverReportVO;
import com.sky.vo.UserReportVO;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;

public interface ReportService {

    TurnoverReportVO turnoverStatistics(LocalDate begin, LocalDate end);

    UserReportVO userStatistics(LocalDate begin, LocalDate end);

    OrderReportVO ordersStatistics(LocalDate begin, LocalDate end);

    SalesTop10ReportVO top10(LocalDate begin, LocalDate end);

    /** Write a business-data Excel report to the response (implemented in Task 5). */
    void exportBusinessData(HttpServletResponse response);
}
```

- [ ] **Step 4: Create ReportServiceImpl (stats methods; export stub for now)**

Create `sky-take-out/sky-server/src/main/java/com/sky/service/impl/ReportServiceImpl.java`:

```java
package com.sky.service.impl;

import com.sky.dto.GoodsSalesDTO;
import com.sky.mapper.ReportMapper;
import com.sky.mapper.WorkspaceMapper;
import com.sky.service.ReportService;
import com.sky.vo.OrderReportVO;
import com.sky.vo.SalesTop10ReportVO;
import com.sky.vo.TurnoverReportVO;
import com.sky.vo.UserReportVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ReportServiceImpl implements ReportService {

    @Autowired
    private WorkspaceMapper workspaceMapper;
    @Autowired
    private ReportMapper reportMapper;

    private List<LocalDate> buildDateList(LocalDate begin, LocalDate end) {
        List<LocalDate> dates = new ArrayList<>();
        LocalDate d = begin;
        while (!d.isAfter(end)) {
            dates.add(d);
            d = d.plusDays(1);
        }
        return dates;
    }

    private LocalDateTime dayStart(LocalDate d) { return LocalDateTime.of(d, LocalTime.MIN); }
    private LocalDateTime dayEnd(LocalDate d) { return LocalDateTime.of(d, LocalTime.MAX); }

    @Override
    public TurnoverReportVO turnoverStatistics(LocalDate begin, LocalDate end) {
        List<LocalDate> dates = buildDateList(begin, end);
        List<Double> turnovers = new ArrayList<>();
        for (LocalDate d : dates) {
            BigDecimal t = workspaceMapper.getTurnover(dayStart(d), dayEnd(d));
            turnovers.add(t == null ? 0.0 : t.doubleValue());
        }
        return TurnoverReportVO.builder()
                .dateList(StringUtils.join(dates, ","))
                .turnoverList(StringUtils.join(turnovers, ","))
                .build();
    }

    @Override
    public UserReportVO userStatistics(LocalDate begin, LocalDate end) {
        List<LocalDate> dates = buildDateList(begin, end);
        List<Integer> totalUsers = new ArrayList<>();
        List<Integer> newUsers = new ArrayList<>();
        for (LocalDate d : dates) {
            Integer total = reportMapper.getTotalUserCount(dayEnd(d));
            Integer added = workspaceMapper.getNewUsers(dayStart(d), dayEnd(d));
            totalUsers.add(total == null ? 0 : total);
            newUsers.add(added == null ? 0 : added);
        }
        return UserReportVO.builder()
                .dateList(StringUtils.join(dates, ","))
                .totalUserList(StringUtils.join(totalUsers, ","))
                .newUserList(StringUtils.join(newUsers, ","))
                .build();
    }

    @Override
    public OrderReportVO ordersStatistics(LocalDate begin, LocalDate end) {
        List<LocalDate> dates = buildDateList(begin, end);
        List<Integer> orderCounts = new ArrayList<>();
        List<Integer> validCounts = new ArrayList<>();
        for (LocalDate d : dates) {
            Integer oc = workspaceMapper.getOrderCount(dayStart(d), dayEnd(d));
            Integer vc = workspaceMapper.getValidOrderCount(dayStart(d), dayEnd(d));
            orderCounts.add(oc == null ? 0 : oc);
            validCounts.add(vc == null ? 0 : vc);
        }
        int totalOrders = orderCounts.stream().mapToInt(Integer::intValue).sum();
        int validOrders = validCounts.stream().mapToInt(Integer::intValue).sum();
        double rate = totalOrders == 0 ? 0.0 : (double) validOrders / totalOrders;
        return OrderReportVO.builder()
                .dateList(StringUtils.join(dates, ","))
                .orderCountList(StringUtils.join(orderCounts, ","))
                .validOrderCountList(StringUtils.join(validCounts, ","))
                .totalOrderCount(totalOrders)
                .validOrderCount(validOrders)
                .orderCompletionRate(rate)
                .build();
    }

    @Override
    public SalesTop10ReportVO top10(LocalDate begin, LocalDate end) {
        List<GoodsSalesDTO> sales = reportMapper.getSalesTop10(dayStart(begin), dayEnd(end));
        List<String> names = sales.stream().map(GoodsSalesDTO::getName).collect(Collectors.toList());
        List<Integer> numbers = sales.stream().map(GoodsSalesDTO::getNumber).collect(Collectors.toList());
        return SalesTop10ReportVO.builder()
                .nameList(StringUtils.join(names, ","))
                .numberList(StringUtils.join(numbers, ","))
                .build();
    }

    @Override
    public void exportBusinessData(HttpServletResponse response) {
        // Implemented in Task 5.
        throw new UnsupportedOperationException("exportBusinessData implemented in Task 5");
    }
}
```

- [ ] **Step 5: Run the test to verify it passes**

Run: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test -Dtest=ReportServiceImplTest`
Expected: PASS (4 tests).

- [ ] **Step 6: Create ReportController**

Create `sky-take-out/sky-server/src/main/java/com/sky/controller/admin/ReportController.java`:

```java
package com.sky.controller.admin;

import com.sky.result.Result;
import com.sky.service.ReportService;
import com.sky.vo.OrderReportVO;
import com.sky.vo.SalesTop10ReportVO;
import com.sky.vo.TurnoverReportVO;
import com.sky.vo.UserReportVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;

@RestController("adminReportController")
@RequestMapping("/admin/report")
@Api(tags = "Admin statistics report")
@Slf4j
public class ReportController {

    @Autowired
    private ReportService reportService;

    @GetMapping("/turnoverStatistics")
    @ApiOperation("Turnover statistics")
    public Result<TurnoverReportVO> turnoverStatistics(
            @DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam LocalDate end) {
        return Result.success(reportService.turnoverStatistics(begin, end));
    }

    @GetMapping("/userStatistics")
    @ApiOperation("User statistics")
    public Result<UserReportVO> userStatistics(
            @DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam LocalDate end) {
        return Result.success(reportService.userStatistics(begin, end));
    }

    @GetMapping("/ordersStatistics")
    @ApiOperation("Orders statistics")
    public Result<OrderReportVO> ordersStatistics(
            @DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam LocalDate end) {
        return Result.success(reportService.ordersStatistics(begin, end));
    }

    @GetMapping("/top10")
    @ApiOperation("Sales top 10")
    public Result<SalesTop10ReportVO> top10(
            @DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam LocalDate end) {
        return Result.success(reportService.top10(begin, end));
    }

    @GetMapping("/export")
    @ApiOperation("Export business data report")
    public void export(HttpServletResponse response) {
        reportService.exportBusinessData(response);
    }
}
```

- [ ] **Step 7: Build to verify controller compiles**

Run: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test -Dtest=ReportServiceImplTest`
Expected: PASS, build SUCCESS.

- [ ] **Step 8: Commit**

```bash
git add sky-take-out/sky-server/src/main/java/com/sky/service/ReportService.java \
        sky-take-out/sky-server/src/main/java/com/sky/service/impl/ReportServiceImpl.java \
        sky-take-out/sky-server/src/main/java/com/sky/controller/admin/ReportController.java \
        sky-take-out/sky-server/src/test/java/com/sky/service/ReportServiceImplTest.java
git commit -m "feat(report): turnover/user/order/top10 statistics + ReportController

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 5: Excel export

**Files:**
- Modify: `sky-take-out/sky-server/src/main/java/com/sky/service/impl/ReportServiceImpl.java` (replace the `exportBusinessData` stub)

**Interfaces:**
- Consumes: `WorkspaceService.getBusinessData(DataOverViewQueryDTO)` (Task 3), `BusinessDataVO`.

- [ ] **Step 1: Implement exportBusinessData**

In `ReportServiceImpl.java`, add field injection for the workspace service and replace the stub. Add imports: `com.sky.dto.DataOverViewQueryDTO`, `com.sky.service.WorkspaceService`, `com.sky.vo.BusinessDataVO`, `org.apache.poi.xssf.usermodel.XSSFRow`, `org.apache.poi.xssf.usermodel.XSSFSheet`, `org.apache.poi.xssf.usermodel.XSSFWorkbook`, `javax.servlet.ServletOutputStream`, `java.io.IOException`.

Add the field:
```java
    @Autowired
    private WorkspaceService workspaceService;
```

Replace the stub method body with:
```java
    @Override
    public void exportBusinessData(HttpServletResponse response) {
        LocalDate begin = LocalDate.now().minusDays(30);
        LocalDate end = LocalDate.now().minusDays(1);

        DataOverViewQueryDTO overviewQuery = new DataOverViewQueryDTO();
        overviewQuery.setBegin(LocalDateTime.of(begin, LocalTime.MIN));
        overviewQuery.setEnd(LocalDateTime.of(end, LocalTime.MAX));
        BusinessDataVO overview = workspaceService.getBusinessData(overviewQuery);

        XSSFWorkbook workbook = new XSSFWorkbook();
        try {
            XSSFSheet sheet = workbook.createSheet("Business Report");

            XSSFRow title = sheet.createRow(0);
            title.createCell(0).setCellValue("Business Report: " + begin + " to " + end);

            XSSFRow overviewHeader = sheet.createRow(1);
            overviewHeader.createCell(1).setCellValue("Turnover");
            overviewHeader.createCell(2).setCellValue("Order Completion Rate");
            overviewHeader.createCell(3).setCellValue("New Users");
            overviewHeader.createCell(4).setCellValue("Valid Orders");
            overviewHeader.createCell(5).setCellValue("Unit Price");

            XSSFRow overviewRow = sheet.createRow(2);
            overviewRow.createCell(0).setCellValue("Overview (30 days)");
            overviewRow.createCell(1).setCellValue(overview.getTurnover());
            overviewRow.createCell(2).setCellValue(overview.getOrderCompletionRate());
            overviewRow.createCell(3).setCellValue(overview.getNewUsers());
            overviewRow.createCell(4).setCellValue(overview.getValidOrderCount());
            overviewRow.createCell(5).setCellValue(overview.getUnitPrice());

            XSSFRow detailHeader = sheet.createRow(4);
            detailHeader.createCell(0).setCellValue("Date");
            detailHeader.createCell(1).setCellValue("Turnover");
            detailHeader.createCell(2).setCellValue("Valid Orders");
            detailHeader.createCell(3).setCellValue("Order Completion Rate");
            detailHeader.createCell(4).setCellValue("Unit Price");
            detailHeader.createCell(5).setCellValue("New Users");

            int rowIdx = 5;
            LocalDate d = begin;
            while (!d.isAfter(end)) {
                DataOverViewQueryDTO dayQuery = new DataOverViewQueryDTO();
                dayQuery.setBegin(LocalDateTime.of(d, LocalTime.MIN));
                dayQuery.setEnd(LocalDateTime.of(d, LocalTime.MAX));
                BusinessDataVO day = workspaceService.getBusinessData(dayQuery);

                XSSFRow row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(d.toString());
                row.createCell(1).setCellValue(day.getTurnover());
                row.createCell(2).setCellValue(day.getValidOrderCount());
                row.createCell(3).setCellValue(day.getOrderCompletionRate());
                row.createCell(4).setCellValue(day.getUnitPrice());
                row.createCell(5).setCellValue(day.getNewUsers());
                d = d.plusDays(1);
            }

            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=businessReport.xlsx");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (IOException e) {
            log.error("Failed to export business data", e);
        } finally {
            try {
                workbook.close();
            } catch (IOException e) {
                log.error("Failed to close workbook", e);
            }
        }
    }
```

- [ ] **Step 2: Build the whole module**

Run: `cd sky-take-out && JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am test`
Expected: all tests pass (ReportMapperIT, WorkspaceServiceImplTest, ReportServiceImplTest, and the prior order-management tests), build SUCCESS. (`HttpClientTest` may fail if no live server is running — that is pre-existing and unrelated.)

- [ ] **Step 3: Smoke-test export + statistics against the running app**

Build the jar and run it (JDK 1.8), then with an admin token:
```bash
cd sky-take-out
JAVA_HOME=$JAVA_HOME mvn -q -pl sky-server -am package -DskipTests
JAVA_HOME=$JAVA_HOME java -jar sky-server/target/sky-server-1.0-SNAPSHOT.jar &   # background
# wait for startup, then:
TOKEN=$(curl -s -X POST -H "Content-Type: application/json" -d '{"username":"admin","password":"123456"}' http://localhost:8080/admin/employee/login | python3 -c "import sys,json;print(json.load(sys.stdin)['data']['token'])")
# turnover (last 30d)
curl -s -H "token: $TOKEN" "http://localhost:8080/admin/report/turnoverStatistics?begin=2026-05-23&end=2026-06-21"
# top10
curl -s -H "token: $TOKEN" "http://localhost:8080/admin/report/top10?begin=2026-05-23&end=2026-06-21"
# workspace
curl -s -H "token: $TOKEN" "http://localhost:8080/admin/workspace/overviewOrders"
# export -> save and check it is a valid xlsx (starts with PK zip magic)
curl -s -H "token: $TOKEN" "http://localhost:8080/admin/report/export" -o /tmp/report.xlsx
head -c 2 /tmp/report.xlsx | xxd   # expect: 504b (PK)
ls -l /tmp/report.xlsx             # expect non-zero size
```
Expected: turnover/top10 return non-empty comma-joined lists matching the seeded data; export saves a non-empty file starting with `PK`. Shut the app down afterward (`lsof -ti:8080 | xargs kill`).

- [ ] **Step 4: Commit**

```bash
git add sky-take-out/sky-server/src/main/java/com/sky/service/impl/ReportServiceImpl.java
git commit -m "feat(report): implement business-data Excel export via POI

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

## Self-Review

**Spec coverage:**
- Report turnover/user/order/top10 → Task 4. ✓
- ReportMapper getSalesTop10 + getTotalUserCount → Task 2. ✓
- Excel export (POI, no template, reuses getBusinessData) → Task 5. ✓
- Workspace impl + controller → Task 3. ✓
- 30-day completed-order seed → Task 1. ✓
- Per-day loop algorithm reusing WorkspaceMapper → Tasks 4/3. ✓
- Testing: ReportService Mockito (Task 4), WorkspaceService Mockito (Task 3), ReportMapper IT (Task 2), export smoke (Task 5). ✓
- Out of scope (payment, user-side, websocket) → not present. ✓

**Placeholder scan:** The Task 4 `exportBusinessData` stub throws `UnsupportedOperationException` deliberately and is replaced in Task 5 — not a plan placeholder. No "TBD"/"add error handling"/etc. The Task 5 smoke step flags one literal typo to avoid.

**Type consistency:** `getBusinessData(DataOverViewQueryDTO)` used in Tasks 3 and 5 (Task 3 Step 4 reconciles to the real interface signature). `getTurnover` returns `BigDecimal` — converted to double in both WorkspaceServiceImpl and ReportServiceImpl. `getSalesTop10(LocalDateTime,LocalDateTime)`, `getTotalUserCount(LocalDateTime)` consistent between Task 2 (definition) and Task 4 (use). ReportService signatures identical across interface, impl, controller, test. `StringUtils` = `org.apache.commons.lang.StringUtils` (2.6) throughout.

**Open reconciliation flagged in-plan:** Task 3 Step 4 — the `WorkspaceService.getBusinessData` parameter is the existing interface's (`DataOverViewQueryDTO`); impl/test/controller must match it. The interface is the source of truth.
