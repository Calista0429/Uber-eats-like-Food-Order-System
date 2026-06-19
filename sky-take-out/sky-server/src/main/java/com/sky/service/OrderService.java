package com.sky.service;

import com.sky.dto.OrdersPageQueryDTO;
import com.sky.dto.OrdersSubmitDTO;
import com.sky.result.PageResult;
import com.sky.vo.OrderStatisticsVO;
import com.sky.vo.OrderSubmitVO;
import com.sky.vo.OrderVO;

public interface OrderService {

    /**
     * 用户下单
     * @param ordersSubmitDTO
     * @return
     */
    OrderSubmitVO submitOrder(OrdersSubmitDTO ordersSubmitDTO);

    /** Counts of orders awaiting action. */
    OrderStatisticsVO statistics();

    /** Order detail with its line items. */
    OrderVO details(Long id);

    /** Paged conditional search for the admin order list. */
    PageResult conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO);
}


