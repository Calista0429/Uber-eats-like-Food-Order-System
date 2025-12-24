package com.sky.service;

import com.sky.entity.Dish;
import com.sky.entity.Setmeal;
import com.sky.vo.DishItemVO;


import java.util.List;


public interface SetmealSetvice {

    List<Setmeal> list(Setmeal setmeal);

    List<DishItemVO> getDishItemById(String setmealId);
}
