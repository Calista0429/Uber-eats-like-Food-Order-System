package com.sky.mapper;

import com.github.pagehelper.Page;
import com.sky.dto.CategoryPageQueryDTO;
import com.sky.entity.Category;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

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
    @Insert("INSERT INTO category (name, type, sort, status, create_time, update_time, create_user, update_user) " +
            "VALUES" +
            "(#{name}, #{type}, #{sort}, #{status}, #{createTime}, #{updateTime}, #{createUser}, #{updateUser})")
    void insert(Category category);

    /**
     * 更新分类
     * @param category
     */
    void update(Category category);

    List<Category> typeQuery(Integer type);

    /**
     * 根据种类查询
     *
     * @param type
     * @return
     */


}
