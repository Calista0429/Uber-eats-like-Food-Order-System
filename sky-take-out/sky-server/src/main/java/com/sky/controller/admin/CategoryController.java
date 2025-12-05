package com.sky.controller.admin;


import com.sky.dto.CategoryDTO;
import com.sky.dto.CategoryPageQueryDTO;
import com.sky.entity.Category;
import com.sky.result.PageResult;
import com.sky.result.Result;
import com.sky.service.CategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/category")
@Api(tags = "分类相关接口")
@Slf4j
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    /**
     * 类型分页查询
     * @param categoryPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    @ApiOperation("类型分页查询")
    public Result<PageResult> page (CategoryPageQueryDTO categoryPageQueryDTO){
        log.info("类型分页查询: {}", categoryPageQueryDTO);
        PageResult pageResult = categoryService.pageQuery(categoryPageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 添加分类
     * @param categoryDTO
     * @return
     */
    @PostMapping
    @ApiOperation("新增分类")
    public Result save(@RequestBody CategoryDTO categoryDTO){
        log.info("新增分类参数: {}", categoryDTO);
        categoryService.save(categoryDTO);
        return Result.success();
    }

    /**
     * 修改分类
     * @param categoryDTO
     * @return
     */
    @PutMapping
    @ApiOperation("修改分类")
    public Result update(@RequestBody CategoryDTO categoryDTO){
        log.info("修改分类参数: {}", categoryDTO);
        categoryService.update(categoryDTO);
        return Result.success();

    }

    /**
     * 启用禁用分类
     * @param status
     * @param id
     * @return
     */
    @PostMapping("/status/{status}")
    @ApiOperation("启用禁用分类")
    public Result startOrStop (@PathVariable Integer status, Long id){
        log.info("启用禁用分类 {}, {}", status, id);
        categoryService.status(status, id);
        return Result.success();
    }

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
