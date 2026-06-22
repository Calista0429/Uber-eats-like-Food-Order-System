# Data Statistics (Report + Workspace) — Design

**Date:** 2026-06-22
**Status:** Approved for implementation
**Scope:** Backend (`sky-server`) only. WeChat Pay, user-side endpoints, and WebSocket are out of scope.

## 1. Goal

Implement the admin data-statistics backend:
- **Report module** — turnover / user / order trend statistics, sales Top 10, and an Excel export of business data.
- **Workspace module** — today's business-data overview plus order/dish/setmeal overviews (interface + mapper already exist; only impl + controller are missing).
- **Demo data** — seed ~60 completed orders spread across the past 30 days so the trend charts and Top 10 have meaningful data.

## 2. Current State (scaffolding already present)

- **VOs (reuse as-is, do not recreate):** `TurnoverReportVO` (dateList, turnoverList), `UserReportVO` (dateList, totalUserList, newUserList), `OrderReportVO` (dateList, orderCountList, validOrderCountList, totalOrderCount, validOrderCount, orderCompletionRate), `SalesTop10ReportVO` (nameList, numberList), `BusinessDataVO` (turnover, validOrderCount, orderCompletionRate, unitPrice, newUsers), `OrderOverViewVO` (waitingOrders, deliveredOrders, completedOrders, cancelledOrders, allOrders), `DishOverViewVO` (sold, discontinued), `SetmealOverViewVO` (sold, discontinued).
- **DTO:** `DataOverViewQueryDTO` (begin, end — `LocalDateTime`). `GoodsSalesDTO` (name, number).
- **`WorkspaceMapper` — fully implemented** with: `getTurnover(begin,end)`, `getValidOrderCount(begin,end)`, `getOrderCount(begin,end)`, `getNewUsers(begin,end)`, `getWaitingOrders()`, `getDeliveredOrders()`, `getCompletedOrders()`, `getCancelledOrders()`, `getAllOrders()`, `getSoldDishes()`, `getDiscontinuedDishes()`, `getSoldSetmeals()`, `getDiscontinuedSetmeals()`. (Note: `getTurnover`/`getValidOrderCount` filter `status = 5` (COMPLETED); `getNewUsers` counts `user.create_time` in range.)
- **`WorkspaceService` interface declared** (getBusinessData, getOverviewOrders, getOverviewDishes, getOverviewSetmeals) — **no impl**.
- **No Report classes at all** (no ReportController/Service/Mapper).
- POI (`poi`, `poi-ooxml` 3.16) is a dependency of `sky-server`.
- Order status constants on `Orders`: COMPLETED=5, etc. `user` table has `create_time datetime`.

## 3. Module 1 — Report

New `controller/admin/ReportController.java` (`@RequestMapping("/admin/report")`), `service/ReportService.java`, `service/impl/ReportServiceImpl.java`, `mapper/ReportMapper.java` (+ `ReportMapper.xml`).

### Algorithm
For trend endpoints: build an inclusive list of `LocalDate` from `begin` to `end`. For each day, query aggregates for the window `[day 00:00:00, day 23:59:59]`, reusing `WorkspaceMapper`. Join parallel value lists with `org.apache.commons.lang3.StringUtils.join(list, ",")`.

### Endpoints

| Verb & path | Input | Output | Logic |
|---|---|---|---|
| `GET /admin/report/turnoverStatistics` | `begin`,`end` (`@DateTimeFormat ISO date`) | `Result<TurnoverReportVO>` | per-day `WorkspaceMapper.getTurnover(dayStart,dayEnd)` (null → 0.0) |
| `GET /admin/report/userStatistics` | `begin`,`end` | `Result<UserReportVO>` | per-day newUsers via `getNewUsers`; totalUsers via new `ReportMapper.getTotalUserCount(dayEnd)` (cumulative `create_time <= dayEnd`) |
| `GET /admin/report/ordersStatistics` | `begin`,`end` | `Result<OrderReportVO>` | per-day `getOrderCount` + `getValidOrderCount`; totals = sums; completionRate = validTotal/orderTotal (0 if orderTotal==0) |
| `GET /admin/report/top10` | `begin`,`end` | `Result<SalesTop10ReportVO>` | new `ReportMapper.getSalesTop10(begin,end)` → `List<GoodsSalesDTO>`, split into nameList/numberList |
| `GET /admin/report/export` | — | writes `.xlsx` to `HttpServletResponse` | see Excel below |

`begin`/`end` are `LocalDate` request params (`@DateTimeFormat(pattern = "yyyy-MM-dd")`); day windows use `LocalDateTime.of(date, LocalTime.MIN/MAX)`.

### New ReportMapper queries (XML)
- `List<GoodsSalesDTO> getSalesTop10(LocalDateTime begin, LocalDateTime end)`:
  `select od.name name, sum(od.number) number from order_detail od join orders o on od.order_id = o.id where o.status = 5 and o.order_time between #{begin} and #{end} group by od.name order by number desc limit 10`
- `Integer getTotalUserCount(LocalDateTime end)`: `select count(id) from user where create_time <= #{end}` (`@Select` annotation is fine — no existing UserMapper XML conflict because this lives on ReportMapper).

### Excel export
`GET /admin/report/export` builds a workbook from scratch with POI `XSSFWorkbook` (no template file):
- Overview block: last 30 days (`today-30` .. `yesterday`), values from `workspaceService.getBusinessData(begin,end)` → turnover, orderCompletionRate, newUsers, validOrderCount, unitPrice.
- Detail block: one row per day with that day's turnover, validOrderCount, completionRate, unitPrice, newUsers (call `getBusinessData(dayStart,dayEnd)` per day).
- Set `response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")`, write `workbook.write(response.getOutputStream())`, close workbook & stream.

## 4. Module 2 — Workspace

New `service/impl/WorkspaceServiceImpl.java` (implements existing `WorkspaceService`, autowires existing `WorkspaceMapper`) and `controller/admin/WorkSpaceController.java` (`@RequestMapping("/admin/workspace")`).

### Service logic
- `getBusinessData(begin,end)`: turnover = `getTurnover` (null→0.0); totalOrders = `getOrderCount`; validOrders = `getValidOrderCount`; completionRate = validOrders/totalOrders (0 if totalOrders==0); unitPrice = turnover/validOrders (0 if validOrders==0); newUsers = `getNewUsers`. Returns `BusinessDataVO`.
- `getOverviewOrders()` → `OrderOverViewVO` from the five count queries.
- `getOverviewDishes()` → `DishOverViewVO` (sold/discontinued).
- `getOverviewSetmeals()` → `SetmealOverViewVO` (sold/discontinued).

### Endpoints
| Verb & path | Output |
|---|---|
| `GET /admin/workspace/businessData` | `Result<BusinessDataVO>` (today = `[now 00:00, now 23:59:59]`) |
| `GET /admin/workspace/overviewOrders` | `Result<OrderOverViewVO>` |
| `GET /admin/workspace/overviewDishes` | `Result<DishOverViewVO>` |
| `GET /admin/workspace/overviewSetmeals` | `Result<SetmealOverViewVO>` |

## 5. Module 3 — Demo data

Re-runnable `db/seed-history-orders.sql` (generated by a Python script reading seeded dish ids, same pattern as `db/seed-orders.sql`):
- ~60 orders, `status=5` (COMPLETED), `pay_status=1`, `user_id=4`, `address_book_id=2`.
- `order_time` and `delivery_time` distributed across the past 30 days (≈2 orders/day with random hour).
- Each order has 2–3 `order_detail` rows referencing real seeded dishes (name/image/dish_id/number/amount); `amount` = sum of details.
- Idempotent: guarded by `orders.number` (prefix `HIST...`) via `WHERE NOT EXISTS`; appends, does not modify existing rows.

## 6. Testing (TDD)

- **`ReportServiceImpl` (Mockito, mock WorkspaceMapper + ReportMapper):**
  - turnoverStatistics: 3-day range → dateList has 3 dates, turnoverList has 3 comma-joined values; null turnover renders as 0.0.
  - ordersStatistics: totals are sums; completionRate = valid/total; total==0 → rate 0.
  - userStatistics: totalUserList uses cumulative counts, newUserList uses per-day new.
  - top10: GoodsSalesDTO list → nameList/numberList split and aligned.
- **`WorkspaceServiceImpl` (Mockito, mock WorkspaceMapper):**
  - getBusinessData: unitPrice = turnover/validOrders; validOrders==0 → unitPrice 0 and completionRate 0.
  - overview methods map mapper counts into the right VO fields.
- **`ReportMapper` (`@SpringBootTest @Transactional` against seeded dev DB):** getSalesTop10 returns ≤10 rows ordered by number desc; getTotalUserCount(end) ≥ 0.
- **Excel export:** end-to-end smoke — start app, GET `/admin/report/export` with admin token, assert HTTP 200, `Content-Type` is the xlsx mime, and body bytes are non-empty / begin with the ZIP magic (`PK`).

## 7. Deliverables
- `db/seed-history-orders.sql` (+ generator).
- `mapper/ReportMapper.java` (+ `ReportMapper.xml`).
- `service/ReportService.java`, `service/impl/ReportServiceImpl.java`, `controller/admin/ReportController.java`.
- `service/impl/WorkspaceServiceImpl.java`, `controller/admin/WorkSpaceController.java`.
- Service unit tests + ReportMapper integration test.

## 8. Constraints / Notes
- Build/test under JDK 1.8 (`JAVA_HOME=.../jdk1.8.0_311`); the machine default JDK breaks Lombok.
- Test source files must be added with `git add -f` only if `.gitignore` still ignores them — the order-management branch already removed those patterns, so this should no longer be needed.
- Reuse existing VOs/DTOs; create none beyond the listed mapper/service/controller files.
