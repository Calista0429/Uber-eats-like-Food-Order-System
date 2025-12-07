package com.sky.mapper;

import com.github.pagehelper.Page;
import com.sky.annotation.AutoFill;
import com.sky.dto.CategoryPageQueryDTO;
import com.sky.entity.Category;
import com.sky.enumeration.OperationType;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CategoryMapper {
    /**
     * 种类分页查询
     * @param categoryPageQueryDTO
     * @return
     */
    Page<Category> pageQuery(CategoryPageQueryDTO categoryPageQueryDTO);

    /**
     * 新增分类
      * @param category
     */
    @AutoFill(value = OperationType.INSERT)
    @Insert("INSERT INTO category (name, type, sort, status, create_time, update_time, create_user, update_user) " +
            "VALUES" +
            "(#{name}, #{type}, #{sort}, #{status}, #{createTime}, #{updateTime}, #{createUser}, #{updateUser})")
    void insert(Category category);

    /**
     * 更新分类
     * @param category
     */
    @AutoFill(value = OperationType.UPDATE)
    void update(Category category);

    /**
     * 根据类别查询
     * @param type
     * @return
     */
    List<Category> typeQuery(Integer type);


    /**
     * 根据id删除类别
     * @param id
     */
    @Delete("delete from category where id = #{id}")
    void deleteById(Long id);

}
