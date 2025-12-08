package com.sky.mapper;

import com.sky.dto.DataOverViewQueryDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Mapper
public interface WorkspaceMapper {

    /**
     * 根据时间范围统计营业额
     */
    @Select("select sum(amount) from orders where order_time >= #{begin} and order_time <= #{end} and status = 5")
    BigDecimal getTurnover(LocalDateTime begin, LocalDateTime end);

    /**
     * 根据时间范围统计有效订单数
     */
    @Select("select count(id) from orders where order_time >= #{begin} and order_time <= #{end} and status = 5")
    Integer getValidOrderCount(LocalDateTime begin, LocalDateTime end);

    /**
     * 根据时间范围统计订单总数
     */
    @Select("select count(id) from orders where order_time >= #{begin} and order_time <= #{end}")
    Integer getOrderCount(LocalDateTime begin, LocalDateTime end);

    /**
     * 根据时间范围统计新增用户数
     */
    @Select("select count(id) from user where create_time >= #{begin} and create_time <= #{end}")
    Integer getNewUsers(LocalDateTime begin, LocalDateTime end);

    /**
     * 统计待接单数量
     */
    @Select("select count(id) from orders where status = 2")
    Integer getWaitingOrders();

    /**
     * 统计待派送数量
     */
    @Select("select count(id) from orders where status = 4")
    Integer getDeliveredOrders();

    /**
     * 统计已完成数量
     */
    @Select("select count(id) from orders where status = 5")
    Integer getCompletedOrders();

    /**
     * 统计已取消数量
     */
    @Select("select count(id) from orders where status = 6")
    Integer getCancelledOrders();

    /**
     * 统计全部订单数量
     */
    @Select("select count(id) from orders")
    Integer getAllOrders();

    /**
     * 统计已启售菜品数量
     */
    @Select("select count(id) from dish where status = 1")
    Integer getSoldDishes();

    /**
     * 统计已停售菜品数量
     */
    @Select("select count(id) from dish where status = 0")
    Integer getDiscontinuedDishes();

    /**
     * 统计已启售套餐数量
     */
    @Select("select count(id) from setmeal where status = 1")
    Integer getSoldSetmeals();

    /**
     * 统计已停售套餐数量
     */
    @Select("select count(id) from setmeal where status = 0")
    Integer getDiscontinuedSetmeals();
}


