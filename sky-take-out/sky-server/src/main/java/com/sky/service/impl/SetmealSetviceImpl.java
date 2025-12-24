package com.sky.service.impl;

import com.sky.entity.Dish;
import com.sky.entity.Setmeal;
import com.sky.mapper.SetmealMapper;
import com.sky.service.SetmealSetvice;
import com.sky.vo.DishItemVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@Slf4j
public class SetmealSetviceImpl implements SetmealSetvice {

    @Autowired
    SetmealMapper setmealMapper;


    /**
     * 根据分类id查询套餐
     * @param setmeal
     * @return
     */
    public List<Setmeal> list(Setmeal setmeal) {
        List<Setmeal> setmealList = setmealMapper.list(setmeal);
        return setmealList;
    }

    /**
     * 根据套餐id查询包含的菜品列表
     * @param setmealId
     * @return
     */
    public List<DishItemVO> getDishItemById(String setmealId) {
        return setmealMapper.getDishItemById(setmealId);
    }


}
