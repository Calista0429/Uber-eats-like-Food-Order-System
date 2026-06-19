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
