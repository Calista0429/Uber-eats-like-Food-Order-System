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
