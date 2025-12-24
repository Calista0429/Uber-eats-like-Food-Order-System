package com.sky.mapper;

import com.sky.annotation.AutoFill;
import com.sky.entity.SetmealDish;
import com.sky.enumeration.OperationType;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
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

    /**
     * 批量插入套餐中的菜品信息
     * @param setmealDishes
     */
    void insertBatch(List<SetmealDish> setmealDishes);

    /**
     * 删除套餐以及菜品
     * @param id
     */
    @Delete("DELETE From setmeal_dish where setmeal_id = #{id}")
    void deleteById(Long id);
}
