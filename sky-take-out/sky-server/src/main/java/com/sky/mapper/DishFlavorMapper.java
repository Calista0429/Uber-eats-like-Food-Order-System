package com.sky.mapper;

import com.sky.entity.DishFlavor;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface DishFlavorMapper {
    /**
     * 批量插入口味数据
     * @param flavors
     */
    void insertBatch(List<DishFlavor> flavors);

    /**
     * 批量更新口味数据
     * @param flavors
     */
    void updateBatch(List<DishFlavor> flavors);

    /**
     * 通过id获取口味
     * @param id
     * @return
     */
    @Select("SELECT * from dish_flavor where dish_id = #{id}")
    List<DishFlavor> getByDishId(Long id);

    @Delete("DELETE From dish_flavor where dish_id = #{dishId}")
    void deleteByDishId(Long dishId);
}
