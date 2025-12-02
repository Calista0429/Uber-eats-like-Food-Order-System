package com.sky.service;

import com.sky.dto.OrdersPageQueryDTO;
import com.sky.result.PageResult;
import com.sky.vo.OrderVO;

public interface OrderService {

    /**
     * 条件搜索订单
     */
    PageResult conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO);
}

