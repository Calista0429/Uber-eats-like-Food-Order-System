package com.sky.service.impl;

import com.sky.dto.DataOverViewQueryDTO;
import com.sky.mapper.WorkspaceMapper;
import com.sky.service.WorkspaceService;
import com.sky.vo.BusinessDataVO;
import com.sky.vo.DishOverViewVO;
import com.sky.vo.OrderOverViewVO;
import com.sky.vo.SetmealOverViewVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
@Slf4j
public class WorkspaceServiceImpl implements WorkspaceService {

    @Autowired
    private WorkspaceMapper workspaceMapper;

    @Override
    public BusinessDataVO getBusinessData(DataOverViewQueryDTO dto) {
        LocalDateTime begin = dto.getBegin();
        LocalDateTime end = dto.getEnd();

        BigDecimal turnoverBd = workspaceMapper.getTurnover(begin, end);
        double turnover = turnoverBd == null ? 0.0 : turnoverBd.doubleValue();
        Integer totalOrders = workspaceMapper.getOrderCount(begin, end);
        Integer validOrders = workspaceMapper.getValidOrderCount(begin, end);
        Integer newUsers = workspaceMapper.getNewUsers(begin, end);

        double completionRate = (totalOrders == null || totalOrders == 0)
                ? 0.0 : validOrders.doubleValue() / totalOrders;
        double unitPrice = (validOrders == null || validOrders == 0)
                ? 0.0 : turnover / validOrders;

        return BusinessDataVO.builder()
                .turnover(turnover)
                .validOrderCount(validOrders == null ? 0 : validOrders)
                .orderCompletionRate(completionRate)
                .unitPrice(unitPrice)
                .newUsers(newUsers == null ? 0 : newUsers)
                .build();
    }

    @Override
    public OrderOverViewVO getOverviewOrders() {
        return OrderOverViewVO.builder()
                .waitingOrders(workspaceMapper.getWaitingOrders())
                .deliveredOrders(workspaceMapper.getDeliveredOrders())
                .completedOrders(workspaceMapper.getCompletedOrders())
                .cancelledOrders(workspaceMapper.getCancelledOrders())
                .allOrders(workspaceMapper.getAllOrders())
                .build();
    }

    @Override
    public DishOverViewVO getOverviewDishes() {
        return DishOverViewVO.builder()
                .sold(workspaceMapper.getSoldDishes())
                .discontinued(workspaceMapper.getDiscontinuedDishes())
                .build();
    }

    @Override
    public SetmealOverViewVO getOverviewSetmeals() {
        return SetmealOverViewVO.builder()
                .sold(workspaceMapper.getSoldSetmeals())
                .discontinued(workspaceMapper.getDiscontinuedSetmeals())
                .build();
    }
}
