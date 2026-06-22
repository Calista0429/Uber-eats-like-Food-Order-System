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
