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

import java.time.LocalDate;
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
