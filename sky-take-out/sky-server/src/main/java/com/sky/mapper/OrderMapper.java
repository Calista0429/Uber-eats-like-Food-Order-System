package com.sky.mapper;

import com.github.pagehelper.Page;
import com.sky.dto.GoodsSalesDTO;
import com.sky.dto.OrdersPageQueryDTO;
import com.sky.entity.Orders;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {
    /**
     * 插入订单数据
     * @param order
     */
    void insert(Orders order);

    /**
     * Paged conditional query for the admin order list.
     */
    Page<Orders> pageQuery(OrdersPageQueryDTO ordersPageQueryDTO);

    /**
     * Look up a single order by id.
     */
    @Select("select * from orders where id = #{id}")
    Orders getById(Long id);

    /**
     * Dynamic update of an order (status / reasons / times).
     */
    void update(Orders orders);

    /**
     * Count orders in a given status.
     */
    @Select("select count(id) from orders where status = #{status}")
    Integer countStatus(Integer status);

}