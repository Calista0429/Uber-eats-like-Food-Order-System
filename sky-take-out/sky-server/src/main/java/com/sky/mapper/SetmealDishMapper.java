package com.sky.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SetmealDishMapper {
    /**
     * 查询菜品关联的套餐
     * @param dishIds
     * @return
     */
    List<Long> SetmealIdsByDishIds(List<Long> dishIds);
}
