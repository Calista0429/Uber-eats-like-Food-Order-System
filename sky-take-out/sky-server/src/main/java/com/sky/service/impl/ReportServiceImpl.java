package com.sky.service.impl;

import com.sky.dto.DataOverViewQueryDTO;
import com.sky.dto.GoodsSalesDTO;
import com.sky.mapper.ReportMapper;
import com.sky.mapper.WorkspaceMapper;
import com.sky.service.ReportService;
import com.sky.service.WorkspaceService;
import com.sky.vo.BusinessDataVO;
import com.sky.vo.OrderReportVO;
import com.sky.vo.SalesTop10ReportVO;
import com.sky.vo.TurnoverReportVO;
import com.sky.vo.UserReportVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
    @Autowired
    private WorkspaceService workspaceService;

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
}
