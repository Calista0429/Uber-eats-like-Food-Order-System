package com.sky.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface DishMapper {

    /**
     * 根据类别id查询关联的菜品
     * @param category_id
     * @return
     */
    @Select("SELECT count(id) from dish where category_id = #{category_id}")
    Integer countByCategoryId(Long category_id);
}
