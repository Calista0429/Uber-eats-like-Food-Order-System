package com.sky.service.impl;

import com.sky.context.BaseContext;
import com.sky.dto.ShoppingCartDTO;
import com.sky.entity.Dish;
import com.sky.entity.Setmeal;
import com.sky.entity.ShoppingCart;
import com.sky.mapper.DishMapper;
import com.sky.mapper.SetmealMapper;
import com.sky.mapper.ShoppingCartMapper;
import com.sky.result.Result;
import com.sky.service.ShoppingCartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
public class ShoppingCartServiceImpl implements ShoppingCartService {

    @Autowired
    private ShoppingCartMapper shoppingCartMapper;

    @Autowired
    private DishMapper dishMapper;

    @Autowired
    private SetmealMapper setmealMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    String prefix_key = "shopping_cart:";


    /**
     * 添加购物车
     * @param shoppingCartDTO
     */
    public void add(ShoppingCartDTO shoppingCartDTO) {
        ShoppingCart shoppingCart = new ShoppingCart();
        BeanUtils.copyProperties(shoppingCartDTO, shoppingCart);
        Long currentId = BaseContext.getCurrentId();
        shoppingCart.setUserId(currentId);
        List<ShoppingCart> shoppingCartList =  shoppingCartMapper.list(shoppingCart);

        //如果存在，则添加一条数量并插入
        if (shoppingCartList.size() > 0) {
            ShoppingCart cart = shoppingCartList.get(0);
            cart.setNumber(cart.getNumber() + 1);
            shoppingCartMapper.update(cart);

        }else{
            //不存在，则插入新的数据
            Long dishId = shoppingCart.getDishId();
            Long setmealId = shoppingCart.getSetmealId();

            if (dishId == null) {
                //添加的是套餐
                Setmeal setmeal = setmealMapper.queryById(setmealId);

                shoppingCart.setImage(setmeal.getImage());
                shoppingCart.setAmount(setmeal.getPrice());
                shoppingCart.setName(setmeal.getName());

            }else{
                //添加的是菜品
                Dish dish = dishMapper.getByDishId(dishId);
                shoppingCart.setImage(dish.getImage());
                shoppingCart.setAmount(dish.getPrice());
                shoppingCart.setName(dish.getName());

            }
            shoppingCart.setNumber(1);
            shoppingCart.setCreateTime(LocalDateTime.now());
            shoppingCartMapper.insert(shoppingCart);

        }
        cleanCache(prefix_key);
    }

    /**
     * 查看购物车
     *
     * @return
     */
    public List<ShoppingCart> list() {

        Long currentId = BaseContext.getCurrentId();
        ShoppingCart shoppingCart = new ShoppingCart();
        shoppingCart.setUserId(currentId);
        String keys = prefix_key + currentId;
        Object list = redisTemplate.opsForValue().get(keys);


        if (list != null) {
            return (List<ShoppingCart>) list;
        }

        List<ShoppingCart> shoppingCartList = shoppingCartMapper.list(shoppingCart);
        redisTemplate.opsForValue().set(keys, shoppingCartList,3, TimeUnit.MINUTES);

        return shoppingCartList;
    }

    /**
     * 清空购物车
     */
    public void clean() {
        ShoppingCart shoppingCart = new ShoppingCart();
        shoppingCart.setUserId(BaseContext.getCurrentId());
        shoppingCartMapper.clean(shoppingCart);
        cleanCache(prefix_key);
    }

    /**
     * 删除购物车中的一个商品
     * @param shoppingCartDTO
     */
    public void deleteById(ShoppingCartDTO shoppingCartDTO) {

        //设置购物车属性
        ShoppingCart shoppingCart = new ShoppingCart();
        BeanUtils.copyProperties(shoppingCartDTO, shoppingCart);
        shoppingCart.setUserId(BaseContext.getCurrentId());

        //查询购物车数据并设置数量-1
        List<ShoppingCart> list = shoppingCartMapper.list(shoppingCart);
        ShoppingCart cart = list.get(0);

        Integer number = cart.getNumber();
        if (number > 1) {
            cart.setNumber(number - 1);
            shoppingCartMapper.update(cart);
        }
        else {
            shoppingCartMapper.deleteById(cart);
        }

        cleanCache(prefix_key);

    }
    private void cleanCache(String prefix_key) {
        String cacheKey = prefix_key + BaseContext.getCurrentId();
        redisTemplate.delete(cacheKey);
    }
}
