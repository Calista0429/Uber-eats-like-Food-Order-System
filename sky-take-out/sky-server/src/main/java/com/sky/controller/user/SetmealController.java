package com.sky.controller.user;


import com.sky.constant.StatusConstant;
import com.sky.dto.SetmealDTO;
import com.sky.entity.Dish;
import com.sky.entity.Setmeal;
import com.sky.mapper.SetmealMapper;
import com.sky.result.Result;
import com.sky.service.SetmealSetvice;
import com.sky.vo.DishItemVO;
import com.sky.vo.SetmealVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("/user/setmeal")
@Slf4j
@RestController
@Api(tags = "C端套餐接口")
public class SetmealController {

    @Autowired
    private SetmealSetvice setmealSetvice;


    /**
     * 根据种类id获取套餐信息
     * @param categoryId
     * @return
     */
    @GetMapping("/list")
    @ApiOperation("根据分类id查询套餐")
    public Result<List<Setmeal>> list(Long categoryId){
        log.info("根据种类id获取套餐 {}", categoryId);
        Setmeal setmeal = new Setmeal();
        setmeal.setCategoryId(categoryId);
        setmeal.setStatus(StatusConstant.ENABLE);
        List<Setmeal> setmeals = setmealSetvice.list(setmeal);
        return Result.success(setmeals);
    }

    /**
     * 根据套餐id查询包含的菜品
     * @param setmealId
     * @return
     */
    @GetMapping("/dish/{id}")
    @ApiOperation("根据套餐id查询包含的菜品")
    public Result<List<DishItemVO>> getDishItemById(@PathVariable("id") String setmealId){
        List<DishItemVO> dishItemVOList = setmealSetvice.getDishItemById(setmealId);
        return Result.success(dishItemVOList);
    }


}
