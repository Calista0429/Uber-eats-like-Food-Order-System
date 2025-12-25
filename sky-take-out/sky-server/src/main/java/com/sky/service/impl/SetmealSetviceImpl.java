package com.sky.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sky.constant.MessageConstant;
import com.sky.constant.StatusConstant;
import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageQueryDTO;
import com.sky.entity.Setmeal;
import com.sky.entity.SetmealDish;
import com.sky.exception.DeletionNotAllowedException;
import com.sky.mapper.SetmealDishMapper;
import com.sky.mapper.SetmealMapper;
import com.sky.result.PageResult;
import com.sky.service.SetmealSetvice;
import com.sky.vo.DishItemVO;
import com.sky.vo.SetmealVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class SetmealSetviceImpl implements SetmealSetvice {

    @Autowired
    private SetmealMapper setmealMapper;

    @Autowired
    private SetmealDishMapper setmealDishMapper;


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

    /**
     * 添加套餐
     * @param setmealDTO
     */
    public void save(SetmealDTO setmealDTO) {

        List<SetmealDish> setmealDishes = setmealDTO.getSetmealDishes();

        Setmeal setmeal = new Setmeal();
        setmeal.setStatus(StatusConstant.DISABLE);
        BeanUtils.copyProperties(setmealDTO, setmeal);
        setmealMapper.save(setmeal);

        Long setmealId = setmeal.getId();
        if(setmealDishes != null && setmealDishes.size() > 0) {
            setmealDishes.forEach(setmealDish -> {
                setmealDish.setSetmealId(setmealId);
            });
            setmealDishMapper.insertBatch(setmealDishes);
        }
    }

    /**
     * 套餐分页查询
     *
     * @return
     */
    public PageResult page(SetmealPageQueryDTO setmealPageQueryDTO) {
        PageHelper.startPage(setmealPageQueryDTO.getPage(), setmealPageQueryDTO.getPageSize());
        Page<Setmeal> page = setmealMapper.page(setmealPageQueryDTO);
        return new PageResult(page.getTotal(), page.getResult());
    }

    /**
     * 根据id查询套餐
     * @param id
     * @return
     */
    public SetmealVO queryById(Long id) {
        SetmealVO setmealVO = new SetmealVO();
        Setmeal setmeal = setmealMapper.queryById(id);
        BeanUtils.copyProperties(setmeal, setmealVO);
        List<SetmealDish> setmealDishes = setmealDishMapper.queryBySetmealId(id);
        setmealVO.setSetmealDishes(setmealDishes);
        return setmealVO;
    }

    /**
     * 批量删除套餐和菜品
     * @param ids
     */
    public void deleteBatchWithDish(List<Long> ids) {
        for(Long id : ids) {
            Setmeal setmeal = setmealMapper.queryById(id);
            Integer status = setmeal.getStatus();
            if (status == StatusConstant.DISABLE) {
                setmealMapper.deleteById(id);
                setmealDishMapper.deleteById(id);
            }
            else {
                throw new DeletionNotAllowedException(MessageConstant.SETMEAL_ON_SALE);
            }

        }
    }

    /**
     * 起售停售套餐
     *
     * @param status
     * @param id
     */
    public void startOrStop(Integer status, Long id) {
        setmealMapper.startOrStop(status, id);
    }

    /**
     * 修改套餐
     * @param setmealDTO
     */
    public void update(SetmealDTO setmealDTO) {
        setmealMapper.update(setmealDTO);
        setmealDishMapper.deleteById(setmealDTO.getId());
        Long setmealId = setmealDTO.getId();
        List<SetmealDish> setmealDishes = setmealDTO.getSetmealDishes();
        if(setmealDishes != null && setmealDishes.size() > 0) {
            setmealDishes.forEach(setmealDish -> {
                setmealDish.setSetmealId(setmealId);
            });
            setmealDishMapper.insertBatch(setmealDishes);
        }

    }

}
