package com.sky.service;

import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageQueryDTO;
import com.sky.entity.Setmeal;
import com.sky.result.PageResult;
import com.sky.vo.DishItemVO;
import com.sky.vo.SetmealVO;


import java.util.List;


public interface SetmealSetvice {

    List<Setmeal> list(Setmeal setmeal);

    List<DishItemVO> getDishItemById(String setmealId);

    void save(SetmealDTO setmealDTO);

    PageResult page(SetmealPageQueryDTO setmealPageQueryDTO);

    SetmealVO queryById(Long id);

    void deleteBatchWithDish(List<Long> ids);
}
