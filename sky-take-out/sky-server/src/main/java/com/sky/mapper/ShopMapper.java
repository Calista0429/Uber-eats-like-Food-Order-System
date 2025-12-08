package com.sky.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface ShopMapper {

    /**
     * 获取营业状态
     */
    @Select("select status from shop where id = 1")
    Integer getStatus();

    /**
     * 更新营业状态
     */
    @Update("update shop set status = #{status} where id = 1")
    void updateStatus(Integer status);
}


