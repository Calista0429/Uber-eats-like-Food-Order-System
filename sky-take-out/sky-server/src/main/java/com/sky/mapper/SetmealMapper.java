package com.sky.mapper;

import com.sky.entity.Dish;
import com.sky.entity.Setmeal;
import com.sky.vo.DishItemVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface SetmealMapper {

    /**
     * 根据类别id查询关联的套餐
     * @param id
     * @return
     */
    @Select("SELECT count(id) from setmeal where category_id = #{category_id}")
    Integer countByCategoryId(Long id);

    /**
     * 根据种类id查询套餐
     * @param setmeal
     * @return
     */
    @Select("SELECT * FROM setmeal WHERE category_id = #{categoryId}")
    List<Setmeal> list(Setmeal setmeal);


    List<DishItemVO> getDishItemById(String setmealId);
}
