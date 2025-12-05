package com.sky.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface SetmealMapper {

    /**
     * 根据类别id查询关联的套餐
     * @param id
     * @return
     */
    @Select("SELECT count(id) from setmeal where category_id = #{category_id}")
    Integer countByCategoryId(Long id);
}
