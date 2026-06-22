package com.sky.mapper;

import com.sky.dto.GoodsSalesDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface ReportMapper {

    /**
     * Top 10 best-selling goods (by quantity) among COMPLETED orders in the window.
     */
    List<GoodsSalesDTO> getSalesTop10(@Param("begin") LocalDateTime begin,
                                      @Param("end") LocalDateTime end);

    /**
     * Cumulative number of users created on or before the given instant.
     */
    @Select("select count(id) from user where create_time <= #{end}")
    Integer getTotalUserCount(LocalDateTime end);
}
