package com.sky.service;

import com.sky.dto.DishDTO;
import com.sky.dto.DishPageQueryDTO;
import com.sky.entity.Dish;
import com.sky.result.PageResult;
import com.sky.vo.DishVO;

public interface DishService {

    /**
     * 新增菜品和口味
     * @param dishDTO
     */
    void saveWithFlavor(DishDTO dishDTO);

    /**
     * 菜品分页查询
     * @param dishPageQueryDTO
     * @return
     */
    PageResult page(DishPageQueryDTO dishPageQueryDTO);

    /**
     * 根据菜品分类ID查询
     * @param categoryId
     */
    void queryByCategoryId(String categoryId);

    /**
     * 更新菜品
     */
    void update(DishDTO dishVO);

    /**
     * 根据id查询菜品，用来数据回显
     *
     * @param id
     * @return
     */
    Dish getByDishId(Long id);

    /**
     * 根据id查询菜品及其口味
     * @param id
     * @return
     */
    DishVO getByIdWithFlavor(Long id);

    /**
     * 修改菜品状态信息
     * @param status
     * @param id
     */
    void status(Integer status, Long id);
}
