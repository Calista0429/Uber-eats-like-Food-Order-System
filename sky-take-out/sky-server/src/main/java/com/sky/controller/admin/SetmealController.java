package com.sky.controller.admin;


import com.github.pagehelper.Page;
import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageQueryDTO;
import com.sky.entity.Setmeal;
import com.sky.result.PageResult;
import com.sky.result.Result;
import com.sky.service.SetmealSetvice;
import com.sky.vo.SetmealVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Positive;
import java.util.List;

@RestController("adminSetmealController")
@RequestMapping("/admin/setmeal")
@Slf4j
@Api(tags = "套餐相关接口")
public class SetmealController {
    @Autowired
    private SetmealSetvice setmealSetvice;

    /**
     * 添加套餐
     * @param setmealDTO
     * @return
     */
    @PostMapping
    @ApiOperation("添加套餐")
    @CachePut(cacheNames = "setmealCache", key = "#setmealDTO.categoryId")
    public Result save(@RequestBody SetmealDTO setmealDTO) {
        log.info("添加套餐{}", setmealDTO);
        setmealSetvice.save(setmealDTO);

        return Result.success();
    }

    /**
     * 套餐分页查询
     * @param setmealPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    @ApiOperation("套餐分页查询")
    public Result<PageResult> page(SetmealPageQueryDTO setmealPageQueryDTO) {
        log.info("套餐分页查询");
        PageResult pageResult = setmealSetvice.page(setmealPageQueryDTO);
        return Result.success(pageResult);
    }

    /**
     * 根据套餐id查询
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    @ApiOperation("根据id查询套餐")
    public Result<SetmealVO> queryById(@PathVariable Long id) {
        log.info("根据id查询套餐 {}", id);
        SetmealVO setmealVO = setmealSetvice.queryById(id);
        return Result.success(setmealVO);
    }

    /**
     * 批量删除套餐
     * @param ids
     * @return
     */
    @DeleteMapping
    @ApiOperation("批量删除套餐")
    @CacheEvict(cacheNames = "setmealCache", allEntries = true)
    public Result deleteBatchWithDish(@RequestParam List<Long> ids) {
        log.info("批量删除套餐{}", ids);
        setmealSetvice.deleteBatchWithDish(ids);
        return Result.success();

    }

    /**
     * 起售停售套餐
     * @param status
     * @param id
     * @return
     */
    @PostMapping("/status/{status}")
    @ApiOperation("起售停售套餐")
    @CacheEvict(cacheNames = "setmealCache", allEntries = true)
    public Result startOrStop(@PathVariable Integer status, Long id) {
        log.info("修改套餐状态为 {}", status == 1 ? "起售": "停售");
        setmealSetvice.startOrStop(status, id);
        return Result.success();
    }

    @PutMapping
    @ApiOperation("修改套餐")
    @CacheEvict(cacheNames = "setmealCache", allEntries = true)
    public Result update(@RequestBody SetmealDTO setmealDTO) {
        log.info("修改套餐{}", setmealDTO);
        setmealSetvice.update(setmealDTO);
        return Result.success();
    }
}
