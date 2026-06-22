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
