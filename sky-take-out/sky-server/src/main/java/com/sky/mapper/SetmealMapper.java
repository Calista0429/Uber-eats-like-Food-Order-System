package com.sky.mapper;

import com.github.pagehelper.Page;
import com.sky.annotation.AutoFill;
import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageQueryDTO;
import com.sky.entity.Dish;
import com.sky.entity.Setmeal;
import com.sky.enumeration.OperationType;
import com.sky.vo.DishItemVO;
import org.apache.ibatis.annotations.Insert;
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
    @Select("SELECT count(id) from setmeal where category_id = #{categoryId}")
    Integer countByCategoryId(Long id);

    /**
     * 根据种类id查询套餐
     * @param setmeal
     * @return
     */
    @Select("SELECT * FROM setmeal WHERE category_id = #{categoryId}")
    List<Setmeal> list(Setmeal setmeal);


    List<DishItemVO> getDishItemById(String setmealId);

    /**
     * 添加套餐
     * @param setmeal
     */
    @AutoFill(value = OperationType.INSERT)
    void save(Setmeal setmeal);

    Page<Setmeal> page(SetmealPageQueryDTO setmealPageQueryDTO);
}
