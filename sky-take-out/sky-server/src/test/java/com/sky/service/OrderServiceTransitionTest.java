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
