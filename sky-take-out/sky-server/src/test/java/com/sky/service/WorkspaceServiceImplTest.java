package com.sky.service;

import com.sky.dto.DataOverViewQueryDTO;
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

        DataOverViewQueryDTO dto = DataOverViewQueryDTO.builder()
                .begin(LocalDateTime.now())
                .end(LocalDateTime.now())
                .build();
        BusinessDataVO vo = workspaceService.getBusinessData(dto);

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

        DataOverViewQueryDTO dto = DataOverViewQueryDTO.builder()
                .begin(LocalDateTime.now())
                .end(LocalDateTime.now())
                .build();
        BusinessDataVO vo = workspaceService.getBusinessData(dto);

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
