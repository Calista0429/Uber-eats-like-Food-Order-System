package com.sky.mapper;

import com.github.pagehelper.Page;
import com.sky.annotation.AutoFill;
import com.sky.dto.DishPageQueryDTO;
import com.sky.entity.Dish;
import com.sky.enumeration.OperationType;
import com.sky.vo.DishVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface DishMapper {

    /**
     * 根据类别id查询关联的菜品
     * @param category_id
     * @return
     */
    @Select("SELECT count(id) from dish where category_id = #{categoryId}")
    Integer countByCategoryId(Long category_id);

    /**
     * 插入菜品注释
     * @param dish
     */
    @AutoFill(value = OperationType.INSERT)
    void insert(Dish dish);

    Page<DishVO> page(DishPageQueryDTO dishPageQueryDTO);

    /**
     * 根据菜品分类id查询
     * @param categoryId
     */
    @Select("SELECT * FROM dish WHERE category_id = #{categoryId}")
    List<Dish> queryByCategoryId(Long categoryId);

    /**
     * 更新菜品信息
     * @param dish
     */
    @AutoFill(value = OperationType.UPDATE)
    void update(Dish dish);

    /**
     * 根据菜品id查询
     * @param id
     * @return
     */
    @Select("SELECT * FROM dish WHERE id = #{id}")
    Dish getByDishId(Long id);

    /**
     * 根据菜品id删除
     * @param id
     */
    @Delete("Delete from dish where id = #{id}")
    void deleteById(Long id);

    @Select("SELECT * FROM dish where category_id = #{categoryId} and status != 0")
    List<Dish> list(Dish dish);
}
