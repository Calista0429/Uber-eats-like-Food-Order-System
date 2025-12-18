package com.sky.controller.user;


import com.sky.result.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

@RestController("userShopController")
@Api(tags = "店铺相关接口")
@Slf4j
@RequestMapping("/user/shop")

public class ShopController {

    @Autowired
    private RedisTemplate redisTemplate;

    private final static String KEY_PREFIX = "SHOP_STATUS";

    /**
     * 查询店铺状态
     * @return
     */
    @ApiOperation("查询店铺状态")
    @GetMapping("/status")
    public Result<Integer> getStatus() {
        Integer status = (Integer) redisTemplate.opsForValue().get(KEY_PREFIX);
        log.info("店铺状态为 {}", status == 1 ? "营业中": "打烊中");
        return Result.success(status);
    }
}
