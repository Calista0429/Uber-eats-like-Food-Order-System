package com.sky.mapper;

import com.sky.annotation.AutoFill;
import com.sky.entity.User;
import com.sky.enumeration.OperationType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper {

    /**
     * 用户查询
     * @param openid
     * @return
     */
    @Select("SELECT * FROM user WHERE openid=#{openId}")
    User getUserByOpenId(String openid);

//    @AutoFill(value = OperationType.INSERT)
    void save(User user);
}
