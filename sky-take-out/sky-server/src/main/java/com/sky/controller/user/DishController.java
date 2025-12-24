package com.sky.controller.user;

import com.sky.constant.StatusConstant;
import com.sky.dto.DishDTO;
import com.sky.entity.Dish;
import com.sky.result.Result;
import com.sky.service.DishService;
import com.sky.vo.DishVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController("userDishController")
@Api(tags = "C端套餐接口")
@Slf4j
@RequestMapping("/user/dish")
public class DishController {

    @Autowired
    DishService dishService;

    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * 根据菜品id查询
     * @param categoryId
     * @return
     */
    @GetMapping("/list")
    @ApiOperation("根据菜品种类id查询")
    public Result<List<DishVO>> queryByCategoryId(Long categoryId){
        Dish dish = new Dish();
        String key = "dish:" + categoryId;
        List<DishVO> list = (List<DishVO>) redisTemplate.opsForValue().get(key);
        if (list == null){
            dish.setCategoryId(categoryId);
            list = dishService.listwithflavor(dish);
            redisTemplate.opsForValue().set(key, list);
            return Result.success(list);
        }
        return Result.success(list);

    }
}

