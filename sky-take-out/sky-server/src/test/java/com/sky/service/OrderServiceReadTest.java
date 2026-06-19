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

    @Test
    void details_missingOrder_throws() {
        when(orderMapper.getById(99L)).thenReturn(null);
        assertThrows(com.sky.exception.OrderBusinessException.class, () -> orderService.details(99L));
    }
}
