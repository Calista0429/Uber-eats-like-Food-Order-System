package com.sky.mapper;

import com.sky.dto.OrdersPageQueryDTO;
import com.sky.entity.Orders;
import com.sky.vo.OrderVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderMapper {

    /**
     * 条件搜索订单
     */
    List<OrderVO> conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO);
}


