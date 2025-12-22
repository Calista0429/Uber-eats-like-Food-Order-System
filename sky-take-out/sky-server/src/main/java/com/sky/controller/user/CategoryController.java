package com.sky.controller.user;

import com.sky.entity.Category;
import com.sky.result.Result;
import com.sky.service.CategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController("userCategoryController")
@Api(tags = "C端分类接口")
@Slf4j
@RequestMapping("/user/category")
public class CategoryController {

    @Autowired
    CategoryService categoryService;

    /**
     * 根据种类查询
     * @param type
     * @return
     */
    @GetMapping("/list")
    @ApiOperation("根据种类查询")
    public Result<List<Category>> queryByType(Integer type){
        log.info("根据类型查询 {}", type);
        List<Category> list = categoryService.typeQuery(type);
        return Result.success(list);
    }

}
